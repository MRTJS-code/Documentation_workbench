CREATE TABLE [staging].[STG_GT_PROFITCENTRE] (
    [Oid_clsno]  INT          NOT NULL,
    [Oid_instid] BIGINT       NOT NULL,
    [code]       VARCHAR (12) NULL,
    [glAccount]  VARCHAR (30) NULL,
    [name]       VARCHAR (50) NULL,
    [brCode]     VARCHAR (2)  NULL,
    [bsCode]     VARCHAR (2)  NULL,
    [brId]       INT          NULL,
    [bsId]       INT          NULL
);

