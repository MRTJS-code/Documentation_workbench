CREATE TABLE [staging].[LH_AREA] (
    [Application_id]      VARCHAR (255) NULL,
    [Area_id]             VARCHAR (255) NULL,
    [Area_name]           VARCHAR (255) NULL,
    [Area_type]           VARCHAR (255) NULL,
    [Area_parent_id]      VARCHAR (255) NULL,
    [Area_created_at]     VARCHAR (255) NULL,
    [Area_updated_at]     VARCHAR (255) NULL,
    [md_filename]         VARCHAR (255) NULL,
    [md_dateLastModified] DATETIME      NULL,
    [md_etlJob]           BIGINT        NULL,
    [md_etlExecution]     BIGINT        NULL,
    [md_etlRun]           BIGINT        NULL
);

