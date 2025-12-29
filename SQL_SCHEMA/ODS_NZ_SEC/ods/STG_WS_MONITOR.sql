CREATE TABLE [ods].[STG_WS_MONITOR] (
    [MonitoringStationId]         INT           NOT NULL,
    [Prefix]                      VARCHAR (16)  NULL,
    [Name]                        VARCHAR (128) NULL,
    [Status]                      BIT           NULL,
    [ContactName]                 VARCHAR (128) NULL,
    [Address1]                    VARCHAR (128) NULL,
    [Address2]                    VARCHAR (128) NULL,
    [SuburbId]                    INT           NULL,
    [ContactPhoneNo]              VARCHAR (128) NULL,
    [ContactFaxNo]                VARCHAR (128) NULL,
    [ContactEmail]                VARCHAR (MAX) NULL,
    [Comments]                    VARCHAR (MAX) NULL,
    [RegionId]                    INT           NULL,
    [SendAlarmDocketNotification] BIT           NULL,
    PRIMARY KEY CLUSTERED ([MonitoringStationId] ASC)
);

