CREATE TABLE [ods].[DIM_JOB2] (
    [oid]           VARCHAR (34)  NOT NULL,
    [code]          VARCHAR (13)  NOT NULL,
    [name]          VARCHAR (100) NOT NULL,
    [status]        VARCHAR (50)  NOT NULL,
    [AXCC]          VARCHAR (13)  NULL,
    [GroupContract] VARCHAR (60)  NULL,
    [MajorContract] VARCHAR (50)  NULL,
    [StaticGuard]   BIT           NULL,
    [pcCode]        VARCHAR (50)  NULL,
    [pcName]        VARCHAR (50)  NULL,
    [brId]          INT           NULL,
    [bsId]          INT           NULL
);

