CREATE TABLE [ods].[DEP_RosterHistory] (
    [id]              INT             IDENTITY (1, 1) NOT NULL,
    [rosterId]        INT             NOT NULL,
    [rosterType]      NVARCHAR (50)   NOT NULL,
    [employeeSK]      INT             NOT NULL,
    [workAreaSK]      INT             NOT NULL,
    [shiftDate]       DATE            NOT NULL,
    [shiftStart]      TIME (7)        NOT NULL,
    [shiftEnd]        TIME (7)        NOT NULL,
    [shiftHours]      DECIMAL (5, 2)  NOT NULL,
    [shiftCost]       DECIMAL (10, 2) NOT NULL,
    [shiftRevenue]    DECIMAL (10, 2) NOT NULL,
    [jobCode]         NVARCHAR (50)   NULL,
    [payrollCode]     NVARCHAR (50)   NULL,
    [activityCode]    NVARCHAR (50)   NULL,
    [warning]         NVARCHAR (255)  NULL,
    [warningOverride] NVARCHAR (255)  NULL,
    [isOpen]          BIT             NOT NULL,
    [isLocked]        BIT             NOT NULL,
    [isDeleted]       BIT             NOT NULL,
    [modifiedDate]    DATETIME        NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

