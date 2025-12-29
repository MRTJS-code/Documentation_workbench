CREATE TABLE [ods].[STG_WS_DESPATCH] (
    [DespatchID]                       INT           NOT NULL,
    [EntryClerkUserId]                 INT           NULL,
    [DespatchStatus]                   INT           NULL,
    [DespatchLastChangedDateTime]      DATETIME      NULL,
    [LastUpdateDateTime]               DATETIME      NULL,
    [MonitoringStationAdvisedDateTime] DATETIME      NULL,
    [MonitoringStationDespatcherName]  VARCHAR (128) NULL,
    [ClientId]                         INT           NULL,
    [DespatchDateTime]                 DATETIME      NULL,
    [AckDateTime]                      DATETIME      NULL,
    [OnSiteDateTime]                   DATETIME      NULL,
    [OffSiteDateTime]                  DATETIME      NULL,
    [JobText]                          VARCHAR (MAX) NULL,
    [SpecialInstructions]              VARCHAR (MAX) NULL,
    [Hazards]                          VARCHAR (MAX) NULL,
    [PatrolResolution]                 VARCHAR (MAX) NULL,
    [AlarmDocketId]                    INT           NULL,
    [DespatchTypeId]                   INT           NULL,
    [PermanentPatrolCompletedId]       INT           NULL,
    [DespatchZone1Id]                  INT           NULL,
    [DespatchZone2Id]                  INT           NULL,
    [SubContractorId]                  INT           NULL,
    [PatrolOfficerEmployee1Id]         INT           NULL,
    [PurchaseOrderNo]                  VARCHAR (128) NULL,
    [MonitoringStationId]              INT           NULL,
    [PermanentPatrolId]                INT           NULL,
    [EntryDateTime]                    DATETIME      NULL,
    [ETLRunID]                         INT           NULL,
    [ETLDataStatus]                    VARCHAR (10)  NULL,
    [ETLInvoiceStatus]                 VARCHAR (15)  NULL,
    [GTInvoiceNo]                      VARCHAR (50)  NULL,
    [ETLNote]                          VARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([DespatchID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDX_1]
    ON [ods].[STG_WS_DESPATCH]([ClientId] ASC)
    INCLUDE([EntryClerkUserId], [DespatchStatus], [DespatchLastChangedDateTime], [LastUpdateDateTime], [MonitoringStationAdvisedDateTime], [MonitoringStationDespatcherName], [DespatchDateTime], [AckDateTime], [OnSiteDateTime], [OffSiteDateTime], [JobText], [SpecialInstructions], [Hazards], [PatrolResolution], [AlarmDocketId], [DespatchTypeId], [PermanentPatrolCompletedId], [DespatchZone1Id], [DespatchZone2Id], [SubContractorId], [PatrolOfficerEmployee1Id], [PurchaseOrderNo], [MonitoringStationId], [PermanentPatrolId], [EntryDateTime], [ETLRunID], [ETLDataStatus], [ETLInvoiceStatus]);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20191218-101505]
    ON [ods].[STG_WS_DESPATCH]([ETLInvoiceStatus] ASC);

