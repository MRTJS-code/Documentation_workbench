CREATE TABLE [staging].[DEP_LeaveRules] (
    [Id]              INT           NULL,
    [Name]            VARCHAR (100) NULL,
    [PaidLeave]       BIT           NULL,
    [Visible]         BIT           NULL,
    [UnitType]        INT           NULL,
    [PayrollCategory] VARCHAR (100) NULL,
    [CalcType]        INT           NULL,
    [Created]         DATETIME      NULL,
    [Modified]        DATETIME      NULL,
    [Creator]         VARCHAR (100) NULL
);

