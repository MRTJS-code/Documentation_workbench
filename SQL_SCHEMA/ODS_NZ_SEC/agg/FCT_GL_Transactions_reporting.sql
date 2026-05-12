CREATE TABLE [agg].[FCT_GL_Transactions_reporting] (
    [oid]               VARCHAR (34)    NULL,
    [ActivityOid]       VARCHAR (34)    NULL,
    [code]              VARCHAR (50)    NULL,
    [description]       VARCHAR (50)    NULL,
    [modifiedUser]      VARCHAR (31)    NULL,
    [modifiedTimeStamp] DATETIME        NULL,
    [documentDate]      DATETIME        NULL,
    [sourceTranType]    VARCHAR (31)    NULL,
    [reference]         VARCHAR (21)    NULL,
    [detail]            VARCHAR (31)    NULL,
    [subCode]           VARCHAR (21)    NULL,
    [standardText]      VARCHAR (MAX)   NULL,
    [quantity]          NUMERIC (14, 2) NULL,
    [tranNetAmount]     NUMERIC (14, 2) NULL,
    [WILSARRef]         VARCHAR (10)    NULL,
    [period]            VARCHAR (34)    NULL,
    [glAccount]         VARCHAR (34)    NULL,
    [organisation]      VARCHAR (34)    NULL,
    [job]               VARCHAR (34)    NULL,
    [activity]          VARCHAR (34)    NULL
);

