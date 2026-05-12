CREATE TABLE [eda].[EXT_PR_PAYERROR] (
    [recordType]    VARCHAR (1)  NULL,
    [employeeRefId] VARCHAR (50) NULL,
    [costingDate]   DATE         NULL,
    [hoursCode]     VARCHAR (2)  NULL,
    [hoursAmount]   FLOAT (53)   NULL,
    [account]       VARCHAR (50) NULL,
    [department]    VARCHAR (10) NULL,
    [eventId]       INT          NULL,
    [assignmentId]  VARCHAR (20) NULL
);

