CREATE TABLE [staging].[GHS_ORGANISATIONS] (
    [id]                 BIGINT        NULL,
    [title]              VARCHAR (256) NULL,
    [url]                VARCHAR (256) NULL,
    [full_url]           VARCHAR (256) NULL,
    [country]            VARCHAR (256) NULL,
    [timezone]           VARCHAR (256) NULL,
    [address]            VARCHAR (256) NULL,
    [region]             VARCHAR (256) NULL,
    [city]               VARCHAR (256) NULL,
    [email]              VARCHAR (256) NULL,
    [phone_number]       VARCHAR (256) NULL,
    [organisation_group] VARCHAR (256) NULL,
    [enterprise_id]      VARCHAR (256) NULL,
    [created_at]         DATETIME      NULL,
    [updated_at]         DATETIME      NULL
);

