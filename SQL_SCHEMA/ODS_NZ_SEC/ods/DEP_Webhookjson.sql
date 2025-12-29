CREATE TABLE [ods].[DEP_Webhookjson] (
    [id]         INT            IDENTITY (1, 1) NOT NULL,
    [webhook]    NVARCHAR (MAX) NOT NULL,
    [jsonString] NVARCHAR (MAX) NOT NULL,
    [createDate] DATETIME       DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

