CREATE TABLE [staging].[STG_IT_ROSTERHEAD] (
    [assignmentId]   BIGINT         NULL,
    [employeeName]   NVARCHAR (255) NULL,
    [employeeRefId]  NVARCHAR (255) NULL,
    [branchName]     NVARCHAR (255) NULL,
    [branchRef]      NVARCHAR (255) NULL,
    [origin]         NVARCHAR (255) NULL,
    [assignmentDate] DATE           NULL,
    [rosterStart]    DATETIME       NULL,
    [rosterEnd]      DATETIME       NULL,
    [actualStart]    DATETIME       NULL,
    [actualEnd]      DATETIME       NULL,
    [branchID]       INT            NULL,
    [extractBranch]  NVARCHAR (25)  NULL
);

