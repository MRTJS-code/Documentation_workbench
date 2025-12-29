CREATE TABLE [eda].[LKP_PR_PAYCODE] (
    [codeType]            VARCHAR (1)   NULL,
    [code]                VARCHAR (10)  NULL,
    [description]         VARCHAR (100) NULL,
    [md_dateLastModified] DATETIME      NULL,
    [md_etlJob]           INT           NULL,
    [md_etlExecution]     BIGINT        NULL,
    [md_etlRun]           INT           NULL,
    [md_etlEventId]       INT           NULL
);

