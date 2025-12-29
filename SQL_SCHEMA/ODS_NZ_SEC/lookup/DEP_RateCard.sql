CREATE TABLE [lookup].[DEP_RateCard] (
    [RateCode]        INT           NOT NULL,
    [RateName]        VARCHAR (50)  NULL,
    [PayAmount]       FLOAT (53)    NULL,
    [FK_ProductCode]  VARCHAR (50)  NULL,
    [ChangeApprover]  VARCHAR (100) NULL,
    [ChangeRef]       VARCHAR (50)  NULL,
    [EffectiveFrom]   DATETIME      NOT NULL,
    [EffectiveTo]     DATETIME      NULL,
    [MD_CreateDate]   DATETIME      NULL,
    [MD_ModifiedDate] DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([RateCode] ASC, [EffectiveFrom] ASC)
);

