CREATE TABLE [ods].[STG_WS_PATSERVICETYPE] (
    [PatrolServiceTypeId] INT           NOT NULL,
    [Status]              BIT           NULL,
    [Code]                VARCHAR (32)  NULL,
    [Description]         VARCHAR (128) NULL,
    [RedespatchAllowed]   BIT           NULL,
    [KeysRequired]        BIT           NULL,
    PRIMARY KEY CLUSTERED ([PatrolServiceTypeId] ASC)
);

