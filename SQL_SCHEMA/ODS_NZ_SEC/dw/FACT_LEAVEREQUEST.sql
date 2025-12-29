CREATE TABLE [dw].[FACT_LEAVEREQUEST] (
    [PK_DeputyId]          BIGINT        NOT NULL,
    [FK_DIM_SECURITYGUARD] BIGINT        NULL,
    [LeaveGuardId]         BIGINT        NULL,
    [LeaveFrom]            DATETIME      NULL,
    [LeaveTo]              DATETIME      NULL,
    [LeaveDays]            INT           NULL,
    [LeaveHours]           INT           NULL,
    [LeaveStatus]          VARCHAR (100) NULL,
    [MD_CreateDate]        DATETIME      NULL,
    [MD_ModifiedDate]      DATETIME      NULL,
    [MD_ETLJobCode]        INT           NULL,
    [MD_ETLRunCode]        BIGINT        NULL,
    [MD_ETLRun]            BIGINT        NULL,
    [MD_ModifiedUser]      VARCHAR (100) NULL,
    [FK_QA_QUALITYHEADER]  BIGINT        NULL,
    PRIMARY KEY CLUSTERED ([PK_DeputyId] ASC)
);

