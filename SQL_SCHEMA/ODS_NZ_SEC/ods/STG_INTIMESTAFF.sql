CREATE TABLE [ods].[STG_INTIMESTAFF] (
    [employeeId]         NVARCHAR (255) NOT NULL,
    [staffId]            BIGINT         NULL,
    [coa]                NVARCHAR (255) NULL,
    [firstName]          NVARCHAR (255) NULL,
    [middleName]         NVARCHAR (255) NULL,
    [lastName]           NVARCHAR (255) NULL,
    [hireDate]           DATE           NULL,
    [terminationDate]    DATE           NULL,
    [CELL_PHONE]         VARCHAR (MAX)  NULL,
    [SMS]                VARCHAR (MAX)  NULL,
    [HOME_PHONE]         VARCHAR (MAX)  NULL,
    [WORK_PHONE]         VARCHAR (MAX)  NULL,
    [FAX]                VARCHAR (MAX)  NULL,
    [PAGER]              VARCHAR (MAX)  NULL,
    [OTHER]              VARCHAR (MAX)  NULL,
    [EMAIL]              VARCHAR (MAX)  NULL,
    [EMERGENCY]          VARCHAR (MAX)  NULL,
    [subcontractorGroup] VARCHAR (30)   NULL,
    PRIMARY KEY CLUSTERED ([employeeId] ASC)
);

