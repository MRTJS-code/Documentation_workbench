



-- =======================================================
-- Author:		Crispin Nicodemus 
-- Create date: 2023-04-18 
-- Description:	stored proc for building fact_lh_audit
-- =======================================================
CREATE PROCEDURE [dw].[proc_fact_LH_Audit]
	-- Add the parameters for the stored procedure here
	@p_job int,  
	@p_run int,	
	@p_pack varchar(70)	
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;

If(OBJECT_ID('tempdb..#tempLHAudit') Is Not Null)
Begin
 DROP TABLE #tempLHAudit
End
	
BEGIN
SELECT 
       [Audit_id]
      ,[Application_id]
      ,b.SK_DIM_LH_LOCATION as  [dim_LH_Location_key]
      ,c.SK_DIM_LH_AREA as [dim_LH_Area_key]
      ,d.SK_DIM_LH_User as [dim_LH_User_key]
      ,e.SK_DIM_LH_ROLE as [dim_LH_Role_key]
      ,f.SK_DIM_DATE as [dim_LH_Created_at_key]
      ,[Created_at]
      ,[Question_group]
      ,[Question_label]
      ,[Question_score]
      ,[Question_weight]
      ,[Question_score_weight]
      ,[Answer_label]
      ,[Location_id]
      ,[Location_name]
      ,[Area_name]
      ,[Score_actual]
      ,[Score_max]
      ,[Score_result]
      ,[Audit_template_id]
      ,[Audit_title]
      ,[Audit_template_title]
      ,[User_email]
      ,[Firstname]
      ,[Lastname]
      ,[Role_id]
      ,[Role_name]
      ,[Footer_group_name]
      ,[Footer_field_name]
      ,[Footer_field_value]
      ,[Header_group_name]
      ,[Header_field_name]
      ,[Header_field_value]
INTO #tempLHAudit
FROM staging.LH_AUDIT
LEFT JOIN dw.DIM_LH_LOCATION b on staging.LH_AUDIT.Location_id = b.P_Location_id
LEFT JOIN dw.DIM_LH_AREA c on staging.LH_AUDIT.[Area_name] = c.P_Area_name
LEFT JOIN dw.DIM_LH_USER d on staging.LH_AUDIT.[Firstname] = d.P_Firstname and staging.LH_AUDIT.[Lastname] = d.P_Lastname
LEFT JOIN dw.DIM_LH_ROLE e on staging.LH_AUDIT.[Role_id] = e.P_Role_id
LEFT JOIN dw.DIM_DATE f on staging.LH_AUDIT.Created_at = f.PK_Date
;
END

BEGIN
MERGE INTO dw.FACT_LH_AUDIT t
USING #tempLHAudit s
ON (t.P_Audit_id = s.Audit_id) and 	(isnull(t.P_Question_label, '') = isnull(s.[Question_label], '') )

