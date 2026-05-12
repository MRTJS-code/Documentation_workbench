CREATE TABLE [ods].[APP_IT_UNASSIGNED] (
    [id]             INT              IDENTITY (1, 1) NOT NULL,
    [branch]         NVARCHAR (255)   NULL,
    [itCustomer]     NVARCHAR (255)   NULL,
    [itLocation]     NVARCHAR (255)   NULL,
    [itSubLocation]  NVARCHAR (255)   NULL,
    [assignmentDate] DATE             NULL,
    [dateFrom]       DATETIME         NULL,
    [dateTo]         DATETIME         NULL,
    [unassignedHrs]  NUMERIC (28, 10) NULL,
    [status]         VARCHAR (20)     NULL,
    [lastUpdated]    DATE             NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

