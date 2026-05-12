CREATE TABLE [dw].[DIM_DESPATCH_ZONE] (
    [SK_DIM_DESPATCH_ZONE] INT           IDENTITY (1, 1) NOT NULL,
    [PK_DW_SOURCE_SYSTEM]  VARCHAR (50)  NOT NULL,
    [PK_Despatch_Zone_Id]  VARCHAR (30)  NULL,
    [FK_DIM_DEPOT]         INT           NULL,
    [FK_DIM_STATE]         INT           NULL,
    [P_Zone_Id_Code]       VARCHAR (30)  NULL,
    [P_Zone_Status]        BIT           NULL,
    [P_Zone_Name]          VARCHAR (128) NULL,
    [P_Shift_Start]        DATETIME      NULL,
    [P_Shift_End]          DATETIME      NULL,
    [MD_DATE_MODIFIED]     DATETIME      NULL,
    [MD_JOB_CODE]          INT           NULL,
    [MD_RUN_CODE]          BIGINT        NULL,
    [MD_ETL_RUN]           INT           NULL,
    [MD_LOGICAL_DELETE]    BIT           NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_DESPATCH_ZONE] ASC),
    CONSTRAINT [FK_DIM_DESPATCH_ZONE_DIM_DEPOT] FOREIGN KEY ([FK_DIM_DEPOT]) REFERENCES [dw].[DIM_DEPOT] ([SK_DIM_DEPOT])
);

