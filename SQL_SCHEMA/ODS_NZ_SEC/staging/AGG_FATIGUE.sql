CREATE TABLE [staging].[AGG_FATIGUE] (
    [employeeId]     NVARCHAR (255)   NOT NULL,
    [staffId]        BIGINT           NULL,
    [assignmentDate] DATETIME         NOT NULL,
    [breakCompliant] INT              NULL,
    [wHrsWorked]     NUMERIC (38, 10) NULL,
    [wDaysWorked]    INT              NULL
);

