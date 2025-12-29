CREATE TABLE [dw].[DIM_GT_COA] (
    [SK_DIM_GT_COA]     INT          IDENTITY (1, 1) NOT NULL,
    [PK_GT_Account]     VARCHAR (5)  NOT NULL,
    [FK_DIM_AX_COA]     INT          NULL,
    [P_Account_Name]    VARCHAR (50) NOT NULL,
    [MD_DATE_MODIFIED]  DATE         NULL,
    [MD_JOB_CODE]       INT          NULL,
    [MD_RUN_CODE]       BIGINT       NULL,
    [MD_ETL_RUN]        INT          NULL,
    [MD_LOGICAL_DELETE] BIT          NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_GT_COA] ASC),
    CONSTRAINT [FK_DIM_GT_COA_DIM_AX_COA] FOREIGN KEY ([FK_DIM_AX_COA]) REFERENCES [dw].[DIM_AX_COA] ([SK_DIM_AX_COA])
);

