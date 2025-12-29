CREATE TABLE [eda].[LKP_IT_STAFFREGISTER] (
    [IT_ID]                VARCHAR (50)  NOT NULL,
    [COA_ID]               VARCHAR (50)  NULL,
    [PR_ID]                VARCHAR (50)  NULL,
    [IT_LOGIN]             VARCHAR (50)  NULL,
    [FIRSTNAME]            VARCHAR (100) NULL,
    [MIDDLENAME]           VARCHAR (100) NULL,
    [LASTNAME]             VARCHAR (100) NULL,
    [BIRTHDATE]            DATE          NULL,
    [EMPLOYER]             VARCHAR (100) NULL,
    [BRANCH]               VARCHAR (100) NULL,
    [COA_STATUS]           VARCHAR (20)  NULL,
    [COA_EXPIRY]           DATE          NULL,
    [IT_EXPIRY]            DATE          NULL,
    [DATE_LAST_ASSIGNMENT] DATE          NULL,
    [DATE_LAST_MODIFIED]   DATE          NULL,
    [IT_STATUS]            VARCHAR (20)  NULL,
    [LOGICAL_DELETE]       BIT           NULL,
    PRIMARY KEY CLUSTERED ([IT_ID] ASC)
);

