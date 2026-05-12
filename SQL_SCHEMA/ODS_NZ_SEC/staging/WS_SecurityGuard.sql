CREATE TABLE [staging].[WS_SecurityGuard] (
    [EmployeeId]          INT           NULL,
    [TableSource]         VARCHAR (13)  NULL,
    [EmployeeCode]        VARCHAR (128) NULL,
    [StaffID]             VARCHAR (128) NULL,
    [LicenceNo]           VARCHAR (128) NULL,
    [Employed]            BIT           NULL,
    [FirstName]           VARCHAR (128) NULL,
    [MiddleName]          VARCHAR (128) NULL,
    [LastName]            VARCHAR (128) NULL,
    [DOB]                 DATETIME      NULL,
    [EmailAddress]        VARCHAR (MAX) NULL,
    [ContactPhoneNo]      VARCHAR (128) NULL,
    [ContactMobileNo]     VARCHAR (128) NULL,
    [EmploymentStartDate] DATETIME      NULL,
    [EmploymentEndDate]   DATETIME      NULL,
    [ReportsToEmployeeId] INT           NULL,
    [SubcontractorName]   VARCHAR (128) NULL,
    [StateId]             INT           NULL
);

