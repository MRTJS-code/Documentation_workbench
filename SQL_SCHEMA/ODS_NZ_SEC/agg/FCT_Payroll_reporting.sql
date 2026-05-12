CREATE TABLE [agg].[FCT_Payroll_reporting] (
    [oid]                     VARCHAR (34)    NULL,
    [reference]               VARCHAR (21)    NULL,
    [postingDate]             DATE            NULL,
    [glJnlRef]                INT             NULL,
    [empeeId]                 VARCHAR (34)    NULL,
    [jobOid]                  VARCHAR (34)    NULL,
    [payrollCode]             VARCHAR (9)     NULL,
    [payCodeDesc]             VARCHAR (31)    NULL,
    [timeLineDate]            DATE            NULL,
    [quantityPay]             NUMERIC (12, 4) NULL,
    [ratePay]                 NUMERIC (14, 4) NULL,
    [amountPay]               NUMERIC (12, 2) NULL,
    [branchId]                INT             NULL,
    [businessId]              INT             NULL,
    [Living Wage Calculation] VARCHAR (10)    NULL
);

