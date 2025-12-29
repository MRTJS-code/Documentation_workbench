CREATE TABLE [staging].[DEP_EmployeeBranchLocation] (
    [Id]            INT           NULL,
    [Company]       INT           NULL,
    [isActive]      BIT           NULL,
    [customfieldId] INT           NULL,
    [contactId]     INT           NULL,
    [employer]      VARCHAR (200) NULL,
    [coa]           VARCHAR (200) NULL,
    [dnr]           VARCHAR (200) NULL,
    [Role]          VARCHAR (100) NULL,
    [Creator]       VARCHAR (100) NULL,
    [Created]       DATETIME      NULL,
    [Modified]      DATETIME      NULL
);

