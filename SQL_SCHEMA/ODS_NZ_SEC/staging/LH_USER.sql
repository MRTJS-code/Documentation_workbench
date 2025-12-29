CREATE TABLE [staging].[LH_USER] (
    [Application_id]      VARCHAR (255) NULL,
    [User_username]       VARCHAR (255) NULL,
    [App_user_id]         VARCHAR (255) NULL,
    [Firstname]           VARCHAR (255) NULL,
    [Lastname]            VARCHAR (255) NULL,
    [LoggedIn]            VARCHAR (255) NULL,
    [LoggedOut]           VARCHAR (255) NULL,
    [User_Role]           VARCHAR (255) NULL,
    [User_id]             VARCHAR (255) NULL,
    [User_email]          VARCHAR (255) NULL,
    [Revisionnumber]      VARCHAR (255) NULL,
    [User_created_at]     VARCHAR (255) NULL,
    [User_updated_at]     VARCHAR (255) NULL,
    [md_filename]         VARCHAR (255) NULL,
    [md_dateLastModified] DATETIME      NULL,
    [md_etlJob]           BIGINT        NULL,
    [md_etlExecution]     BIGINT        NULL,
    [md_etlRun]           BIGINT        NULL
);

