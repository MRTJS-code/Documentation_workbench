CREATE TABLE [staging].[DEP_Employee] (
    [employeeId]      INT           NULL,
    [firstName]       VARCHAR (50)  NULL,
    [lastName]        VARCHAR (50)  NULL,
    [displayName]     VARCHAR (100) NULL,
    [startDate]       DATETIME      NULL,
    [terminationDate] DATETIME      NULL,
    [dateOfBirth]     DATETIME      NULL,
    [sendInvite]      BIT           NULL,
    [login]           VARCHAR (50)  NULL,
    [phone]           VARCHAR (50)  NULL,
    [email]           VARCHAR (200) NULL
);

