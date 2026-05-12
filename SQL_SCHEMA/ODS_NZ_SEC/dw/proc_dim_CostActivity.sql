
-- ========================================================
-- Author:		Crispin Nicodemus 
-- Create date: 2023-01-31 
-- Description:	stored proc for building dim_CostActivity
-- =========================================================
CREATE PROCEDURE [dw].[proc_dim_CostActivity]
	-- Add the parameters for the stored procedure here
	@p_job int,  
	@p_run int,	
	@p_pack varchar(70)	
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;

BEGIN

MERGE INTO dw.DIM_COST_ACTIVITY a
USING staging.STG_GT_ACTIVITY b
ON (a.P_oid_clsno = b.oid_clsno and a.P_oid_instid = b.oid_instid)
WHEN NOT MATCHED THEN
	INSERT (
	[P_Oid_clsno], 
	[P_Oid_instid], 
	[P_Code],
	[P_Description],
	[MD_DATE_CREATED],
	[MD_DATE_MODIFIED],
	[MD_JOB_CODE], 
	[MD_RUN_CODE],
	[MD_PACK_NAME]
	)
	VALUES
	(
	b.[oid_clsno], 
	b.[oid_instid], 
	b.[code],
	b.[description],
	getdate(),
	getdate(),
	@p_job, 
	@p_run,
	@p_pack
	)
WHEN MATCHED AND 
	(
	 isnull([P_Code],'')  <> isnull(b.Code,'') or
	 isnull([P_Description],'')    <> isnull(b.description,'')
	)
 THEN UPDATE SET
	a.[P_Code] = b.[code],
	a.[P_Description] = b.[description]
    ,[MD_DATE_CREATED] = getdate()
    ,[MD_DATE_MODIFIED] = getdate()
    ,[MD_JOB_CODE] = @p_job
    ,[MD_RUN_CODE] = @p_run
	,[MD_PACK_NAME] = @p_pack
;
END
;
