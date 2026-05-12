CREATE TABLE [eda].[STG_EMPEEATTRIBUTE] (
    [employeeId]         VARCHAR (50)  NULL,
    [attributeName]      VARCHAR (200) NULL,
    [attributeReference] VARCHAR (50)  NULL,
    [attributeValue]     VARCHAR (200) NULL,
    [locationName]       VARCHAR (200) NULL,
    [locationReference]  VARCHAR (50)  NULL,
    [activityName]       VARCHAR (200) NULL,
    [activityReference]  VARCHAR (50)  NULL,
    [validFrom]          DATE          NULL,
    [validTo]            DATE          NULL,
    [note]               VARCHAR (MAX) NULL
);

