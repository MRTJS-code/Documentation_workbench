CREATE TABLE [lookup].[DEP_Location](
	[PK_LocationCode] [int] NOT NULL,
	[FK_DebtorCode] [varchar](20) NULL,
	[LocationName] [nvarchar](100) NULL,
	[UserLastModified] [nvarchar](100) NULL,
	[MD_LastModified_Deputy] [datetime] NULL,
	[MD_LastRefreshed_ETL] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PK_LocationCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
