CREATE TABLE [lookup].[GTAR_D365AR_Map] (
    [oid_clsno]      INT          NOT NULL,
    [oid_instid]     BIGINT       NOT NULL,
    [debtorCode]     VARCHAR (12) NULL,
    [debtorName]     VARCHAR (50) NULL,
    [D365DebtorCode] TEXT         NULL
);

