CREATE TABLE [eda].[STG_EMPEEDATA] (
    [employeeId]      VARCHAR (50)  NULL,
    [externalId]      VARCHAR (50)  NULL,
    [selfServiceId]   VARCHAR (50)  NULL,
    [firstName]       VARCHAR (100) NULL,
    [middleName]      VARCHAR (100) NULL,
    [lastName]        VARCHAR (100) NULL,
    [displayName]     VARCHAR (100) NULL,
    [birthDate]       DATE          NULL,
    [anniversaryDate] DATE          NULL,
    [addressLine1]    VARCHAR (150) NULL,
    [addressLine2]    VARCHAR (150) NULL,
    [city]            VARCHAR (100) NULL,
    [provinceState]   VARCHAR (100) NULL,
    [postalCode]      VARCHAR (10)  NULL,
    [otherId]         VARCHAR (50)  NULL,
    [punchId]         VARCHAR (50)  NULL
);

