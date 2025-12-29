CREATE TABLE [eda].[LKP_WorkingDay] (
    [employeeId]           INT           NULL,
    [employeeRef]          VARCHAR (100) NULL,
    [employeeName]         VARCHAR (100) NULL,
    [mainWorkingDay]       INT           NULL,
    [altWorkingDay]        INT           NULL,
    [mainStatHolidayTaken] BIT           NULL,
    [altStatHolidayTaken]  BIT           NULL,
    [mainAvHours]          FLOAT (53)    NULL,
    [altAvHours]           FLOAT (53)    NULL
);

