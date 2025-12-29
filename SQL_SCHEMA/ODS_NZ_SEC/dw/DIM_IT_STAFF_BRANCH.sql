CREATE TABLE [dw].[DIM_IT_STAFF_BRANCH] (
    [SK_DIM_IT_STAFF_BRANCH] BIGINT         IDENTITY (1, 1) NOT NULL,
    [FK_DIM_SECURITYGUARD]   BIGINT         NOT NULL,
    [FK_DIM_DEPOT]           INT            NULL,
    [P_EmployeeId]           NVARCHAR (255) NOT NULL,
    [P_BranchName]           NVARCHAR (100) NULL,
    [P_BranchReference]      NVARCHAR (50)  NULL,
    [P_EffectiveDate]        DATE           NULL,
    [P_ExpiryDate]           DATE           NULL,
    [MD_DATE_CREATED]        DATE           NULL,
    [MD_DATE_MODIFIED]       DATE           NULL,
    [MD_JOB_CODE]            INT            NULL,
    [MD_RUN_CODE]            BIGINT         NULL,
    [MD_PACK_NAME]           VARCHAR (70)   NULL,
    [MD_MODIFIED_USER]       VARCHAR (100)  NULL,
    [MD_LOGICAL_DELETE]      SMALLINT       NULL,
    CONSTRAINT [FK_DIM_IT_STAFF_BRANCH_DIM_DEPOT] FOREIGN KEY ([FK_DIM_DEPOT]) REFERENCES [dw].[DIM_DEPOT] ([SK_DIM_DEPOT]),
    CONSTRAINT [FK_DIM_IT_STAFF_BRANCH_DIM_SECURITYGUARD] FOREIGN KEY ([FK_DIM_SECURITYGUARD]) REFERENCES [dw].[DIM_SECURITYGUARD] ([SK_DIM_SECURITYGUARD])
);

