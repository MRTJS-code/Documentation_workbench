

-- ========================================================
-- Author:		Tony Smith 
-- Create date: 2023-08-10 
-- Description:	stored proc for building dim_ax_coa
-- =========================================================
CREATE PROCEDURE [dw].[proc_dims_gt_gl_coa]
	-- Add the parameters for the stored procedure here
	@p_job int,  
	@p_run bigint,	
	@p_etl int	
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;

BEGIN

-- Drop temporary table if it exists
If(OBJECT_ID('tempdb..#tmpCOA') Is Not Null)
Begin
 DROP TABLE #tmpCOA
End

-- Add Foreign Key Links to staging Table
-- Branch match by Branch and Business
UPDATE				g
SET					g.FK_DIM_BRANCH = b.SK_DIM_BRANCH
FROM				staging.STG_GT_GLACCOUNT g
INNER JOIN			dw.DIM_BRANCH b on left(g.accountNo,2) = b.P_Branch AND SUBSTRING(g.accountNo,4,2) = b.[P_Business Code];

-- Branch match by Branch only
UPDATE				g
SET					g.FK_DIM_BRANCH = b.SK_DIM_BRANCH
FROM				staging.STG_GT_GLACCOUNT g
INNER JOIN			dw.DIM_BRANCH b on left(g.accountNo,2) = b.P_Branch AND b.[P_Business Code] is null AND g.FK_DIM_BRANCH is null;

-- no match default to 0
UPDATE				staging.STG_GT_GLACCOUNT
SET					FK_DIM_BRANCH = 0 WHERE FK_DIM_BRANCH is NULL;

-- Business match by Branch and Business
UPDATE				g
SET					g.FK_DIM_BUSINESS = b.SK_DIM_BUSINESS
FROM				staging.STG_GT_GLACCOUNT g
INNER JOIN			dw.DIM_BUSINESS b on left(g.accountNo,2) = b.P_Branch AND SUBSTRING(g.accountNo,4,2) = b.[P_Business Code];

-- Business match by Business only
UPDATE				g
SET					g.FK_DIM_BUSINESS = b.SK_DIM_BUSINESS
FROM				staging.STG_GT_GLACCOUNT g
INNER JOIN			dw.DIM_BUSINESS b on SUBSTRING(g.accountNo,4,2) = b.[P_Business Code] AND b.P_Branch is null AND g.FK_DIM_BUSINESS is null;

-- no match default to 0
UPDATE				staging.STG_GT_GLACCOUNT
SET					FK_DIM_BUSINESS = 0 WHERE FK_DIM_BUSINESS is NULL;

-- Build GT COA Temporary Table
SELECT				summ.coaNumber, summ.description, summ.modifiedDate, isnull(m.SK_DIM_AX_COA,0) FK_DIM_AX_COA
INTO				#tmpCOA
FROM (
SELECT				coaNumber, description, max(modifiedDate) modifiedDate, ROW_NUMBER() OVER (PARTITION BY coaNumber ORDER BY coaNumber, modifiedDate) rowNum
FROM (
SELECT				DISTINCT right(g.accountNo,5) coaNumber, g.description, cast(g.modifiedTimeStamp as date) modifiedDate
FROM				staging.STG_GT_GLACCOUNT g
WHERE				g.oid_instid != 28434  --internal id of an account setup incorrectly that is to be excluded
					) qry
GROUP BY			coaNumber, description, modifiedDate
					)summ
LEFT JOIN (			SELECT m.AccountNum, a.SK_DIM_AX_COA FROM lookup.GTAX_COA_Map m LEFT JOIN dw.DIM_AX_COA a ON m.AXAccountNum = a.P_Main_Account_Code
					) m ON summ.coaNumber = m.AccountNum
WHERE				summ.rowNum = 1;

-- Merge Into GT COA Dimension
MERGE INTO			dw.DIM_GT_COA t
USING				#tmpCOA s
ON					t.PK_GT_Account = s.coaNumber

