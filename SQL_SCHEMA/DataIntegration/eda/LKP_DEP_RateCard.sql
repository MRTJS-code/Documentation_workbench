CREATE TABLE [eda].[LKP_DEP_RateCard] (
    [SKRateCard]      INT           IDENTITY (1, 1) NOT NULL,
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
    PRIMARY KEY CLUSTERED ([SKRateCard] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_LKP_DEP_RateCard]
    ON [eda].[LKP_DEP_RateCard]([RateCode] ASC, [EffectiveFrom] ASC) WITH (IGNORE_DUP_KEY = ON);

