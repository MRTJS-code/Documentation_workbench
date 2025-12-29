CREATE TABLE [ods].[LKP_IT_BRANCH] (
    [IT_Branch]        VARCHAR (50) NOT NULL,
    [Description]      VARCHAR (50) NULL,
    [branchID]         INT          NULL,
    [rosterExtract]    BIT          NULL,
    [empeeExtract]     BIT          NULL,
    [devRosterExtract] BIT          NULL,
    [devEmpeeExtract]  BIT          NULL,
    [workGroup]        VARCHAR (10) NULL,
    [uaBranch]         VARCHAR (50) NULL
);

