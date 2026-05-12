CREATE TABLE [ods].[STG_GLTRANS] (
    [oid]               VARCHAR (34)    NOT NULL,
    [modifiedUser]      VARCHAR (31)    NULL,
    [modifiedTimeStamp] DATETIME        NULL,
    [documentDate]      DATE            NULL,
    [sourceTranType]    VARCHAR (31)    NULL,
    [reference]         VARCHAR (21)    NULL,
    [detail]            VARCHAR (31)    NULL,
    [subCode]           VARCHAR (21)    NULL,
    [standardText]      VARCHAR (MAX)   NULL,
    [quantity]          NUMERIC (14, 2) NULL,
    [tranNetAmount]     NUMERIC (14, 2) NULL,
    [WILSARRef]         VARCHAR (10)    NULL,
    [period]            VARCHAR (34)    NOT NULL,
    [glAccount]         VARCHAR (34)    NOT NULL,
    [organisation]      VARCHAR (34)    NULL,
    [job]               VARCHAR (34)    NULL,
    [activity]          VARCHAR (34)    NULL,
    PRIMARY KEY CLUSTERED ([oid] ASC)
);

