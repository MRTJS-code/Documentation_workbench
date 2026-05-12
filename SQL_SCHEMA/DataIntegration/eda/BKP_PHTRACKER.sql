CREATE TABLE [eda].[BKP_PHTRACKER] (
    [EmployeeId]    INT         NULL,
    [phRef]         INT         NULL,
    [altCredit]     BIT         NOT NULL,
    [timesheetDate] DATE        NULL,
    [dateType]      VARCHAR (4) NOT NULL,
    [isNational]    BIT         NULL,
    [MDEventId]     BIGINT      NULL
);

