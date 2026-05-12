CREATE TABLE [staging].[GT_PERIOD] (
    [oid_clsno]      INT          NULL,
    [oid_instid]     BIGINT       NULL,
    [mnthDesc]       VARCHAR (10) NULL,
    [yearDesc]       VARCHAR (30) NULL,
    [stDate]         DATE         NULL,
    [enDate]         DATE         NULL,
    [activeGLPeriod] BIT          NULL,
    [activeARPeriod] BIT          NULL,
    [mnthNo]         INT          NULL,
    [yearNo]         INT          NULL
);