WHEN MATCHED AND
(
		isnull(t.P_Application_id, '') <> isnull(s.[Application_id], '') or
		isnull(t.[dim_LH_Location_key], 0) <> isnull(s.[dim_LH_Location_key], 0) or
		isnull(t.[dim_LH_Area_key], 0) <> isnull(s.[dim_LH_Area_key], 0) or
		isnull(t.[dim_LH_User_key], 0) <> isnull(s.[dim_LH_User_key], 0) or
		isnull(t.[dim_LH_Role_key], 0) <> isnull(s.[dim_LH_Role_key], 0) or
		isnull(t.[dim_LH_Created_at_key], 0) <> isnull(s.[dim_LH_Created_at_key], 0) or
		isnull(t.P_Question_group, '') <> isnull(s.[Question_group], '') or
		isnull(t.P_Question_label, '') <> isnull(s.[Question_label], '') or
		isnull(t.P_Question_score, '') <> isnull(s.[Question_score], '') or
		isnull(t.P_Question_weight, '') <> isnull(s.[Question_weight], '') or
		isnull(t.P_Question_score_weight, '') <> isnull(s.[Question_score_weight], '') or
		isnull(t.P_Answer_label, '') <> isnull(s.[Answer_label], '') or
		isnull(t.P_Score_actual, '') <> isnull(s.[Score_actual], '') or
		isnull(t.P_Score_max, '') <> isnull(s.[Score_max], '') or
		isnull(t.P_Score_result, '') <> isnull(s.[Score_result], '') or
		isnull(t.P_Audit_template_id, '') <> isnull(s.[Audit_template_id], '') or
		isnull(t.P_Audit_title, '') <> isnull(s.[Audit_title], '') or
		isnull(t.P_Audit_template_title, '') <> isnull(s.[Audit_template_title], '') or
		isnull(t.P_Footer_group_name, '') <> isnull(s.[Footer_group_name], '') or
		isnull(t.P_Footer_field_name, '') <> isnull(s.[Footer_field_name], '') or
		isnull(t.P_Footer_field_value, '') <> isnull(s.[Footer_field_value], '') or
		isnull(t.P_Header_group_name, '') <> isnull(s.[Header_group_name], '') or
		isnull(t.P_Header_field_name, '') <> isnull(s.[Header_field_name], '') or
		isnull(t.P_Header_field_value, '') <> isnull(s.[Header_field_value], '') 
)
THEN UPDATE SET
		t.P_Application_id	= s.[Application_id],
		t.[dim_LH_Location_key] = s.[dim_LH_Location_key],
		t.[dim_LH_Area_key] = s.[dim_LH_Area_key],
		t.[dim_LH_User_key] = s.[dim_LH_User_key],
		t.[dim_LH_Role_key] = s.[dim_LH_Role_key],
		t.[dim_LH_Created_at_key] = s.[dim_LH_Created_at_key],
		t.P_Question_group	= s.[Question_group],
		t.P_Question_label	= s.[Question_label],
		t.P_Question_score	= s.[Question_score],
		t.P_Question_weight	= s.[Question_weight],
		t.P_Question_score_weight	= s.[Question_score_weight],
		t.P_Answer_label	= s.[Answer_label],
		t.P_Score_actual	= s.[Score_actual],
		t.P_Score_max	= s.[Score_max],
		t.P_Score_result	= s.[Score_result],
		t.P_Audit_template_id	= s.[Audit_template_id],
		t.P_Audit_title	= s.[Audit_title],
		t.P_Audit_template_title	= s.[Audit_template_title],
		t.P_Footer_group_name	= s.[Footer_group_name],
		t.P_Footer_field_name	= s.[Footer_field_name],
		t.P_Footer_field_value	= s.[Footer_field_value],
		t.P_Header_group_name	= s.[Header_group_name],
		t.P_Header_field_name	= s.[Header_field_name],
		t.P_Header_field_value	= s.[Header_field_value],
		MD_DATE_MODIFIED = getdate(),
		MD_JOB_CODE = @p_job, 
		MD_RUN_CODE = @p_run,
		MD_PACK_NAME = @p_pack	

WHEN NOT MATCHED THEN
	INSERT (
		[P_Audit_id]
		,[P_Application_id]
		,[dim_LH_Location_key]
		,[dim_LH_Area_key]
		,[dim_LH_User_key]
		,[dim_LH_Role_key]
		,[dim_LH_Created_at_key]
		,[P_Question_group]
		,[P_Question_label]
		,[P_Question_score]
		,[P_Question_weight]
		,[P_Question_score_weight]
		,[P_Answer_label]
		,[P_Score_actual]
		,[P_Score_max]
		,[P_Score_result]
		,[P_Audit_template_id]
		,[P_Audit_title]
		,[P_Audit_template_title]
		,[P_Footer_group_name]
		,[P_Footer_field_name]
		,[P_Footer_field_value]
		,[P_Header_group_name]
		,[P_Header_field_name]
		,[P_Header_field_value],
		MD_DATE_CREATED,
		MD_DATE_MODIFIED,
		MD_JOB_CODE, 
		MD_RUN_CODE,
		MD_PACK_NAME
	)
	VALUES
	(
		s.Audit_id
		,s.[Application_id]
		,isnull(s.[dim_LH_Location_key], 0)
		,isnull(s.[dim_LH_Area_key], 0)
		,isnull(s.[dim_LH_User_key], 0)
		,isnull(s.[dim_LH_Role_key], 0)
		,isnull(s.[dim_LH_Created_at_key], 0),
		s.[Question_group],
		s.[Question_label],
		s.[Question_score],
		s.[Question_weight],
		s.[Question_score_weight],
		s.[Answer_label],
		s.[Score_actual],
		s.[Score_max],
		s.[Score_result],
		s.[Audit_template_id],
		s.[Audit_title],
		s.[Audit_template_title],
		s.[Footer_group_name],
		s.[Footer_field_name],
		s.[Footer_field_value],
		s.[Header_group_name],
		s.[Header_field_name],
		s.[Header_field_value]
		,getdate()
		,getdate(),
		@p_job, 
		@p_run,
		@p_pack)
;
END