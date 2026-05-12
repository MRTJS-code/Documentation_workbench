CREATE TABLE [dw].[DIM_IT_STAFF_UNIT] (
    [SK_DIM_IT_STAFF_UNIT] BIGINT         IDENTITY (1, 1) NOT NULL,
    [FK_DIM_SECURITYGUARD] BIGINT         NOT NULL,
    [P_EmployeeId]         NVARCHAR (255) NULL,
    [P_UnitName]           NVARCHAR (255) NULL,
    [P_UnitReference]      NVARCHAR (255) NULL,
    [P_ValidFrom]          DATE           NULL,
    [P_ValidTo]            DATE           NULL,
    [MD_DATE_CREATED]      DATE           NULL,
    [MD_DATE_MODIFIED]     DATE           NULL,
    [MD_JOB_CODE]          INT            NULL,
    [MD_RUN_CODE]          BIGINT         NULL,
    [MD_PACK_NAME]         VARCHAR (70)   NULL,
    [MD_MODIFIED_USER]     VARCHAR (100)  NULL,
    [MD_LOGICAL_DELETE]    SMALLINT       NULL
);

