CREATE TABLE [dw].[DIM_LEAVETYPE] (
    [SK_DIM_LEAVETYPE]     BIGINT        IDENTITY (1, 1) NOT NULL,
    [PK_SourceSystem]      VARCHAR (100) NOT NULL,
    [PK_SourceId]          BIGINT        NULL,
    [FK_DIM_PAYCODE]       BIGINT        NULL,
    [FK_DIM_COST_ACTIVITY] BIGINT        NULL,
    [LeaveName]            VARCHAR (100) NULL,
    [LeaveActivityCode]    VARCHAR (100) NULL,
    [LeavePayCode]         VARCHAR (100) NULL,
    [LeavePayroll]         BIT           NULL,
    [LeaveVisible]         BIT           NULL,
    [LeaveActive]          BIT           NULL,
    [LeaveUnit]            VARCHAR (100) NULL,
    [MD_CreateDate]        DATETIME      NULL,
    [MD_ModifiedDate]      DATETIME      NULL,
    [MD_ETLJobCode]        INT           NULL,
    [MD_ETLRunCode]        BIGINT        NULL,
    [MD_ETLRun]            BIGINT        NULL,
    [MD_ModifiedUser]      VARCHAR (100) NULL,
    [FK_QA_QUALITYHEADER]  BIGINT        NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_LEAVETYPE] ASC)
);

