CREATE TABLE [staging].[PR_PAYCODE_CLASS] (
    [PK_Code_Type]     VARCHAR (1)  NULL,
    [PK_Class_Code]    VARCHAR (1)  NULL,
    [P_Class_Desc]     VARCHAR (75) NULL,
    [MD_DATE_MODIFIED] DATETIME     NULL,
    [MD_JOB_CODE]      INT          NULL,
    [MD_RUN_CODE]      BIGINT       NULL,
    [MD_ETL_RUN]       INT          NULL
);

