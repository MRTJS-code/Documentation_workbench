CREATE TABLE [staging].[WS_AR_RESPONSE] (
    [DespatchId]             INT           NULL,
    [ClientId]               INT           NULL,
    [GT_Branch]              VARCHAR (7)   NULL,
    [BillingDebtor]          VARCHAR (64)  NULL,
    [Site]                   VARCHAR (256) NULL,
    [DespatchDateTime]       DATETIME      NULL,
    [OnSiteDateTime]         DATETIME      NULL,
    [OffSiteDateTime]        DATETIME      NULL,
    [TimeToRespondInMinutes] INT           NULL,
    [TimeOnSiteInMinutes]    INT           NULL,
    [Zone]                   VARCHAR (30)  NULL,
    [JobText]                VARCHAR (MAX) NULL,
    [EntryDateTime]          DATETIME      NULL,
    [AckDateTime]            DATETIME      NULL,
    [EmployeeId]             INT           NULL,
    [EmployeeName]           VARCHAR (128) NULL,
    [MonitorName]            VARCHAR (128) NULL,
    [Branch Name]            VARCHAR (50)  NULL,
    [MapLat]                 FLOAT (53)    NULL,
    [MapLong]                FLOAT (53)    NULL
);

