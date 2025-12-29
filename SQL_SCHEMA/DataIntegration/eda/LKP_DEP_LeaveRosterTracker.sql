CREATE TABLE [eda].[LKP_DEP_LeaveRosterTracker] (
    [EmployeeId]     INT      NOT NULL,
    [RosterId]       INT      NOT NULL,
    [AreaId]         INT      NOT NULL,
    [RosterDate]     DATE     NOT NULL,
    [LeaveLineId]    INT      NULL,
    [MD_CreateDate]  DATETIME NOT NULL,
    [MD_PublishDate] DATETIME NULL,
    [MD_RemovedDate] DATETIME NULL,
    [MD_DeleteDate]  DATETIME NULL
);

