CREATE TABLE [ods].[PBI_NCR_DESPATCH] (
    [Dispatch Type]             VARCHAR (64)  NULL,
    [Dispatch ID]               INT           NULL,
    [AlarmDocketId]             INT           NULL,
    [IsComplete]                BIT           NULL,
    [KDTNo]                     VARCHAR (16)  NULL,
    [AlarmOnSiteDateTime]       DATETIME      NULL,
    [AlarmOffSiteDateTime]      DATETIME      NULL,
    [ClientSite]                VARCHAR (256) NULL,
    [BureauIDCode]              VARCHAR (128) NULL,
    [BureauName]                VARCHAR (256) NULL,
    [MonitoringStationId]       INT           NULL,
    [TimeToRespondInMinutes]    INT           NULL,
    [TimeOnSiteInMinutes]       INT           NULL,
    [ExtraTimeOnSiteInMinutes]  INT           NULL,
    [OverResponseTimeInMinutes] INT           NULL,
    [OtherDocketType]           INT           NULL,
    [ClientMapLat]              FLOAT (53)    NULL,
    [ClientMapLong]             FLOAT (53)    NULL,
    [ClientIDCode]              VARCHAR (128) NULL
);

