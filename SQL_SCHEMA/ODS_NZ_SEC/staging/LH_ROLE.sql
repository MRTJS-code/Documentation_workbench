CREATE TABLE [staging].[LH_ROLE] (
    [Document_date]       VARCHAR (255) NULL,
    [Application_id]      VARCHAR (255) NULL,
    [Role_id]             VARCHAR (255) NULL,
    [Role_name]           VARCHAR (255) NULL,
    [Role_created_at]     VARCHAR (255) NULL,
    [Role_updated_at]     VARCHAR (255) NULL,
    [Revision_number]     VARCHAR (255) NULL,
    [md_filename]         VARCHAR (255) NULL,
    [md_dateLastModified] DATETIME      NULL,
    [md_etlJob]           BIGINT        NULL,
    [md_etlExecution]     BIGINT        NULL,
    [md_etlRun]           BIGINT        NULL
);

