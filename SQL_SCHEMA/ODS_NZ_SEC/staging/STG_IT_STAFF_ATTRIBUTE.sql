CREATE TABLE [staging].[STG_IT_STAFF_ATTRIBUTE] (
    [employeeId]         VARCHAR (255) NULL,
    [attributeName]      VARCHAR (255) NULL,
    [attributeReference] VARCHAR (255) NULL,
    [attributeValue]     VARCHAR (255) NULL,
    [locationName]       VARCHAR (255) NULL,
    [locationReference]  VARCHAR (255) NULL,
    [activityName]       VARCHAR (255) NULL,
    [activityReference]  VARCHAR (255) NULL,
    [validFrom]          DATE          NULL,
    [validTo]            DATE          NULL,
    [note]               VARCHAR (MAX) NULL
);

