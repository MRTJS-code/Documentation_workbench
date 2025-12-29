CREATE TABLE [lookup].[D365_CostCentres](
	[CostCentreCode] [bigint] NOT NULL,
	[CostCentreName] [varchar](200) NULL,
	[ETLModified] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CostCentreCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


