CREATE TABLE [staging].[STG_IT_STAFF] (
    [employeeId]         VARCHAR (255) NOT NULL,
    [staffId]            BIGINT        NULL,
    [coa]                VARCHAR (255) NULL,
    [firstName]          VARCHAR (255) NULL,
    [middleName]         VARCHAR (255) NULL,
    [lastName]           VARCHAR (255) NULL,
    [hireDate]           DATE          NULL,
    [terminationDate]    DATE          NULL,
    [subcontractorGroup] VARCHAR (30)  NULL
);

