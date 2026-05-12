CREATE TABLE [eda].[LKP_DEP_WorkArea] (
    [SKWorkArea]      INT           IDENTITY (1, 1) NOT NULL,
    [PK_WorkAreaID]   INT           NOT NULL,
    [WorkAreaName]    VARCHAR (100) NULL,
    [FK_LocationCode] INT           NULL,
    [FK_CostCentre]   INT           NULL,
    [FK_ProductCode]  VARCHAR (20)  NULL,
    [FK_QualityCheck] INT           NULL,
    [FK_RateCard]     INT           NULL,
    [ChangeApprover]  VARCHAR (100) NULL,
    [ChangeRef]       VARCHAR (50)  NULL,
    [EffectiveFrom]   DATETIME      NOT NULL,
    [EffectiveTo]     DATETIME      NULL,
    [MD_CreateDate]   DATETIME      NULL,
    [MD_ModifiedDate] DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([SKWorkArea] ASC)
);

