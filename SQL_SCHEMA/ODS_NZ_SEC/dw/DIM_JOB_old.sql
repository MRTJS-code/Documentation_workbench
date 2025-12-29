CREATE TABLE [dw].[DIM_JOB_old] (
    [SK_DIM_Job]           BIGINT        IDENTITY (1, 1) NOT NULL,
    [dim_ProfitCentre_key] BIGINT        NULL,
    [P_Oid_clsno]          INT           NOT NULL,
    [P_Oid_instid]         BIGINT        NOT NULL,
    [P_Code]               VARCHAR (13)  NULL,
    [P_Name]               VARCHAR (100) NULL,
    [P_Status]             VARCHAR (50)  NULL,
    [P_AXCC]               VARCHAR (13)  NULL,
    [P_GroupContract]      VARCHAR (60)  NULL,
    [P_MajorContract]      VARCHAR (50)  NULL,
    [P_StaticGuard]        BIT           NULL,
    [P_startDate]          DATE          NULL,
    [MD_DATE_CREATED]      DATE          NULL,
    [MD_DATE_MODIFIED]     DATE          NULL,
    [MD_JOB_CODE]          INT           NULL,
    [MD_RUN_CODE]          BIGINT        NULL,
    [MD_PACK_NAME]         VARCHAR (70)  NULL,
    [MD_MODIFIED_USER]     VARCHAR (100) NULL,
    [MD_LOGICAL_DELETE]    SMALLINT      NULL
);

