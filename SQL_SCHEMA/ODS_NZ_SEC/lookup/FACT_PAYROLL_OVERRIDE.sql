CREATE TABLE [lookup].[FACT_PAYROLL_OVERRIDE] (
    [batchNo]        INT           NOT NULL,
    [paylineId]      BIGINT        NOT NULL,
    [lc1Override]    BIGINT        NULL,
    [lc2Override]    BIGINT        NULL,
    [createdBy]      VARCHAR (100) NULL,
    [createDate]     DATETIME      NULL,
    [modifyBy]       VARCHAR (100) NULL,
    [modifyDate]     DATETIME      NULL,
    [overrideReason] VARCHAR (100) NULL
);

