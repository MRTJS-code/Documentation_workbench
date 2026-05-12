
-- ========================================================
-- Author:		Crispin Nicodemus 
-- Create date: 2023-04-28 
-- Description:	stored proc for building proc stage_GT_Job
-- =========================================================
CREATE PROCEDURE [staging].[proc_stage_GT_Job]
	-- Add the parameters for the stored procedure here
	@p_job int,  
	@p_run int,	
	@p_pack varchar(70)	
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;

If(OBJECT_ID('tempdb..#tmp_jobgroup') Is Not Null)
Begin
  DROP TABLE #tmp_jobgroup
End
	
BEGIN

SELECT	--oid, 
		oid_clsno,
		oid_instid,
		AXCC,
		GroupContract,
		MajorContract,
		CASE
			WHEN StaticGuard = 1 THEN 1
		ELSE 0
		END as StaticGuard
INTO #tmp_jobgroup
FROM staging.STG_GT_JOB

UPDATE	staging.STG_GT_JOB
SET		staging.STG_GT_JOB.AXCC = #tmp_jobgroup.AXCC,
		staging.STG_GT_JOB.GroupContract = #tmp_jobgroup.GroupContract,
		staging.STG_GT_JOB.MajorContract = #tmp_jobgroup.MajorContract,
		staging.STG_GT_JOB.StaticGuard = #tmp_jobgroup.StaticGuard
FROM	staging.STG_GT_JOB
INNER JOIN #tmp_jobgroup
ON  staging.STG_GT_JOB.oid_clsno = #tmp_jobgroup.oid_clsno
and staging.STG_GT_JOB.oid_instid = #tmp_jobgroup.oid_instid ;

UPDATE staging.STG_GT_JOB 
SET    staging.STG_GT_JOB.GroupContract = left(staging.STG_GT_JOB.[jobName],20)
WHERE  staging.STG_GT_JOB.GroupContract is NULL and staging.STG_GT_JOB.[jobStatus] = 'Open';

UPDATE staging.STG_GT_JOB
SET    staging.STG_GT_JOB.GroupContract = 'Historic Contracts'
WHERE  staging.STG_GT_JOB.GroupContract is NULL;

UPDATE staging.STG_GT_JOB
SET    staging.STG_GT_JOB.AXCC = '9999999'
WHERE  staging.STG_GT_JOB.AXCC is NULL;

END
;
