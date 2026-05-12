CREATE TABLE [eda].[EXT_IT_PAYLEGACY] (
    [id]               BIGINT        IDENTITY (1, 1) NOT NULL,
    [lineType]         VARCHAR (2)   NULL,
    [employeeRefId]    VARCHAR (50)  NULL,
    [payrollTransType] VARCHAR (100) NULL,
    [lineDate]         DATE          NULL,
    [hrs]              FLOAT (53)    NULL,
    [narration]        VARCHAR (MAX) NULL,
    [classification]   INT           NULL,
    [jobCode]          VARCHAR (50)  NULL,
    [activityCode]     VARCHAR (100) NULL,
    [workCentre]       INT           NULL,
    [dateEnd]          DATE          NULL,
    [startTime]        TIME (7)      NULL,
    [endTime]          TIME (7)      NULL,
    [rate]             INT           NULL,
    [daysWorked]       INT           NULL,
    [warnings]         VARCHAR (100) NULL,
    [eventId]          INT           NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

