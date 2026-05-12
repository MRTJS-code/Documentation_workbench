CREATE TABLE [staging].[DIM_PR_PAYCODE] (
    [code]                VARCHAR (10)  NULL,
    [description]         VARCHAR (100) NULL,
    [shortDescription]    VARCHAR (50)  NULL,
    [clasification]       VARCHAR (50)  NULL,
    [includeInAWE]        BIT           NULL,
    [includeInOWP]        BIT           NULL,
    [includeInADP]        BIT           NULL,
    [md_dateLastModified] DATETIME      NULL,
    [md_etlJob]           INT           NULL,
    [md_etlExecution]     BIGINT        NULL,
    [md_etlRun]           INT           NULL,
    [type]                VARCHAR (1)   NULL,
    [incHrsInLeaveAcr]    BIT           NULL
);

