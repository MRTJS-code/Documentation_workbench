CREATE TABLE [ods].[DIM_STAFF] (
    [StaffID]    BIGINT       IDENTITY (1, 1) NOT NULL,
    [IntRef]     VARCHAR (50) NULL,
    [FirstName]  VARCHAR (50) NULL,
    [LastName]   VARCHAR (50) NULL,
    [MiddleName] VARCHAR (50) NULL,
    [DOB]        DATE         NULL,
    [Status]     VARCHAR (50) NULL,
    [Type]       VARCHAR (50) NULL,
    [homeBranch] INT          NULL,
    PRIMARY KEY CLUSTERED ([StaffID] ASC)
);

