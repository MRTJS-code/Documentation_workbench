CREATE TABLE [ods].[STG_STAFF] (
    [StaffID]    BIGINT       IDENTITY (1, 1) NOT NULL,
    [FirstName]  VARCHAR (50) NULL,
    [LastName]   VARCHAR (50) NULL,
    [MiddleName] VARCHAR (50) NULL,
    [DOB]        DATE         NULL,
    [Source]     VARCHAR (50) NULL,
    [SourceRef]  VARCHAR (50) NULL,
    [Status]     VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([StaffID] ASC)
);

