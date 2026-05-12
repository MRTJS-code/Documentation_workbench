
-- ========================================================
-- Author:		Crispin Nicodemus 
-- Create date: 2023-02-20 
-- Description:	stored proc for building proc stage_GT_Job
-- =========================================================
CREATE PROCEDURE [staging].[proc_stage_ODS_GT_Job]
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

SELECT	a.oid, 
		cast(left(a.oid,7) as int) as oid_clsno,
		cast(rtrim(right(a.oid,20)) as bigint) as oid_instid,
		a.AX_CC AXCC, --AXCC,
		a.Group_Contract GroupContract,--GroupContract,
		a.Major_Contract MajorContract ,--MajorContract,
		CASE
			WHEN a.Static_Guards = 1 THEN 1
		ELSE 0
		END as StaticGuard
INTO #tmp_jobgroup
FROM ods.LKP_GT_JOB_GROUP a
--FROM ods.STG_GT_JOB
where  isnumeric(right(a.oid,20) ) = 1

UPDATE	ods.STG_GT_JOB
SET		ods.STG_GT_JOB.AXCC = #tmp_jobgroup.AXCC,
		ods.STG_GT_JOB.GroupContract = #tmp_jobgroup.GroupContract,
		ods.STG_GT_JOB.MajorContract = #tmp_jobgroup.MajorContract,
		ods.STG_GT_JOB.StaticGuard = #tmp_jobgroup.StaticGuard
FROM	ods.STG_GT_JOB
INNER JOIN #tmp_jobgroup
ON  ods.STG_GT_JOB.oid = #tmp_jobgroup.oid ;

UPDATE ods.STG_GT_JOB
SET    ods.STG_GT_JOB.GroupContract = left(ods.STG_GT_JOB.[Name],60)
WHERE  ods.STG_GT_JOB.GroupContract is NULL and ods.STG_GT_JOB.[status] = 'Open';

UPDATE ods.STG_GT_JOB
SET    ods.STG_GT_JOB.GroupContract = 'Historic Contracts'
WHERE  ods.STG_GT_JOB.GroupContract is NULL;

UPDATE ods.STG_GT_JOB
SET    ods.STG_GT_JOB.AXCC = '9999999'
WHERE  ods.STG_GT_JOB.AXCC is NULL;

END
;
