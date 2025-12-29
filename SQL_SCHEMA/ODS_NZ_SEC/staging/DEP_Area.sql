CREATE TABLE [staging].[DEP_Area] (
    [Id]                INT           NULL,
    [LocationId]        INT           NULL,
    [Name]              VARCHAR (100) NULL,
    [Active]            BIT           NULL,
    [PayrollExportName] VARCHAR (50)  NULL,
    [PayRuleId]         INT           NULL,
    [Creator]           VARCHAR (50)  NULL,
    [WorkType]          VARCHAR (50)  NULL,
    [Modified]          DATETIME      NULL
);

