
-- ======================================================
-- Author:		Crispin Nicodemus 
-- Create date: 2023-04-18 
-- Description:	stored proc for building dim_LH_Issue
-- ======================================================
CREATE PROCEDURE [dw].[proc_fact_LH_Issue]
	-- Add the parameters for the stored procedure here
	@p_job int,  
	@p_run int,	
	@p_pack varchar(70)	
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;

If(OBJECT_ID('tempdb..#tempLHIssue') Is Not Null)
Begin
 DROP TABLE #tempLHIssue
End
	
BEGIN
SELECT DISTINCT 
       [Application_id]
      ,[Created_at]
      ,[Field_id]
      ,[Field_label]
      ,[Field_value]
      ,[Issue_id]
      ,[Issue_duration]
      ,[Issue_status]
      ,[Template_id]
      ,[Issue_title]
      ,[Building_name]
      ,[Template_name]
      ,[User_email]
 
      ,b.SK_DIM_LH_LOCATION as [dim_LH_Location_key]
      ,c.SK_DIM_LH_AREA     as [dim_LH_Area_key]
      ,d.SK_DIM_LH_User     as [dim_LH_User_key]
      ,e.SK_DIM_LH_ROLE     as [dim_LH_Role_key]
 
INTO #tempLHIssue
FROM staging.LH_Issue
LEFT JOIN dw.DIM_LH_LOCATION b on staging.LH_Issue.Issue_location_id = b.P_Location_id
LEFT JOIN dw.DIM_LH_AREA     c on staging.LH_Issue.[Area_name] = c.P_Area_name
LEFT JOIN dw.DIM_LH_USER     d on staging.LH_Issue.[User_id]   = d.P_User_id 
LEFT JOIN dw.DIM_LH_ROLE     e on staging.LH_Issue.[Role_id]   = e.P_Role_id

MERGE INTO dw.FACT_LH_Issue a
USING #tempLHIssue b
ON a.[Issue_id] = b.[Issue_id] and
a.[Field_Label] = b.[Field_Label] 

WHEN MATCHED AND
	(
		isnull(a.[Application_id],'') <> isnull(b.[Application_id],'') or
		isnull(a.[Created_at],'') <> isnull(b.[Created_at],'') or
		isnull(a.[Field_id],'') <> isnull(b.[Field_id],'') or
		isnull(a.[Field_value],'') <> isnull(b.[Field_value],'') or
		isnull(a.[Issue_duration],'') <> isnull(b.[Issue_duration],'') or
		isnull(a.[Issue_status],'') <> isnull(b.[Issue_status],'') or
		isnull(a.[Template_id],'') <> isnull(b.[Template_id],'') or
		isnull(a.[Issue_title],'') <> isnull(b.[Issue_title],'') or
		isnull(a.[Template_name],'') <> isnull(b.[Template_name],'') or
		isnull(a.[Building_name],'') <> isnull(b.[Building_name],'') or 	
		isnull(a.[User_email],'') <> isnull(b.[User_email],'') 
)

 THEN UPDATE SET
		a.[Application_id] = b.[Application_id],
		a.[Created_at] = b.[Created_at],
		a.[Field_id] = b.[Field_id],
		a.[Field_value] = b.[Field_value],
		a.[Issue_duration] = b.[Issue_duration],
		a.[Issue_status] = b.[Issue_status],
		a.[Template_id] = b.[Template_id],
		a.[Issue_title] = b.[Issue_title],
		a.[Template_name] = b.[Template_name],
		a.[Building_name] = b.[Building_name],
		a.[User_email] = b.[User_email] 

		,[MD_DATE_CREATED] = getdate()
		,[MD_DATE_MODIFIED] = getdate()
		,[MD_JOB_CODE] = @p_job
		,[MD_RUN_CODE] = @p_run
		,[MD_PACK_NAME] = @p_pack

WHEN NOT MATCHED THEN
	INSERT 
	(
       [Application_id]
      ,[Created_at]
      ,[Field_id]
      ,[Field_label]
      ,[Field_value]
      ,[Issue_id]
      ,[Issue_duration]
      ,[Issue_status]
      ,[Template_id]
      ,[Issue_title]
      ,[Building_name]
      ,[Template_name]
      ,[User_email]
		,[dim_LH_Location_key]
		,[dim_LH_Area_key]
		,[dim_LH_User_key]
		,[dim_LH_Role_key]
		,MD_DATE_CREATED
		,MD_DATE_MODIFIED
		,MD_JOB_CODE
		,MD_RUN_CODE
		,MD_PACK_NAME
	)

	VALUES
	(
       b.[Application_id]
      ,b.[Created_at]
      ,b.[Field_id]
      ,b.[Field_label]
      ,b.[Field_value]
      ,b.[Issue_id]
      ,b.[Issue_duration]
      ,b.[Issue_status]
      ,b.[Template_id]
      ,b.[Issue_title]
      ,b.[Building_name]
      ,b.[Template_name]
      ,b.[User_email]

		,isnull(b.[dim_LH_Location_key], 0)
		,isnull(b.[dim_LH_Area_key], 0)
		,isnull(b.[dim_LH_User_key], 0)
		,isnull(b.[dim_LH_Role_key], 0)

		,getdate()
		,getdate()
		,@p_job 
		,@p_run
		,@p_pack
	)

;

END
;