CREATE TABLE [eda].[LKP_SiteRate] (
    [PK_WorkAreaID]  INT             NULL,
    [FK_CostCentre]  INT             NULL,
    [FK_ProductCode] VARCHAR (20)    NULL,
    [PayRate]        NUMERIC (18, 2) NULL,
    [PrecedaPayCode] VARCHAR (2)     NULL,
    [EffectiveFrom]  DATETIME        NULL,
    [EffectiveTo]    DATETIME        NULL
);

