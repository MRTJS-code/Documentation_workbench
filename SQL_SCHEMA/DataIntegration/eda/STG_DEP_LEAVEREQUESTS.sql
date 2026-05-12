CREATE TABLE [eda].[STG_DEP_LEAVEREQUESTS] (
    [Id]          INT        NULL,
    [EmployeeId]  INT        NULL,
    [DateStart]   DATETIME   NULL,
    [DateEnd]     DATETIME   NULL,
    [Days]        FLOAT (53) NULL,
    [TotalHours]  FLOAT (53) NULL,
    [Status]      INT        NULL,
    [LeaveRuleId] INT        NULL
);

