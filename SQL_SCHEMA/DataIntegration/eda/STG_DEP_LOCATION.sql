CREATE TABLE [eda].[STG_DEP_LOCATION] (
    [Id]            INT           NULL,
    [Code]          VARCHAR (50)  NULL,
    [Active]        BIT           NULL,
    [ParentId]      INT           NULL,
    [Name]          VARCHAR (255) NULL,
    [CompanyNumber] VARCHAR (100) NULL,
    [isWorkplace]   BIT           NULL,
    [isPayroll]     BIT           NULL,
    [Creator]       VARCHAR (50)  NULL,
    [Modified]      DATETIME      NULL
);

