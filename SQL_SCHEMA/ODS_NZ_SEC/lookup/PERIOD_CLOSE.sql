CREATE TABLE [lookup].[PERIOD_CLOSE] (
    [PeriodID]     INT           NOT NULL,
    [PeriodStart]  DATE          NOT NULL,
    [PeriodEnd]    DATE          NOT NULL,
    [PeriodType]   VARCHAR (200) DEFAULT ('Weekly') NULL,
    [IsClosed]     BIT           DEFAULT ((0)) NULL,
    [ClosedBy]     VARCHAR (100) NULL,
    [ClosedDate]   DATETIME      NULL,
    [CreatedDate]  DATETIME      DEFAULT (getdate()) NOT NULL,
    [ModifiedDate] DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([PeriodID] ASC)
);

