CREATE TABLE [eda].[LKP_ClientTierRate] (
    [FK_ProductCode]     VARCHAR (15)    NULL,
    [FK_SecurityGuardID] INT             NULL,
    [FK_WorkAreaID]      INT             NULL,
    [TierPayRate]        NUMERIC (18, 2) NULL,
    [PrecedaPayCode]     VARCHAR (2)     NULL,
    [EffectiveFrom]      DATETIME        NULL,
    [EffectiveTo]        DATETIME        NULL
);

