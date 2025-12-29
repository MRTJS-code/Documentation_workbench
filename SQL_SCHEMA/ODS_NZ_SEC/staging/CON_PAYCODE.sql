CREATE TABLE [staging].[CON_PAYCODE] (
    [conCode]           INT           NULL,
    [description]       VARCHAR (100) NULL,
    [category]          VARCHAR (50)  NULL,
    [MD_DATE_MODIFIED]  DATE          NULL,
    [MD_LOGICAL_DELETE] BIT           NULL,
    [MD_JOB_CODE]       INT           NULL,
    [MD_RUN_CODE]       BIGINT        NULL,
    [MD_ETL_RUN]        INT           NULL
);

