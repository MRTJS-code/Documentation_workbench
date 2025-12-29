CREATE TABLE [staging].[WS_MonitorStation] (
    [MonitoringStationId] INT           NULL,
    [Prefix]              VARCHAR (16)  NULL,
    [Name]                VARCHAR (128) NULL,
    [Address1]            VARCHAR (128) NULL,
    [Address2]            VARCHAR (128) NULL,
    [ContactName]         VARCHAR (128) NULL,
    [ContactEmail]        VARCHAR (MAX) NULL,
    [ContactPhoneNo]      VARCHAR (128) NULL,
    [Status]              BIT           NULL,
    [SuburbId]            INT           NULL
);

