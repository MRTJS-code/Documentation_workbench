CREATE TABLE [dw].[FACT_LEAVELINE] (
    [PK_DeputyId]          BIGINT        NOT NULL,
    [FK_FACT_LEAVEREQUEST] BIGINT        NULL,
    [FK_DIM_DATE]          BIGINT        NULL,
    [FK_DIM_LEAVETYPE]     BIGINT        NULL,
    [LeaveTimesheetId]     BIGINT        NULL,
    [LeaveRequestId]       BIGINT        NULL,
    [LeaveTypeId]          BIGINT        NULL,
    [LeaveFrom]            DATETIME      NULL,
    [LeaveTo]              DATETIME      NULL,
    [LeaveHours]           FLOAT (53)    NULL,
    [LeaveCost]            FLOAT (53)    NULL,
    [MD_CreateDate]        DATETIME      NULL,
    [MD_ModifiedDate]      DATETIME      NULL,
    [MD_ETLJobCode]        INT           NULL,
    [MD_ETLRunCode]        BIGINT        NULL,
    [MD_ETLRun]            BIGINT        NULL,
    [MD_ModifiedUser]      VARCHAR (100) NULL,
    [FK_QA_QUALITYHEADER]  BIGINT        NULL,
    PRIMARY KEY CLUSTERED ([PK_DeputyId] ASC)
);

