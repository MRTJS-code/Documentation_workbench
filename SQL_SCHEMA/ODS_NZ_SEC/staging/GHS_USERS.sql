CREATE TABLE [staging].[GHS_USERS] (
    [id]                BIGINT        NULL,
    [full_name]         VARCHAR (256) NULL,
    [first_name]        VARCHAR (256) NULL,
    [last_name]         VARCHAR (256) NULL,
    [email]             VARCHAR (256) NULL,
    [cc_email]          VARCHAR (256) NULL,
    [country]           VARCHAR (256) NULL,
    [mobile]            VARCHAR (256) NULL,
    [alternative_phone] VARCHAR (256) NULL,
    [timezone]          VARCHAR (256) NULL,
    [status]            VARCHAR (256) NULL,
    [invitation_status] VARCHAR (256) NULL,
    [created_at]        DATETIME      NULL,
    [updated_at]        DATETIME      NULL,
    [last_login]        DATETIME      NULL
);

