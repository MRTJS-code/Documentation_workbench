CREATE TABLE [ods].[LKP_GT_JOB] (
    [oid]           VARCHAR (34)  NOT NULL,
    [code]          VARCHAR (20)  NOT NULL,
    [name]          VARCHAR (121) NOT NULL,
    [status]        VARCHAR (50)  NOT NULL,
    [AXCC]          VARCHAR (13)  NULL,
    [GroupContract] VARCHAR (60)  NULL,
    [MajorContract] VARCHAR (50)  NULL,
    [StaticGuard]   BIT           NULL,
    [pcCode]        VARCHAR (50)  NULL,
    [pcName]        VARCHAR (50)  NULL
);

