CREATE TABLE [dw].[DIM_PAYCODE_CLASS] (
    [SK_DIM_PAYCODE_CLASS] INT          IDENTITY (1, 1) NOT NULL,
    [PK_Code_Type]         VARCHAR (1)  NULL,
    [PK_Class_Code]        VARCHAR (1)  NULL,
    [PK_DW_Source_System]  VARCHAR (50) NULL,
    [P_Class_Desc]         VARCHAR (75) NULL,
    [MD_DATE_MODIFIED]     DATETIME     NULL,
    [MD_JOB_CODE]          INT          NULL,
    [MD_RUN_CODE]          BIGINT       NULL,
    [MD_ETL_RUN]           INT          NULL,
    [MD_LOGICAL_DELETE]    BIT          NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_PAYCODE_CLASS] ASC)
);

