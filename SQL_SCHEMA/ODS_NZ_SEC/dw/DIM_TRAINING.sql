CREATE TABLE [dw].[DIM_TRAINING] (
    [SK_DIM_TRAINING]     BIGINT        IDENTITY (1, 1) NOT NULL,
    [PK_SourceSystem]     VARCHAR (100) NOT NULL,
    [PK_SourceId]         BIGINT        NULL,
    [TrainTitle]          VARCHAR (100) NULL,
    [TrainProvider]       VARCHAR (100) NULL,
    [MD_CreateDate]       DATETIME      NULL,
    [MD_ModifiedDate]     DATETIME      NULL,
    [MD_ETLJobCode]       INT           NULL,
    [MD_ETLRunCode]       BIGINT        NULL,
    [MD_ETLRun]           BIGINT        NULL,
    [MD_ModifiedUser]     VARCHAR (100) NULL,
    [FK_QA_QUALITYHEADER] BIGINT        NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_TRAINING] ASC)
);

