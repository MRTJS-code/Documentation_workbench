CREATE TABLE [lookup].[DEP_WorkAreas] (
    [PK_WorkAreaID]   INT             NOT NULL,
    [WorkAreaName]    VARCHAR (100)   NULL,
    [FK_LocationCode] INT             NULL,
    [FK_CostCentre]   INT             NULL,
    [FK_ProductCode]  VARCHAR (20)    NULL,
    [FK_QualityCheck] INT             NULL,
    [FK_RateCard]     INT             NULL,
    [ChangeApprover]  VARCHAR (100)   NULL,
    [ChangeRef]       VARCHAR (50)    NULL,
    [PayRate]         DECIMAL (18, 2) NULL,
    [PrecedaPayCode]  VARCHAR (2)     NULL,
    [EffectiveFrom]   DATETIME        NOT NULL,
    [EffectiveTo]     DATETIME        NULL,
    [MD_CreateDate]   DATETIME        NULL,
    [MD_ModifiedDate] DATETIME        NULL,
    PRIMARY KEY CLUSTERED ([PK_WorkAreaID] ASC, [EffectiveFrom] ASC)
);

