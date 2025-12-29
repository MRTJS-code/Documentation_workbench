




-- =======================================================
-- Author:		Crispin Nicodemus 
-- Create date: 2023-04-18 
-- Description:	stored proc for building fact_lh_task
-- =======================================================
CREATE PROCEDURE [dw].[proc_fact_LH_Task]
	-- Add the parameters for the stored procedure here
	@p_job int,  
	@p_run int,	
	@p_pack varchar(70)	
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;

If(OBJECT_ID('tempdb..#tempLHTask') Is Not Null)
Begin
 DROP TABLE #tempLHTask
End
	
BEGIN
SELECT 
       [Task_id]
      ,[Application_id]
      ,b.SK_DIM_LH_LOCATION as  [dim_LH_Location_key]
      ,c.SK_DIM_LH_AREA as [dim_LH_Area_key]
      ,d.SK_DIM_LH_User as [dim_LH_User_key]
      ,e.SK_DIM_LH_ROLE as [dim_LH_Role_key]
      ,f.SK_DIM_DATE as [dim_LH_Task_Created_key]
      ,[Form_group_label]
      ,[Field_label]
      ,[Field_value]
      ,[Building_name]
      ,[Template_id]
      ,[Template_name]
      ,[Task_title]
INTO #tempLHTask
FROM staging.LH_TASK
LEFT JOIN dw.DIM_LH_LOCATION b on staging.LH_TASK.Location_id = b.P_Location_id
LEFT JOIN dw.DIM_LH_AREA c on staging.LH_TASK.[Area_name] = c.P_Area_name
LEFT JOIN dw.DIM_LH_USER d on staging.LH_TASK.[User_id] = d.P_User_id
LEFT JOIN dw.DIM_LH_ROLE e on staging.LH_TASK.[Role_id] = e.P_Role_id
LEFT JOIN dw.DIM_DATE f on staging.LH_TASK.Created_at = f.PK_Date

;
END

BEGIN
MERGE INTO dw.FACT_LH_TASK t
USING #tempLHTask s
ON (t.Task_id = s.Task_id) and
	isnull(t.[Field_label], '') <> isnull(s.[Field_label], '') and
	isnull(t.[Field_value], '') <> isnull(s.[Field_value], '') and
	isnull(t.[dim_LH_Task_Created_key], 0) <> isnull(s.[dim_LH_Task_Created_key], 0) 
--- NEED TO VERIDY BUSINESS KEY !!!

WHEN MATCHED AND
(
	isnull(t.[Application_id], '') <> isnull(s.[Application_id], '') or
	isnull(t.[dim_LH_Location_key], 0) <> isnull(s.[dim_LH_Location_key], 0) or
	isnull(t.[dim_LH_Area_key], 0) <> isnull(s.[dim_LH_Area_key], 0) or
	isnull(t.[dim_LH_User_key], 0) <> isnull(s.[dim_LH_User_key], 0) or
	isnull(t.[dim_LH_Role_key], 0) <> isnull(s.[dim_LH_Role_key], 0) or
	isnull(t.[dim_LH_Task_Created_key], 0) <> isnull(s.[dim_LH_Task_Created_key], 0) or
	isnull(t.[Form_group_label], '') <> isnull(s.[Form_group_label], '') or
	isnull(t.[Field_label], '') <> isnull(s.[Field_label], '') or
	isnull(t.[Field_value], '') <> isnull(s.[Field_value], '') or
	isnull(t.[Building_name], '') <> isnull(s.[Building_name], '') or
	isnull(t.[Template_id], '') <> isnull(s.[Template_id], '') or
	isnull(t.[Template_name], '') <> isnull(s.[Template_name], '') or
	isnull(t.[Task_title], '') <> isnull(s.[Task_title], '') 
)
THEN UPDATE SET
	t.[Application_id] = s.[Application_id],
	t.[dim_LH_Location_key] = s.[dim_LH_Location_key],
	t.[dim_LH_Area_key] = s.[dim_LH_Area_key],
	t.[dim_LH_User_key] = s.[dim_LH_User_key],
	t.[dim_LH_Role_key] = s.[dim_LH_Role_key],
	t.[dim_LH_Task_Created_key] = s.[dim_LH_Task_Created_key],
	t.[Form_group_label] = s.[Form_group_label],
	t.[Field_label] = s.[Field_label],
	t.[Field_value] = s.[Field_value],
	t.[Building_name] = s.[Building_name],
	t.[Template_id] = s.[Template_id],
	t.[Template_name] = s.[Template_name],
	t.[Task_title] = s.[Task_title],
	MD_DATE_MODIFIED = getdate(),
	MD_JOB_CODE = @p_job, 
	MD_RUN_CODE = @p_run,
	MD_PACK_NAME = @p_pack

WHEN NOT MATCHED THEN
	INSERT (
		[Task_id]
		,[Application_id]
		,[dim_LH_Location_key]
		,[dim_LH_Area_key]
		,[dim_LH_User_key]
		,[dim_LH_Role_key]
		,[dim_LH_Task_Created_key]
		,[Form_group_label]
		,[Field_label]
		,[Field_value]
		,[Building_name]
		,[Template_id]
		,[Template_name]
		,[Task_title],
		MD_DATE_CREATED,
		MD_DATE_MODIFIED,
		MD_JOB_CODE, 
		MD_RUN_CODE,
		MD_PACK_NAME
	)
	VALUES
	(
		s.[Task_id]
		,s.[Application_id]
		,isnull(s.[dim_LH_Location_key], 0)
		,isnull(s.[dim_LH_Area_key], 0)
		,isnull(s.[dim_LH_User_key], 0)
		,isnull(s.[dim_LH_Role_key], 0)
		,isnull(s.[dim_LH_Task_Created_key], 0)
		,s.[Form_group_label]
		,s.[Field_label]
		,s.[Field_value]
		,s.[Building_name]
		,s.[Template_id]
		,s.[Template_name]
		,s.[Task_title]
		,getdate()
		,getdate(),
		@p_job, 
		@p_run,
		@p_pack)
;
END