CREATE TABLE [ods].[STG_WS_CONTACT] (
    [ClientId]      INT           NULL,
    [ContactId]     INT           NOT NULL,
    [Status]        BIT           NULL,
    [ContactTypeID] INT           NULL,
    [Name]          VARCHAR (128) NULL,
    [Email]         VARCHAR (MAX) NULL,
    [Phone]         VARCHAR (32)  NULL,
    [Mobile]        VARCHAR (32)  NULL,
    PRIMARY KEY CLUSTERED ([ContactId] ASC)
);

