CREATE TABLE [dw].[DIM_GUARDAVAILABILITY] (
    [PK_DeputyId]          BIGINT        NOT NULL,
    [FK_DIM_SECURITYGUARD] BIGINT        NULL,
    [FK_DIM_AVAILSCHEDULE] BIGINT        NULL,
    [AvailGuardId]         BIGINT        NULL,
    [AvailType]            VARCHAR (100) NULL,
    [AvailDateFrom]        DATETIME      NULL,
    [AvailDateTo]          DATETIME      NULL,
    [AvailComment]         VARCHAR (100) NULL,
    [MD_CreateDate]        DATETIME      NULL,
    [MD_ModifiedDate]      DATETIME      NULL,
    [MD_ETLJobCode]        INT           NULL,
    [MD_ETLRunCode]        BIGINT        NULL,
    [MD_ETLRun]            BIGINT        NULL,
    [MD_ModifiedUser]      VARCHAR (100) NULL,
    [FK_QA_QUALITYHEADER]  BIGINT        NULL,
    PRIMARY KEY CLUSTERED ([PK_DeputyId] ASC)
);

