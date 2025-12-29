CREATE TABLE [ods].[STG_GT_SUPPLIER] (
    [oid]        VARCHAR (34) NOT NULL,
    [code]       VARCHAR (13) NOT NULL,
    [name]       VARCHAR (51) NOT NULL,
    [status]     VARCHAR (50) NOT NULL,
    [supp_group] VARCHAR (55) NULL,
    PRIMARY KEY CLUSTERED ([oid] ASC)
);

