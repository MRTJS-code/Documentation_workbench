CREATE TABLE [staging].[STG_ODS_GT_JOB] (
    [Oid_clsno]     INT           NOT NULL,
    [Oid_instid]    BIGINT        NOT NULL,
    [code]          VARCHAR (13)  NOT NULL,
    [name]          VARCHAR (100) NULL,
    [status]        VARCHAR (50)  NULL,
    [AXCC]          VARCHAR (13)  NULL,
    [GroupContract] VARCHAR (60)  NULL,
    [MajorContract] VARCHAR (50)  NULL,
    [StaticGuard]   BIT           NULL,
    [pcname]        VARCHAR (50)  NULL,
    [pccode]        VARCHAR (50)  NULL
);

