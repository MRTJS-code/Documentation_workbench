CREATE TABLE [ods].[DEP_EmployeeRegister_test] (
    [id]             INT            IDENTITY (1, 1) NOT NULL,
    [employeeId]     INT            NOT NULL,
    [loginId]        INT            NULL,
    [homeLocationSK] INT            NOT NULL,
    [younityId]      VARCHAR (100)  NULL,
    [contractorId]   NVARCHAR (7)   NULL,
    [firstName]      NVARCHAR (100) NOT NULL,
    [lastName]       NVARCHAR (100) NOT NULL,
    [displayName]    NVARCHAR (200) NULL,
    [isActive]       BIT            NOT NULL,
    [isDeleted]      BIT            NOT NULL,
    [startDate]      DATETIME       NULL,
    [termDate]       DATETIME       NULL,
    [modifiedDate]   DATETIME       NOT NULL,
    [lastLogin]      DATETIME       NULL,
    [createdBy]      NVARCHAR (100) NOT NULL,
    [sendInvite]     BIT            NULL,
    [coa]            VARCHAR (200)  NULL,
    [Role]           VARCHAR (50)   NULL,
    [dnr]            VARCHAR (200)  NULL,
    [employer]       VARCHAR (100)  NULL
);

