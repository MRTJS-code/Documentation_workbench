CREATE TABLE [lookup].[DEP_ClientTier] (
    [PK_ClientTierId]  INT           IDENTITY (1, 1) NOT NULL,
    [FK_ProductCode]   VARCHAR (50)  NULL,
    [FK_SecurityGuard] INT           NOT NULL,
    [FK_SiteCard]      INT           NOT NULL,
    [FK_TierCard]      INT           NOT NULL,
    [FK_QualityCheck]  INT           NULL,
    [TierPayRate]      FLOAT (53)    NULL,
    [ChangeApprover]   VARCHAR (100) NULL,
    [ChangeRef]        VARCHAR (100) NULL,
    [IsCurrent]        BIT           NULL,
    [EffectiveFrom]    DATETIME      NULL,
    [EffectiveTo]      DATETIME      NULL,
    [MD_CreateDate]    DATETIME      NULL,
    [MD_ModifiedDate]  DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([PK_ClientTierId] ASC)
);

