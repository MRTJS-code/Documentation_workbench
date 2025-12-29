CREATE TABLE [staging].[LH_LOCATION] (
    [Application_id]      VARCHAR (255) NULL,
    [Area_id]             VARCHAR (255) NULL,
    [Location_id]         VARCHAR (255) NULL,
    [Location_name]       VARCHAR (255) NULL,
    [Location_street]     VARCHAR (255) NULL,
    [Location_city]       VARCHAR (255) NULL,
    [Location_state]      VARCHAR (255) NULL,
    [Location_country]    VARCHAR (255) NULL,
    [Location_created_at] VARCHAR (255) NULL,
    [Location_updated_at] VARCHAR (255) NULL,
    [md_filename]         VARCHAR (255) NULL,
    [md_dateLastModified] DATETIME      NULL,
    [md_etlJob]           BIGINT        NULL,
    [md_etlExecution]     BIGINT        NULL,
    [md_etlRun]           BIGINT        NULL
);

