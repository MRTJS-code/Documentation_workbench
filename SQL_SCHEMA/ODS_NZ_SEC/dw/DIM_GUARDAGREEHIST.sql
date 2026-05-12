CREATE TABLE [dw].[DIM_GUARDAGREEHIST] (
    [PK_DeputyId]           BIGINT        NOT NULL,
    [FK_DIM_GUARDAGREEMENT] BIGINT        NOT NULL,
    [FK_DIM_EMPLOYEE]       BIGINT        NULL,
    [FK_DIM_CONTRACTOR]     BIGINT        NULL,
    [AgreePayrollId]        VARCHAR (100) NULL,
    [AgreeActive]           BIT           NULL,
    [AgreeDateFrom]         DATETIME      NULL,
    [AgreeDateTo]           DATETIME      NULL,
    [MD_CreateDate]         DATETIME      NULL,
    [MD_ModifiedDate]       DATETIME      NULL,
    [MD_ETLJobCode]         INT           NULL,
    [MD_ETLRunCode]         BIGINT        NULL,
    [MD_ModifiedUser]       VARCHAR (100) NULL,
    PRIMARY KEY CLUSTERED ([PK_DeputyId] ASC)
);

