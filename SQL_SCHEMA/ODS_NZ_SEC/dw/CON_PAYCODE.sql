CREATE TABLE [dw].[CON_PAYCODE] (
    [SK_CON_Paycode]     INT           NOT NULL,
    [P_Paycode_Name]     VARCHAR (100) NULL,
    [P_Paycode_Category] VARCHAR (50)  NULL,
    [MD_DATE_MODIFIED]   DATE          NULL,
    [MD_LOGICAL_DELETE]  BIT           NULL,
    [MD_JOB_CODE]        INT           NULL,
    [MD_RUN_CODE]        BIGINT        NULL,
    [MD_ETL_RUN]         INT           NULL,
    PRIMARY KEY CLUSTERED ([SK_CON_Paycode] ASC)
);

