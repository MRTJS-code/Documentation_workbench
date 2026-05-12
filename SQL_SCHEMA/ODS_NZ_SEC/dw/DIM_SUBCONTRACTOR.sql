CREATE TABLE [dw].[DIM_SUBCONTRACTOR] (
    [SK_DIM_SUBCONTRACTOR] BIGINT         IDENTITY (1, 1) NOT NULL,
    [P_SubContractorName]  VARCHAR (255)  NOT NULL,
    [P_ORD_RatePerHour]    DECIMAL (8, 2) NULL,
    [P_PH_RatePerHour]     DECIMAL (8, 2) NULL,
    [P_Per_Revenue]        DECIMAL (4, 3) NULL,
    [MD_DATE_CREATED]      DATE           NULL,
    [MD_DATE_MODIFIED]     DATE           NULL,
    [MD_JOB_CODE]          INT            NULL,
    [MD_RUN_CODE]          BIGINT         NULL,
    [MD_PACK_NAME]         VARCHAR (70)   NULL,
    [MD_MODIFIED_USER]     VARCHAR (100)  NULL,
    [MD_LOGICAL_DELETE]    SMALLINT       NULL
);

