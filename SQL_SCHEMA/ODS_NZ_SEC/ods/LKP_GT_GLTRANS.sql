CREATE TABLE [ods].[LKP_GT_GLTRANS] (
    [oid]               VARCHAR (34)    NULL,
    [modifiedUser]      VARCHAR (31)    NULL,
    [myPeriodSummary]   VARCHAR (34)    NULL,
    [modifiedTimeStamp] DATETIME        NULL,
    [documentDate]      DATE            NULL,
    [sourceTranType]    VARCHAR (31)    NULL,
    [reference]         VARCHAR (21)    NULL,
    [myGLAccount]       VARCHAR (34)    NULL,
    [standardText]      VARCHAR (MAX)   NULL,
    [quantity]          NUMERIC (14, 2) NULL,
    [accountNetAmount]  NUMERIC (14, 2) NULL,
    [accountTaxAmount]  NUMERIC (14, 2) NULL,
    [mySourceLineItem]  VARCHAR (34)    NULL,
    [detail]            VARCHAR (31)    NULL,
    [subCode]           VARCHAR (21)    NULL,
    [WILSARRef]         VARCHAR (8)     NULL
);

