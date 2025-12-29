CREATE TABLE [staging].[LH_EVENT] (
    [Event_id]            VARCHAR (255) NULL,
    [Area_id]             VARCHAR (255) NULL,
    [CreatedAt]           DATETIME      NULL,
    [Latitude]            VARCHAR (255) NULL,
    [Longitude]           VARCHAR (255) NULL,
    [timestamp]           DATETIME      NULL,
    [Type]                VARCHAR (255) NULL,
    [User_id]             VARCHAR (255) NULL,
    [Location_id]         VARCHAR (255) NULL,
    [Location_name]       VARCHAR (255) NULL,
    [Area_name]           VARCHAR (255) NULL,
    [Application_id]      VARCHAR (255) NULL,
    [Username]            VARCHAR (255) NULL,
    [Firstname]           VARCHAR (255) NULL,
    [Lastname]            VARCHAR (255) NULL,
    [md_filename]         VARCHAR (255) NULL,
    [md_dateLastModified] DATETIME      NULL,
    [md_etlJob]           BIGINT        NULL,
    [md_etlExecution]     BIGINT        NULL,
    [md_etlRun]           BIGINT        NULL
);

