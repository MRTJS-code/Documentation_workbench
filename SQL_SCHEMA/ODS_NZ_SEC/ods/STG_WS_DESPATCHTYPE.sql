CREATE TABLE [ods].[STG_WS_DESPATCHTYPE] (
    [DespatchTypeId] INT           NOT NULL,
    [Code]           VARCHAR (64)  NULL,
    [Description]    VARCHAR (128) NULL,
    [GLCode]         VARCHAR (64)  NULL,
    PRIMARY KEY CLUSTERED ([DespatchTypeId] ASC)
);

