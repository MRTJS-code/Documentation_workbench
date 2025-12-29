CREATE TABLE [eda].[STG_DEPTIMESHEETLINEBKP] (
    [Id]              INT           NULL,
    [TimesheetId]     INT           NULL,
    [PayRuleId]       INT           NULL,
    [Hours]           FLOAT (53)    NULL,
    [Cost]            FLOAT (53)    NULL,
    [Overridden]      BIT           NULL,
    [OverrideComment] VARCHAR (100) NULL
);

