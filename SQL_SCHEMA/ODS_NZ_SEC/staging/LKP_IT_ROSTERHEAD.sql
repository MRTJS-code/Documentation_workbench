CREATE TABLE [staging].[LKP_IT_ROSTERHEAD] (
    [assignmentId]       BIGINT         NULL,
    [date]               NVARCHAR (255) NULL,
    [employeeName]       NVARCHAR (255) NULL,
    [employeeRefId]      NVARCHAR (255) NULL,
    [assignmentDate]     NVARCHAR (255) NULL,
    [branchName]         NVARCHAR (255) NULL,
    [branchRef]          NVARCHAR (255) NULL,
    [scheduledStartTime] NVARCHAR (255) NULL,
    [scheduledEndTime]   NVARCHAR (255) NULL,
    [origin]             NVARCHAR (255) NULL,
    [actualStartTime]    NVARCHAR (255) NULL,
    [actualEndTime]      NVARCHAR (255) NULL,
    [extractBranch]      NVARCHAR (25)  NULL
);

