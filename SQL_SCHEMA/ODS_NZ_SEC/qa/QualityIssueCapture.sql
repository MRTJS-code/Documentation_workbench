CREATE TYPE [qa].[QualityIssueCapture] AS TABLE (
    [RecordId]        INT           NOT NULL,
    [FkQualityDetail] BIGINT        NULL,
    [FKQualityHeader] BIGINT        NULL,
    [Creator]         VARCHAR (100) NULL,
    [DateResolved]    DATETIME      NULL,
    [Severity]        VARCHAR (15)  NULL,
    [Summary]         VARCHAR (500) NULL,
    [RetryValue]      INT           NULL,
    [RetryMax]        INT           NULL);

