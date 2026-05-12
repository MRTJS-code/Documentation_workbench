CREATE TABLE [staging].[STG_JOB_PRICE] (
    [Oid_clsno]  INT             NOT NULL,
    [Oid_instid] BIGINT          NOT NULL,
    [PriceCode]  VARCHAR (10)    NULL,
    [PriceName]  VARCHAR (30)    NULL,
    [ordRate]    DECIMAL (20, 5) NULL,
    [T15Rate]    DECIMAL (20, 5) NULL
);

