CREATE TABLE [ods].[FCT_PAYROLL] (
    [oid]          VARCHAR (34)    NOT NULL,
    [reference]    VARCHAR (21)    NULL,
    [postingDate]  DATE            NULL,
    [glJnlRef]     INT             NULL,
    [empeeId]      VARCHAR (34)    NULL,
    [jobOid]       VARCHAR (34)    NULL,
    [payrollCode]  VARCHAR (9)     NULL,
    [payCodeDesc]  VARCHAR (31)    NULL,
    [timeLineDate] DATE            NULL,
    [quantityPay]  NUMERIC (12, 4) NULL,
    [ratePay]      NUMERIC (14, 4) NULL,
    [amountPay]    NUMERIC (12, 2) NULL,
    [branchId]     INT             NULL,
    [businessId]   INT             NULL,
    PRIMARY KEY CLUSTERED ([oid] ASC),
    CONSTRAINT [FK_FCT_Payroll_DIM_EMPEE] FOREIGN KEY ([empeeId]) REFERENCES [ods].[DIM_EMPEE] ([gtId]),
    CONSTRAINT [FK_FCT_Payroll_DIM_JOB] FOREIGN KEY ([jobOid]) REFERENCES [ods].[DIM_JOB] ([oid])
);

