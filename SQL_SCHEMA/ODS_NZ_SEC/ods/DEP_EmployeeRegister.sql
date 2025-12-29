CREATE TABLE [ods].[DEP_EmployeeRegister] (
    [id]             INT            IDENTITY (1, 1) NOT NULL,
    [employeeId]     INT            NOT NULL,
    [loginId]        INT            NULL,
    [homeLocationSK] INT            NOT NULL,
    [younityId]      INT            NULL,
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
    PRIMARY KEY CLUSTERED ([id] ASC)
);

