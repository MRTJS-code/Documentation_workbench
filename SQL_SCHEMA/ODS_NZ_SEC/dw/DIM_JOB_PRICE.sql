CREATE TABLE [dw].[DIM_JOB_PRICE] (
    [SK_DIM_JOB_PRICE]  BIGINT          IDENTITY (1, 1) NOT NULL,
    [P_Oid_clsno]       INT             NOT NULL,
    [P_Oid_instid]      BIGINT          NOT NULL,
    [P_PriceCode]       VARCHAR (10)    NULL,
    [P_PriceName]       VARCHAR (30)    NULL,
    [P_ordRate]         DECIMAL (20, 5) NULL,
    [P_T15Rate]         DECIMAL (20, 5) NULL,
    [MD_DATE_CREATED]   DATE            NULL,
    [MD_DATE_MODIFIED]  DATE            NULL,
    [MD_JOB_CODE]       INT             NULL,
    [MD_RUN_CODE]       BIGINT          NULL,
    [MD_PACK_NAME]      VARCHAR (70)    NULL,
    [MD_MODIFIED_USER]  VARCHAR (100)   NULL,
    [MD_LOGICAL_DELETE] SMALLINT        NULL,
    CONSTRAINT [PK_DIM_JOB_PRICE] PRIMARY KEY CLUSTERED ([SK_DIM_JOB_PRICE] ASC)
);

