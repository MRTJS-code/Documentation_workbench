CREATE TABLE [staging].[STG_IT_STAFF_RANK] (
    [employeeId]    VARCHAR (255) NULL,
    [rankReference] VARCHAR (255) NULL,
    [note]          VARCHAR (MAX) NULL,
    [rankName]      VARCHAR (255) NULL,
    [rankShortName] VARCHAR (255) NULL,
    [effectiveDate] DATE          NULL,
    [expiryDate]    DATE          NULL
);

