CREATE TABLE [dw].[DIM_AGREEMENTPAYRULE] (
    [SK_DIM_AGREEMENTPAYRULE] BIGINT        IDENTITY (1, 1) NOT NULL,
    [FK_GuardAgreement]       BIGINT        NOT NULL,
    [FK_PayRule]              BIGINT        NOT NULL,
    [MD_CreateDate]           DATETIME      NULL,
    [MD_ModifiedDate]         DATETIME      NULL,
    [MD_ETLJobCode]           INT           NULL,
    [MD_ETLRunCode]           BIGINT        NULL,
    [MD_ETLRun]               BIGINT        NULL,
    [MD_ModifiedUser]         VARCHAR (100) NULL,
    [MD_LogicalDelete]        BIT           NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_AGREEMENTPAYRULE] ASC)
);

