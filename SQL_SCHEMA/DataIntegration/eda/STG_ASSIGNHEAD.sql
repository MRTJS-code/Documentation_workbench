CREATE TABLE [eda].[STG_ASSIGNHEAD] (
    [assignmentId]       BIGINT        NULL,
    [date]               DATE          NULL,
    [assignmentDate]     DATE          NULL,
    [branchName]         VARCHAR (200) NULL,
    [branchRef]          VARCHAR (50)  NULL,
    [scheduledStartTime] DATETIME      NULL,
    [scheduledEndTime]   DATETIME      NULL,
    [actualStartTime]    DATETIME      NULL,
    [actualEndTime]      DATETIME      NULL,
    [origin]             VARCHAR (25)  NULL,
    [employeeName]       VARCHAR (255) NULL,
    [employeeRefId]      VARCHAR (50)  NULL
);

