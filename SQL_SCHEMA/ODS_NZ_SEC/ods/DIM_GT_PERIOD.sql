CREATE TABLE [ods].[DIM_GT_PERIOD] (
    [oid]            VARCHAR (34) NOT NULL,
    [mnthDesc]       VARCHAR (10) NOT NULL,
    [mnthNo]         INT          NULL,
    [yearDesc]       VARCHAR (10) NOT NULL,
    [yearNo]         INT          NULL,
    [stDate]         DATETIME     NOT NULL,
    [enDate]         DATETIME     NOT NULL,
    [activeGLPeriod] BIT          NULL,
    [activeARPeriod] BIT          NULL,
    PRIMARY KEY CLUSTERED ([oid] ASC)
);

