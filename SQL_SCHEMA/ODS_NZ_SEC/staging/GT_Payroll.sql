CREATE TABLE [staging].[GT_Payroll] (
    [oid]          VARCHAR (34)    NULL,
    [reference]    VARCHAR (20)    NULL,
    [postingDate]  DATE            NULL,
    [glJnlRef]     INT             NULL,
    [empeeId]      VARCHAR (34)    NULL,
    [payrollCode]  VARCHAR (8)     NULL,
    [payCodeDesc]  VARCHAR (30)    NULL,
    [jobOid]       VARCHAR (34)    NULL,
    [timeLineDate] DATE            NULL,
    [quantityPay]  NUMERIC (12, 4) NULL,
    [ratePay]      NUMERIC (14, 4) NULL,
    [amountPay]    NUMERIC (12, 2) NULL,
    [brNo]         INT             NULL,
    [bsNo]         INT             NULL
);

