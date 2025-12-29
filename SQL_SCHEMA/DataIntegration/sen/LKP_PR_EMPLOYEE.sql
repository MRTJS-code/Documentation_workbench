CREATE TABLE [sen].[LKP_PR_EMPLOYEE] (
    [idNumber]            VARCHAR (50)    NULL,
    [fullName]            VARCHAR (200)   NULL,
    [personalEmail]       VARCHAR (100)   NULL,
    [termDate]            DATE            NULL,
    [baseHrs]             NUMERIC (3)     NULL,
    [region]              VARCHAR (5)     NULL,
    [payFrequency]        VARCHAR (1)     NULL,
    [payRate1]            NUMERIC (11, 5) NULL,
    [payRate4]            NUMERIC (11, 5) NULL,
    [md_dateLastModified] DATETIME        NULL,
    [md_etlJob]           INT             NULL,
    [md_etlExecution]     BIGINT          NULL,
    [md_etlRun]           INT             NULL,
    [md_eventId]          INT             NULL
);

