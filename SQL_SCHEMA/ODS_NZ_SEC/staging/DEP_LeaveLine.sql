CREATE TABLE [staging].[DEP_LeaveLine] (
    [Id]          INT        NULL,
    [LeaveId]     INT        NULL,
    [LeaveRuleId] INT        NULL,
    [AgreementId] INT        NULL,
    [TimesheetId] INT        NULL,
    [LeaveDate]   DATETIME   NULL,
    [LeaveStart]  DATETIME   NULL,
    [LeaveEnd]    DATETIME   NULL,
    [LeaveHours]  FLOAT (53) NULL,
    [LeaveCost]   FLOAT (53) NULL,
    [Modified]    DATETIME   NULL
);

