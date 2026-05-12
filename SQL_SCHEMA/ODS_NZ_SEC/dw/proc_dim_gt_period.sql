


-- ====================================================
-- Author:		Tony Smith
-- Create date: 2023-08-11
-- Description:	stored proc for building DIM_GT_PERIOD
-- ====================================================
CREATE PROCEDURE [dw].[proc_dim_gt_period]
	-- Add the parameters for the stored procedure here
	@p_job int,  
	@p_run bigint,	
	@p_etl int	
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;
BEGIN
--- Build lookups to calculate openPeriod bit
DECLARE				@startInstid int;
DECLARE				@endInstid int;

SELECT				@startInstid = firstopen_instid, 
					@endInstid = lastopen_instid
FROM				lookup.GT_ACTIVE_PERIOD
WHERE				moduleCode = 'GL';

--- Build tmp table with staging from GT and openPeriod calc column
SELECT				*,
					CASE 
						WHEN oid_instid >= @startInstid AND oid_instid <= @endInstid THEN 1
						ELSE 0
					END openPeriod,
					FORMAT(stDate,'yyyyMMdd') FK_DIM_DATE_START,
					FORMAT(enDate,'yyyyMMdd') FK_DIM_DATE_END
INTO				#tmpPeriod
FROM				staging.GT_PERIOD;

--- Merge tmp table into DIM_GT_PERIOD
MERGE INTO			dw.DIM_GT_PERIOD t
USING				#tmpPeriod s
ON					t.PK_oid_instid = s.oid_instid

WHEN MATCHED AND (	isnull(t.isActive,0) != isnull(s.activeGLPeriod,0)
OR					isnull(t.isOpen,0) != isnull(s.openPeriod,0)
					) THEN
UPDATE SET			t.PK_oid_clsno = s.oid_clsno,
					t.PK_oid_instid = s.oid_instid,
					t.FK_DIM_DATE_START = s.FK_DIM_DATE_START,
					t.FK_DIM_DATE_END = s.FK_DIM_DATE_END,
					t.P_Month_No = s.mnthNo,
					t.P_Year_No = s.yearNo,
					t.P_Month = s.mnthDesc,
					t.P_Year = s.yearDesc,
					t.P_First_Date = s.stDate,
					t.P_Last_Date = s.enDate,
					t.isActive = s.activeGLPeriod,
					t.isOpen = s.openPeriod,
					t.MD_DATE_MODIFIED = getdate(),
					t.MD_JOB_CODE = @p_job,
					t.MD_RUN_CODE = @p_run,
					t.MD_ETL_RUN = @p_etl,
					t.MD_LOGICAL_DELETE = 0

WHEN NOT MATCHED THEN
INSERT (			PK_oid_clsno,
					PK_oid_instid,
					FK_DIM_DATE_START,
					FK_DIM_DATE_END,
					P_Month_No,
					P_Year_No,
					P_Month,
					P_Year,
					P_First_Date,
					P_Last_Date,
					isActive,
					isOpen,
					MD_DATE_MODIFIED,
					MD_JOB_CODE,
					MD_RUN_CODE,
					MD_ETL_RUN,
					MD_LOGICAL_DELETE)
VALUES (			s.oid_clsno,
					s.oid_instid,
					s.FK_DIM_DATE_START,
					s.FK_DIM_DATE_END,
					s.mnthNo,
					s.yearNo,
					s.mnthDesc,
					s.yearDesc,
					s.stDate,
					s.enDate,
					s.activeGLPeriod,
					s.openPeriod,
					getdate(),
					@p_job,
					@p_run,
					@p_etl,
					0)
;

--- Build tmp table for ods version. This can be disabled when ods schema builds are no longer required
SELECT				cast(concat(format(p.oid_clsno,'0000000'),'.',format(p.oid_instid,'00000000000000000000')) as varchar(34)) oid,
					p.mnthDesc,
					p.mnthNo,
					p.yearDesc,
					p.yearNo,
					p.stDate,
					p.enDate,
					p.activeGLPeriod,
					p.activeARPeriod
INTO				#odsPeriod
FROM				staging.GT_PERIOD p


--- Merge for ODS schema
MERGE INTO			ods.DIM_GT_PERIOD t
USING				#odsPeriod s
ON					t.oid = s.oid

WHEN NOT MATCHED THEN
INSERT (			oid,
					mnthDesc,
					mnthNo,
					yearDesc,
					yearNo,
					stDate,
					enDate,
					activeGLPeriod,
					activeARPeriod)
VALUES (			s.oid,
					s.mnthDesc,
					s.mnthNo,
					s.yearDesc,
					s.yearNo,
					s.stDate,
					s.enDate,
					s.activeGLPeriod,
					s.activeARPeriod)
;
END
;
