CREATE TABLE [dw].[DIM_TRAININGAREA] (
    [SK_DIM_TRAININGAREA] BIGINT        NOT NULL,
    [FK_Area]             BIGINT        NULL,
    [FK_Training]         BIGINT        NULL,
    [MD_CreateDate]       DATETIME      NULL,
    [MD_ModifiedDate]     DATETIME      NULL,
    [MD_ETLJobCode]       INT           NULL,
    [MD_ETLRunCode]       BIGINT        NULL,
    [MD_ETLRun]           BIGINT        NULL,
    [MD_ModifiedUser]     VARCHAR (100) NULL,
    [MD_LogicalDelete]    BIT           NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_TRAININGAREA] ASC)
);

