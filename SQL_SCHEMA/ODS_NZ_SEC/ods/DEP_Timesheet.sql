CREATE TABLE [ods].[DEP_Timesheet] (
    [id]              INT             IDENTITY (1, 1) NOT NULL,
    [timesheetId]     INT             NOT NULL,
    [workAreaSK]      INT             NOT NULL,
    [employeeSK]      INT             NOT NULL,
    [rosterSK]        INT             NOT NULL,
    [timesheetDate]   DATE            NOT NULL,
    [timesheetStart]  DATETIME        NOT NULL,
    [timesheetEnd]    DATETIME        NOT NULL,
    [timesheetHours]  DECIMAL (5, 2)  NOT NULL,
    [timesheetCost]   DECIMAL (10, 2) NOT NULL,
    [jobCode]         NVARCHAR (50)   NULL,
    [payrollCode]     NVARCHAR (50)   NULL,
    [activityCode]    NVARCHAR (50)   NULL,
    [payCycleId]      INT             NOT NULL,
    [isAutoProcessed] BIT             NOT NULL,
    [isAutoApproved]  BIT             NOT NULL,
    [status]          NVARCHAR (50)   NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

