CREATE TABLE [agg].[DIM_Jobs_agg] (
    [oid]           VARCHAR (34)  NULL,
    [code]          VARCHAR (13)  NULL,
    [name]          VARCHAR (100) NULL,
    [status]        VARCHAR (50)  NULL,
    [AXCC]          VARCHAR (13)  NULL,
    [GroupContract] VARCHAR (60)  NULL,
    [MajorContract] VARCHAR (50)  NULL,
    [StaticGuard]   BIT           NULL,
    [pcCode]        VARCHAR (50)  NULL,
    [pcName]        VARCHAR (50)  NULL,
    [startDate]     DATE          NULL,
    [Is New Job]    VARCHAR (5)   NULL,
    [GroupCategory] VARCHAR (50)  NULL
);

