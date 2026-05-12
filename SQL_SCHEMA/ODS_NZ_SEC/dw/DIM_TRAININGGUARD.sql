CREATE TABLE [dw].[DIM_TRAININGGUARD] (
    [PK_DeputyId]          BIGINT        NOT NULL,
    [FK_DIM_SECURITYGUARD] BIGINT        NULL,
    [FK_Training]          BIGINT        NULL,
    [TrainingGuardId]      BIGINT        NULL,
    [TrainingId]           BIGINT        NULL,
    [TrainFrom]            DATETIME      NULL,
    [TrainTo]              DATETIME      NULL,
    [TrainActive]          BIT           NULL,
    [TrainComment]         VARCHAR (100) NULL,
    [MD_CreateDate]        DATETIME      NULL,
    [MD_ModifiedDate]      DATETIME      NULL,
    [MD_ETLJobCode]        INT           NULL,
    [MD_ETLRunCode]        BIGINT        NULL,
    [MD_ETLRun]            BIGINT        NULL,
    [MD_ModifiedUser]      VARCHAR (100) NULL,
    [MD_LogicalDelete]     BIT           NULL,
    PRIMARY KEY CLUSTERED ([PK_DeputyId] ASC)
);

