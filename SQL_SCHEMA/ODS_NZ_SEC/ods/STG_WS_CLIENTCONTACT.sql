CREATE TABLE [ods].[STG_WS_CLIENTCONTACT] (
    [ClientContactId] INT IDENTITY (1, 1) NOT NULL,
    [ClientId]        INT NOT NULL,
    [ContactId]       INT NOT NULL,
    PRIMARY KEY CLUSTERED ([ClientId] ASC, [ContactId] ASC)
);

