CREATE TABLE [staging].[DIM_PR_LEAVEREASON] (
    [code]                VARCHAR (10)  NULL,
    [description]         VARCHAR (100) NULL,
    [md_dateLastModified] DATETIME      NULL,
    [md_etlJob]           INT           NULL,
    [md_etlExecution]     BIGINT        NULL,
    [md_etlRun]           INT           NULL
);

