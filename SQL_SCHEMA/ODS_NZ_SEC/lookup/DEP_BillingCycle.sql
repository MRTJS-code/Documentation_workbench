CREATE TABLE [lookup].[DEP_BillingCycle] (
    [SK_BillingCycleID] INT           NOT NULL,
    [FK_DebtorCode]     INT           NULL,
    [BillingFrequency]  NVARCHAR (50) NULL,
    [BillingMethod]     NVARCHAR (50) NULL,
    [LastRefreshed]     DATETIME      NULL,
    [SourceSystem]      VARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([SK_BillingCycleID] ASC)
);


GO


