CREATE TABLE [ods].[LKP_REVIEW] (
    [id]          INT          IDENTITY (1, 1) NOT NULL,
    [sourceTable] VARCHAR (50) NOT NULL,
    [sourceKey]   VARCHAR (50) NOT NULL,
    [comments]    VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

