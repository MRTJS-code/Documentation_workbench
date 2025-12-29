-- =============================================
-- Author:		CHARLENE SY
-- Create date: jUNE 25, 2024
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dw].[proc_fact_GHS_Activities_Alerts]
	@p_job int,  
	@p_run int,	
	@p_pack varchar(70),
	@P_USER varchar(70)	

AS


WITH ALERT AS (
	SELECT
	   A.SK_FACT_ACTIVITIES AS FK_SK_FACT_ACTIVITIES
      ,AL.[id]
      ,AL.[type]
      ,AL.[created_at]
      ,AL.[classification]
      ,AL.[followed_up_at]
      ,AL.[followed_up_by]
      ,AL.[followed_up_by_role]
      ,AL.[followed_up_completed_at]
      ,AL.[followed_up_completed_by]
      ,AL.[followed_up_completed_details]
      ,AL.[alert_to_followup_seconds]
      ,AL.[followup_to_completed_seconds]
      ,AL.[calls_count]
      ,AL.[notes_count]
	  ,  ROW_NUMBER() OVER (PARTITION BY A.SK_FACT_ACTIVITIES ORDER BY SK_FACT_ACTIVITIES, AL.[id]) AS rowNum
FROM [ODS_NZ_SEC].[staging].[GHS_ACTIVITIES_ALERT] AL
LEFT JOIN [ODS_NZ_SEC].[dw].[FACT_GHS_ACTIVITIES] A ON AL.activity_id = A.PK_ACTIVITY_ID

)

	SELECT *
	INTO #tempAlert
	FROM ALERT
	WHERE rowNum = 1;

BEGIN
    MERGE INTO [ODS_NZ_SEC].[dw].[FACT_GHS_ACTIVITIES_ALERT] AS Target
    USING #tempAlert AS Source
    ON Target.[PK_ALERT_ID] = Source.ID and Target.FK_SK_FACT_ACTIVITIES = Source.FK_SK_FACT_ACTIVITIES

    WHEN MATCHED THEN
    UPDATE SET
        Target.FK_SK_FACT_ACTIVITIES = Source.FK_SK_FACT_ACTIVITIES,
        Target.[P_TYPE] = Source.[type],
        Target.[P_CREATED_AT] = Source.[created_at],
        Target.[P_CLASSIFICATION] = Source.[classification],
        Target.[P_FOLLOWED_UP_AT] = Source.[followed_up_at],
        Target.[P_FOLLOWED_UP_BY] = Source.[followed_up_by],
        Target.[P_FOLLOWED_UP_BY_ROLE] = Source.[followed_up_by_role],
        Target.[P_FOLLOWED_UP_COMPLETED_AT] = Source.[followed_up_completed_at],
        Target.[P_FOLLOWED_UP_COMPLETED_BY] = Source.[followed_up_completed_by],
        Target.[P_FOLLOWED_UP_COMPLETED_DETAILS] = Source.[followed_up_completed_details],
        Target.[P_ALERT_TO_FOLLOWUP_SECONDS] = Source.[alert_to_followup_seconds],
        Target.[P_FOLLOWUP_TO_COMPLETED_SECONDS] = Source.[followup_to_completed_seconds],
        Target.[P_CALLS_COUNT] = Source.[calls_count],
        Target.[P_NOTES_COUNT] = Source.[notes_count],
        Target.[MD_DATE_MODIFIED] = GETDATE(),
        Target.[MD_JOB_CODE] = @P_JOB,
        Target.[MD_RUN_CODE] = @P_RUN,
        Target.[MD_PACK_NAME] = @P_PACK,
        Target.[MD_MODIFIED_USER] = @P_USER

    WHEN NOT MATCHED BY Target THEN
    INSERT (
        [PK_ALERT_ID],
        FK_SK_FACT_ACTIVITIES,
        [P_TYPE],
        [P_CREATED_AT],
        [P_CLASSIFICATION],
        [P_FOLLOWED_UP_AT],
        [P_FOLLOWED_UP_BY],
        [P_FOLLOWED_UP_BY_ROLE],
        [P_FOLLOWED_UP_COMPLETED_AT],
        [P_FOLLOWED_UP_COMPLETED_BY],
        [P_FOLLOWED_UP_COMPLETED_DETAILS],
        [P_ALERT_TO_FOLLOWUP_SECONDS],
        [P_FOLLOWUP_TO_COMPLETED_SECONDS],
        [P_CALLS_COUNT],
        [P_NOTES_COUNT],
		[MD_DATE_CREATED],
		[MD_DATE_MODIFIED],
		[MD_JOB_CODE],
		[MD_RUN_CODE],
		[MD_PACK_NAME],
		[MD_MODIFIED_USER],
		[MD_LOGICAL_DELETE]
    )
    VALUES (
        Source.[id],
        Source.FK_SK_FACT_ACTIVITIES,
        Source.[type],
        Source.[created_at],
        Source.[classification],
        Source.[followed_up_at],
        Source.[followed_up_by],
        Source.[followed_up_by_role],
        Source.[followed_up_completed_at],
        Source.[followed_up_completed_by],
        Source.[followed_up_completed_details],
        Source.[alert_to_followup_seconds],
        Source.[followup_to_completed_seconds],
        Source.[calls_count],
        Source.[notes_count],
		GETDATE(),
		GETDATE(),
		@P_JOB, 
		@P_RUN,
		@P_PACK,
		@P_USER,
		0
    );
END