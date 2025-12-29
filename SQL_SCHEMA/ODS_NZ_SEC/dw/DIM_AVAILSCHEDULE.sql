CREATE TABLE [dw].[DIM_AVAILSCHEDULE] (
    [PK_DeputyId]       BIGINT        NOT NULL,
    [AvailScheduleType] VARCHAR (100) NULL,
    [AvailRecurrEvery]  INT           NULL,
    [AvailScheduleDay]  VARCHAR (100) NULL,
    [AvailStart]        DATE          NULL,
    [AvailEnd]          DATE          NULL,
    [MD_CreateDate]     DATETIME      NULL,
    [MD_ModifiedDate]   DATETIME      NULL,
    [MD_ETLJobCode]     INT           NULL,
    [MD_ETLRunCode]     BIGINT        NULL,
    [MD_ETLRun]         BIGINT        NULL,
    [MD_ModifiedUser]   VARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([PK_DeputyId] ASC)
);

