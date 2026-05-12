CREATE TABLE [dw].[DIM_PROFITCENTRE] (
    [SK_DIM_ProfitCentre] BIGINT        IDENTITY (1, 1) NOT NULL,
    [P_Oid_clsno]         INT           NOT NULL,
    [P_Oid_instid]        BIGINT        NOT NULL,
    [P_code]              VARCHAR (12)  NULL,
    [P_glAccount]         VARCHAR (30)  NULL,
    [P_name]              VARCHAR (50)  NULL,
    [P_brCode]            VARCHAR (2)   NULL,
    [P_bsCode]            VARCHAR (2)   NULL,
    [P_brId]              INT           NULL,
    [P_bsId]              INT           NULL,
    [MD_DATE_CREATED]     DATE          NULL,
    [MD_DATE_MODIFIED]    DATE          NULL,
    [MD_JOB_CODE]         INT           NULL,
    [MD_RUN_CODE]         BIGINT        NULL,
    [MD_PACK_NAME]        VARCHAR (70)  NULL,
    [MD_MODIFIED_USER]    VARCHAR (100) NULL,
    [MD_LOGICAL_DELETE]   SMALLINT      NULL,
    CONSTRAINT [PK_DIM_PROFITCENTRE] PRIMARY KEY CLUSTERED ([SK_DIM_ProfitCentre] ASC),
    CONSTRAINT [FK_DIM_PROFITCENTRE_DIM_BRANCH] FOREIGN KEY ([P_brId]) REFERENCES [dw].[DIM_BRANCH] ([SK_DIM_BRANCH]),
    CONSTRAINT [FK_DIM_PROFITCENTRE_DIM_BUSINESS] FOREIGN KEY ([P_bsId]) REFERENCES [dw].[DIM_BUSINESS] ([SK_DIM_BUSINESS])
);

