CREATE TABLE [ods].[LKP_GT_HRPayGL] (
    [oid]           VARCHAR (34)    NULL,
    [myHRPay]       VARCHAR (34)    NULL,
    [myGLAccount]   VARCHAR (34)    NULL,
    [myHRTransType] VARCHAR (34)    NULL,
    [timeLineDate]  DATE            NULL,
    [quantityPay]   NUMERIC (12, 4) NULL,
    [ratePay]       NUMERIC (14, 4) NULL,
    [amountPay]     NUMERIC (12, 2) NULL,
    [branchId]      INT             NULL,
    [businessId]    INT             NULL
);

