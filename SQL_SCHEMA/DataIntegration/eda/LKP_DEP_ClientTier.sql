CREATE TABLE [eda].[LKP_DEP_ClientTier] (
    [SKClientTier]     INT           IDENTITY (1, 1) NOT NULL,
    [PK_ClientTierId]  INT           NOT NULL,
    [FK_ProductCode]   VARCHAR (50)  NULL,
    [FK_SecurityGuard] INT           NOT NULL,
    [FK_SiteCard]      INT           NOT NULL,
    [FK_TierCard]      INT           NOT NULL,
    [FK_QualityCheck]  INT           NULL,
    [TierPayRate]      FLOAT (53)    NULL,
    [ChangeApprover]   VARCHAR (100) NULL,
    [ChangeRef]        VARCHAR (100) NULL,
    [IsCurrent]        BIT           NULL,
    [EffectiveFrom]    DATETIME      NOT NULL,
    [EffectiveTo]      DATETIME      NULL,
    [MD_CreateDate]    DATETIME      NULL,
    [MD_ModifiedDate]  DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([SKClientTier] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_LKP_DEP_ClientTier]
    ON [eda].[LKP_DEP_ClientTier]([PK_ClientTierId] ASC, [EffectiveFrom] ASC);

