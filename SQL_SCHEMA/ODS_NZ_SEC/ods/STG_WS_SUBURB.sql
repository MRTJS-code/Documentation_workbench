CREATE TABLE [ods].[STG_WS_SUBURB] (
    [SuburbId]                 INT           NOT NULL,
    [SuburbName]               VARCHAR (128) NULL,
    [Postcode]                 SMALLINT      NULL,
    [PrimarySubContractorId]   INT           NULL,
    [BackupSubContractorId]    INT           NULL,
    [LocType]                  VARCHAR (128) NULL,
    [PrimaryDespatchZoneId]    INT           NULL,
    [BackupDespatchZoneId]     INT           NULL,
    [PrimaryServiceProviderID] INT           NULL,
    PRIMARY KEY CLUSTERED ([SuburbId] ASC)
);

