CREATE TABLE [agg].[GT_AVRATE] (
    [job]            VARCHAR (34)    NULL,
    [organisation]   VARCHAR (34)    NULL,
    [period]         VARCHAR (34)    NULL,
    [sourceTranType] VARCHAR (31)    NULL,
    [brId]           INT             NOT NULL,
    [bsId]           INT             NOT NULL,
    [avRate]         NUMERIC (38, 6) NULL
);

