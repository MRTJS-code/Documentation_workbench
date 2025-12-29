CREATE TABLE [qa].[QualityDwhError] (
    [Id]               BIGINT        IDENTITY (1, 1) NOT NULL,
    [SourceSystem]     VARCHAR (50)  NOT NULL,
    [DwhTable]         VARCHAR (100) NOT NULL,
    [SourcePK]         BIGINT        NULL,
    [SourcePKStr]      VARCHAR (50)  NULL,
    [SourceRecordName] VARCHAR (100) NOT NULL,
    [DwhErrorType]     VARCHAR (50)  NULL,
    [DateFound]        DATETIME      NOT NULL,
    [DateResolved]     DATETIME      NULL,
    [QACode]           INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

