CREATE TABLE [staging].[GHS_ACTIVITIES_ALERT] (
    [activity_id]                   BIGINT        NULL,
    [id]                            BIGINT        NULL,
    [type]                          VARCHAR (256) NULL,
    [created_at]                    DATETIME      NULL,
    [classification]                VARCHAR (MAX) NULL,
    [followed_up_at]                DATETIME      NULL,
    [followed_up_by]                VARCHAR (256) NULL,
    [followed_up_by_role]           VARCHAR (MAX) NULL,
    [followed_up_completed_at]      DATETIME      NULL,
    [followed_up_completed_by]      VARCHAR (MAX) NULL,
    [followed_up_completed_details] VARCHAR (MAX) NULL,
    [alert_to_followup_seconds]     BIGINT        NULL,
    [followup_to_completed_seconds] BIGINT        NULL,
    [calls_count]                   BIGINT        NULL,
    [notes_count]                   BIGINT        NULL
);

