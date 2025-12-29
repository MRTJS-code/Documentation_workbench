



-- ====================================================
-- Author:		Tony Smith
-- Create date: 2023-08-11
-- Description:	stored proc for building DIM_GT_PERIOD
-- ====================================================
CREATE PROCEDURE [dw].[proc_fact_gt_gltrans]
	-- Add the parameters for the stored procedure here
	@p_job int,  
	@p_run bigint,	
	@p_etl int	
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;
BEGIN

-- Generate temp table
SELECT				'Greentree' sourceSystem,
					cast(format(isnull(g.postingDate, p.P_Last_Date),'yyyyMMdd') as bigint) FK_DIM_DATE_POSTING,
					gl.SK_DIM_GT_GL FK_DIM_GT_GL,
					p.SK_DIM_GT_PERIOD FK_DIM_GT_PERIOD,
					c.SK_DIM_Cost_Activity FK_DIM_COST_ACTIVITY,
					j.SK_DIM_JOB FK_DIM_JOB,
					o.SK_DIM_Organisation FK_DIM_ORGANISATION,
					g.oid_clsno,
					g.oid_instid,
					g.reference,
					g.postingDate,
					g.documentDate,
					g.sourceTranType,
					g.detail,
					g.subCode,
					g.standardText,
					g.quantity,
					g.accountNetAmount,
					g.modifiedUser,
					Cast(g.modifiedTimeStamp as date) modifiedDate
INTO				#tmpGLTrans
FROM				staging.GT_GLTRANS g
INNER JOIN			dw.DIM_GT_PERIOD p on g.myPeriod_clsno = p.PK_oid_clsno AND g.myPeriod_instid = p.PK_oid_instid
INNER JOIN			dw.DIM_GT_GL gl ON g.myGLAccount_clsno = gl.PK_oid_clsno AND g.myGLAccount_instid = gl.PK_oid_instid
INNER JOIN			dw.DIM_COST_ACTIVITY c ON isnull(g.myCostActivity_clsno,0) = c.P_Oid_clsno AND isnull(g.myCostActivity_instid,0) = c.P_Oid_instid
INNER JOIN			dw.DIM_JOB j ON isnull(g.myJob_clsno,0) = j.P_oid_clsno AND isnull(g.myJob_instid,0) = j.P_oid_instid
INNER JOIN			dw.DIM_ORGANISATION o ON isnull(g.myOrganisation_clsno,0) = o.P_Oid_clsno AND isnull(g.myOrganisation_instid,0) = o.P_Oid_instid;

--- Merge tmp table into FACT_GLTRANS
MERGE INTO			dw.FACT_GLTRANS t
USING				#tmpGLTrans s
ON					t.PK_oid_clsno = s.oid_clsno
AND					t.PK_oid_instid = s.oid_instid
AND					t.PK_DW_Source_System = s.sourceSystem

WHEN MATCHED AND (	t.MD_DATE_MODIFIED <= s.modifiedDate
OR					t.FK_DIM_GT_GL = s.FK_DIM_GT_GL
OR					t.FK_DIM_COST_ACTIVITY = s.FK_DIM_COST_ACTIVITY
OR					t.FK_DIM_JOB = s.FK_DIM_JOB
OR					t.FK_DIM_ORGANISATION = s.FK_DIM_ORGANISATION
					) THEN
UPDATE SET			t.FK_DIM_DATE_POSTING = s.FK_DIM_DATE_POSTING,
					t.FK_DIM_GT_GL = s.FK_DIM_GT_GL,
					t.FK_DIM_GT_PERIOD = s.FK_DIM_GT_PERIOD,
					t.FK_DIM_COST_ACTIVITY = s.FK_DIM_COST_ACTIVITY,
					t.FK_DIM_JOB = s.FK_DIM_JOB,
					t.FK_DIM_ORGANISATION = s.FK_DIM_ORGANISATION,
					t.PK_DW_Source_System = s.sourceSystem,
					t.PK_oid_clsno = s.oid_clsno,
					t.PK_oid_instid = s.oid_instid,
					t.P_Reference = s.reference,
					t.P_Posting_Date = s.postingDate,
					t.P_Document_Date = s.documentDate,
					t.P_Transaction_Type = s.sourceTranType,
					t.P_Transaction_Detail = s.detail,
					t.P_Transaction_Subcode = s.subCode,
					t.P_Narration = s.standardText,
					t.P_Quantity = s.quantity,
					t.P_Amount_Net = s.accountNetAmount,
					t.MD_MODIFIED_USER = s.modifiedUser,
					t.MD_DATE_MODIFIED = s.modifiedDate,
					t.MD_JOB_CODE = @p_job,
					t.MD_RUN_CODE = @p_run,
					t.MD_ETL_RUN = @p_etl,
					t.MD_LOGICAL_DELETE = 0

WHEN NOT MATCHED THEN
INSERT (			FK_DIM_DATE_POSTING,
					FK_DIM_GT_GL,
					FK_DIM_GT_PERIOD,
					FK_DIM_COST_ACTIVITY,
					FK_DIM_JOB,
					FK_DIM_ORGANISATION,
					PK_DW_Source_System,
					PK_oid_clsno,
					PK_oid_instid,
					P_Reference,
					P_Posting_Date,
					P_Document_Date,
					P_Transaction_Type,
					P_Transaction_Detail,
					P_Transaction_Subcode,
					P_Narration,
					P_Quantity,
					P_Amount_Net,
					MD_MODIFIED_USER,
					MD_DATE_MODIFIED,
					MD_JOB_CODE,
					MD_RUN_CODE,
					MD_ETL_RUN,
					MD_LOGICAL_DELETE)
VALUES (			s.FK_DIM_DATE_POSTING,
					s.FK_DIM_GT_GL,
					s.FK_DIM_GT_PERIOD,
					s.FK_DIM_COST_ACTIVITY,
					s.FK_DIM_JOB,
					FK_DIM_ORGANISATION,
					s.sourceSystem,
					s.oid_clsno,
					s.oid_instid,
					s.reference,
					s.postingDate,
					s.documentDate,
					s.sourceTranType,
					s.detail,
					s.subCode,
					s.standardText,
					s.quantity,
					s.accountNetAmount,
					s.modifiedUser,
					s.modifiedDate,
					@p_job,
					@p_run,
					@p_etl,
					0)

WHEN NOT MATCHED BY SOURCE THEN
UPDATE SET			t.MD_DATE_MODIFIED = getDate(),
					t.MD_JOB_CODE = @p_job,
					t.MD_RUN_CODE = @p_run,
					t.MD_ETL_RUN = @p_etl,
					t.MD_LOGICAL_DELETE = 1	
;

--Change job code FK link is subcode differs from sales or JC Jnl subcode
UPDATE				g
SET					g.FK_DIM_JOB = jNew.SK_DIM_JOB
FROM				dw.FACT_GLTRANS g
INNER JOIN			dw.DIM_JOB jOld ON g.FK_DIM_JOB = jOld.SK_DIM_JOB
INNER JOIN			dw.DIM_JOB jNew ON g.P_Transaction_Subcode = jNew.P_jobCode
WHERE				jOld.P_jobCode != g.P_Transaction_Subcode
AND					g.P_Transaction_Type NOT LIKE 'AP%';

END
;