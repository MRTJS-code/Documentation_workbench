CREATE TABLE [ods].[STG_WS_CLIENT] (
    [ClientId]                     INT             NOT NULL,
    [Status]                       BIT             NULL,
    [ClientIDCode]                 VARCHAR (128)   NULL,
    [BureauId]                     INT             NULL,
    [Site]                         VARCHAR (256)   NULL,
    [Address1]                     VARCHAR (128)   NULL,
    [Address2]                     VARCHAR (128)   NULL,
    [AddressSuburbId]              INT             NULL,
    [PhoneNo]                      VARCHAR (128)   NULL,
    [DebtorCode]                   VARCHAR (64)    NULL,
    [ZoneId]                       VARCHAR (128)   NULL,
    [MonitoringStationId]          INT             NULL,
    [IsSuspended]                  BIT             NULL,
    [SuspendedDate]                DATETIME        NULL,
    [SuspendedUserId]              INT             NULL,
    [PrimarySubContractorId]       INT             NULL,
    [BackupSubContractorId]        INT             NULL,
    [ZoneId2]                      VARCHAR (128)   NULL,
    [PermanentPatrolRatePerMinute] DECIMAL (10, 2) NULL,
    [CasualPatrolRateExGST]        DECIMAL (10, 2) NULL,
    [MapLat]                       FLOAT (53)      NULL,
    [MapLong]                      FLOAT (53)      NULL,
    [BillType]                     VARCHAR (10)    NULL,
    PRIMARY KEY CLUSTERED ([ClientId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDX_2]
    ON [ods].[STG_WS_CLIENT]([DebtorCode] ASC)
    INCLUDE([Site]);

