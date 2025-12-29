CREATE TABLE [dw].[DIM_GT_GL] (
    [SK_DIM_GT_GL]      INT          IDENTITY (1, 1) NOT NULL,
    [FK_DIM_GT_COA]     INT          NULL,
    [FK_DIM_BRANCH]     INT          NULL,
    [FK_DIM_BUSINESS]   INT          NULL,
    [PK_oid_clsno]      INT          NOT NULL,
    [PK_oid_instid]     BIGINT       NOT NULL,
    [P_Account_No]      VARCHAR (32) NULL,
    [P_Account_Name]    VARCHAR (50) NULL,
    [P_Account_Type]    VARCHAR (50) NULL,
    [P_Account_Status]  VARCHAR (50) NULL,
    [MD_DATE_MODIFIED]  DATE         NULL,
    [MD_MODIFIED_USER]  VARCHAR (50) NULL,
    [MD_JOB_CODE]       INT          NULL,
    [MD_RUN_CODE]       BIGINT       NULL,
    [MD_ETL_RUN]        INT          NULL,
    [MD_LOGICAL_DELETE] BIT          NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_GT_GL] ASC),
    CONSTRAINT [FK_DIM_GT_GL_DIM_BRANCH] FOREIGN KEY ([FK_DIM_BRANCH]) REFERENCES [dw].[DIM_BRANCH] ([SK_DIM_BRANCH]),
    CONSTRAINT [FK_DIM_GT_GL_DIM_BUSINESS] FOREIGN KEY ([FK_DIM_BUSINESS]) REFERENCES [dw].[DIM_BUSINESS] ([SK_DIM_BUSINESS]),
    CONSTRAINT [FK_DIM_GT_GL_DIM_GT_COA] FOREIGN KEY ([FK_DIM_GT_COA]) REFERENCES [dw].[DIM_GT_COA] ([SK_DIM_GT_COA])
);


GO
CREATE NONCLUSTERED INDEX [IX_DIM_GT_GL_PK_oid_instid]
    ON [dw].[DIM_GT_GL]([PK_oid_instid] ASC, [PK_oid_clsno] ASC);

