CREATE TABLE [dw].[DIM_SUBURB] (
    [SK_DIM_SUBURB]        BIGINT        IDENTITY (1, 1) NOT NULL,
    [PK_DW_Source_System]  VARCHAR (50)  NOT NULL,
    [PK_Suburb_Id]         INT           NULL,
    [FK_DIM_DESPATCH_ZONE] INT           NULL,
    [FK_DIM_STATE]         INT           NULL,
    [P_Suburb_Name]        VARCHAR (128) NULL,
    [P_Postcode]           SMALLINT      NULL,
    [MD_DATE_MODIFIED]     DATETIME      NULL,
    [MD_JOB_CODE]          INT           NULL,
    [MD_RUN_CODE]          BIGINT        NULL,
    [MD_ETL_RUN]           INT           NULL,
    [MD_LOGICAL_DELETE]    BIT           NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_SUBURB] ASC),
    CONSTRAINT [FK_DIM_SUBURB_DIM_STATE] FOREIGN KEY ([FK_DIM_STATE]) REFERENCES [dw].[DIM_STATE] ([SK_DIM_STATE])
);

