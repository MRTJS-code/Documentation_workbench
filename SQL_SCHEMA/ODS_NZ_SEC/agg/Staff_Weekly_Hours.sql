CREATE TABLE [agg].[Staff_Weekly_Hours] (
    [itStaffId]            NVARCHAR (255)   NULL,
    [Weekly Hours]         NUMERIC (38, 10) NULL,
    [Unused Weekly Hours]  NUMERIC (38, 10) NULL,
    [WeekNumber]           INT              NULL,
    [Month]                INT              NULL,
    [RosterAssignmentYear] INT              NULL,
    [YearMonth]            VARCHAR (27)     NULL
);

