CREATE TABLE [dw].[DIM_IT_STAFF_ATTRIBUTE] (
    [SK_DIM_IT_STAFF_ATT]  BIGINT         IDENTITY (1, 1) NOT NULL,
    [FK_DIM_SECURITYGUARD] BIGINT         NOT NULL,
    [P_EmployeeId]         NVARCHAR (255) NULL,
    [P_AttributeName]      NVARCHAR (255) NULL,
    [P_AttributeReference] NVARCHAR (255) NULL,
    [P_AttributeValue]     NVARCHAR (255) NULL,
    [P_LocationName]       NVARCHAR (255) NULL,
    [P_LocationReference]  NVARCHAR (255) NULL,
    [P_ActivityName]       NVARCHAR (255) NULL,
    [P_ActivityReference]  NVARCHAR (255) NULL,
    [P_ValidFrom]          SMALLDATETIME  NULL,
    [P_ValidTo]            SMALLDATETIME  NULL,
    [P_Note]               NVARCHAR (255) NULL,
    [MD_DATE_CREATED]      DATE           NULL,
    [MD_DATE_MODIFIED]     DATE           NULL,
    [MD_JOB_CODE]          INT            NULL,
    [MD_RUN_CODE]          BIGINT         NULL,
    [MD_PACK_NAME]         VARCHAR (70)   NULL,
    [MD_MODIFIED_USER]     VARCHAR (100)  NULL,
    [MD_LOGICAL_DELETE]    SMALLINT       NULL
);