WHEN MATCHED AND (	isnull(t.MD_DATE_MODIFIED, '1900-01-01') <= isnull(s.modifiedDate,'1900-01-01')
OR					isnull(t.FK_DIM_AX_COA,0) != isnull(s.FK_DIM_AX_COA,0)
					) THEN
UPDATE SET			t.PK_GT_Account = s.coaNumber,
					t.FK_DIM_AX_COA = s.FK_DIM_AX_COA,
					t.P_Account_Name = s.description,
					t.MD_DATE_MODIFIED = s.modifiedDate,
					t.MD_JOB_CODE = @p_job,
					t.MD_RUN_CODE = @p_run,
					t.MD_ETL_RUN = @p_etl,
					t.MD_LOGICAL_DELETE = 0

WHEN NOT MATCHED THEN
INSERT(				PK_GT_Account,
					FK_DIM_AX_COA,
					P_Account_Name,
					MD_DATE_MODIFIED,
					MD_JOB_CODE,
					MD_RUN_CODE,
					MD_ETL_RUN,
					MD_LOGICAL_DELETE)
VALUES (			s.coaNumber,
					s.FK_DIM_AX_COA,
					s.description,
					s.modifiedDate,
					@p_job,
					@p_run,
					@p_etl,
					0)
;

 --Match GLAccount to GT_COA
UPDATE				g
SET					g.FK_DIM_GT_COA = isnull(c.SK_DIM_GT_COA,0)
FROM				staging.STG_GT_GLACCOUNT g
LEFT JOIN			dw.DIM_GT_COA c ON right(g.accountNo,5) = c.PK_GT_Account;

-- Merge to GT GLAccount Dimension
MERGE INTO			dw.DIM_GT_GL t
USING				staging.STG_GT_GLACCOUNT s
ON					t.PK_oid_clsno = s.oid_clsno
AND					t.PK_oid_instid = s.oid_instid

WHEN MATCHED AND t.MD_DATE_MODIFIED <= s.modifiedTimeStamp THEN
UPDATE SET			t.FK_DIM_GT_COA = s.FK_DIM_GT_COA,
					t.FK_DIM_BRANCH = s.FK_DIM_BRANCH,
					t.FK_DIM_BUSINESS = s.FK_DIM_BUSINESS,
					t.PK_oid_clsno = s.oid_clsno,
					t.PK_oid_instid = s.oid_instid,
					t.P_Account_No = s.accountNo,
					t.P_Account_Name = s.description,
					t.P_Account_Type = s.accountType,
					t.P_Account_Status = s.accountStatus,
					t.MD_DATE_MODIFIED = s.modifiedTimeStamp,
					t.MD_MODIFIED_USER = s.modifiedUser,
					t.MD_JOB_CODE = @p_job,
					t.MD_RUN_CODE = @p_run,
					t.MD_ETL_RUN = @p_etl,
					t.MD_LOGICAL_DELETE = 0

WHEN NOT MATCHED THEN
INSERT (			FK_DIM_GT_COA,
					FK_DIM_BRANCH,
					FK_DIM_BUSINESS,
					PK_oid_clsno,
					PK_oid_instid,
					P_Account_No,
					P_Account_Name,
					P_Account_Type,
					P_Account_Status,
					MD_DATE_MODIFIED,
					MD_MODIFIED_USER,
					MD_JOB_CODE,
					MD_RUN_CODE,
					MD_ETL_RUN,
					MD_LOGICAL_DELETE)
VALUES (			s.FK_DIM_GT_COA,
					s.FK_DIM_BRANCH,
					s.FK_DIM_BUSINESS,
					s.oid_clsno,
					s.oid_instid,
					s.accountNo,
					s.description,
					s.accountType,
					s.accountStatus,
					s.modifiedTimeStamp,
					s.modifiedUser,
					@p_job,
					@p_run,
					@p_etl,
					0)
;
END
;
