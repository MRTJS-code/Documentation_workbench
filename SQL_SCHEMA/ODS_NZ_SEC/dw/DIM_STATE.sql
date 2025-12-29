CREATE TABLE [dw].[DIM_STATE] (
    [SK_DIM_STATE]        INT          IDENTITY (1, 1) NOT NULL,
    [PK_DW_Source_System] VARCHAR (50) NOT NULL,
    [PK_State_Id]         INT          NULL,
    [P_State_Code]        VARCHAR (64) NULL,
    [P_State_Name]        VARCHAR (64) NULL,
    [MD_DATE_MODIFIED]    DATETIME     NULL,
    [MD_JOB_CODE]         INT          NULL,
    [MD_RUN_CODE]         BIGINT       NULL,
    [MD_ETL_RUN]          INT          NULL,
    [MD_LOGICAL_DELETE]   BIT          NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_STATE] ASC)
);

