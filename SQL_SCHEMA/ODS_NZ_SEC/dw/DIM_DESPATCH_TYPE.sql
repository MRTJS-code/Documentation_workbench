CREATE TABLE [dw].[DIM_DESPATCH_TYPE] (
    [SK_DIM_DESPATCH_TYPE]     BIGINT       IDENTITY (1, 1) NOT NULL,
    [PK_DW_Source_System]      VARCHAR (50) NOT NULL,
    [FK_DIM_BUSINESS]          INT          NULL,
    [PK_Despatch_Type_ID]      INT          NULL,
    [P_Despatch_Type_Name]     VARCHAR (64) NULL,
    [P_Despatch_Type_Category] VARCHAR (50) NULL,
    [MD_DATE_MODIFIED]         DATETIME     NULL,
    [MD_JOB_CODE]              INT          NULL,
    [MD_RUN_CODE]              BIGINT       NULL,
    [MD_ETL_RUN]               INT          NULL,
    [MD_LOGICAL_DELETE]        BIT          NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_DESPATCH_TYPE] ASC),
    CONSTRAINT [FK_DIM_DESPATCH_TYPE_DIM_BUSINESS] FOREIGN KEY ([FK_DIM_BUSINESS]) REFERENCES [dw].[DIM_BUSINESS] ([SK_DIM_BUSINESS])
);

