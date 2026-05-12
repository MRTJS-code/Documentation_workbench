CREATE TABLE [ods].[STG_AR_RESPONSE] (
    [DespatchId]             INT           NULL,
    [clientid]               INT           NULL,
    [BillingDebtor]          VARCHAR (64)  NULL,
    [GT_Branch]              VARCHAR (7)   NULL,
    [Site]                   VARCHAR (256) NULL,
    [DespatchDateTime]       DATETIME      NULL,
    [OnSiteDateTime]         DATETIME      NULL,
    [OffSiteDateTime]        DATETIME      NULL,
    [TimeToRespondInMinutes] INT           NULL,
    [TimeOnSiteInMinutes]    INT           NULL,
    [Zone]                   VARCHAR (8)   NULL,
    [JobText]                VARCHAR (MAX) NULL,
    [EntryDateTime]          DATETIME      NULL,
    [AckDateTime]            DATETIME      NULL,
    [EmployeeId]             INT           NULL,
    [EmployeeName]           VARCHAR (257) NULL,
    [monitorName]            VARCHAR (128) NULL,
    [Branch Name]            VARCHAR (50)  NULL,
    [MapLat]                 FLOAT (53)    NULL,
    [mapLong]                FLOAT (53)    NULL
);

