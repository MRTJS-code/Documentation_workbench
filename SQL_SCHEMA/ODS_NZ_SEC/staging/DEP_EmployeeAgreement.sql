CREATE TABLE [staging].[DEP_EmployeeAgreement] (
    [agreementId]       INT           NULL,
    [employeeId]        INT           NULL,
    [payrollId]         VARCHAR (100) NULL,
    [payCentreId]       INT           NULL,
    [payRuleId]         INT           NULL,
    [contractId]        INT           NULL,
    [contractName]      VARCHAR (100) NULL,
    [employeeType]      INT           NULL,
    [employeeBasis]     INT           NULL,
    [employeeCategory]  INT           NULL,
    [employeeStatus]    INT           NULL,
    [employeeCondition] INT           NULL,
    [isActive]          BIT           NULL,
    [startDate]         DATETIME      NULL,
    [endDate]           DATETIME      NULL,
    [payPeriod]         VARCHAR (100) NULL,
    [createdDate]       DATETIME      NULL,
    [modifiedDate]      DATETIME      NULL,
    [creator]           VARCHAR (100) NULL
);

