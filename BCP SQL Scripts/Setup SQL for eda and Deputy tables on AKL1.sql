/****** Object:  Table [eda].[ETL_EVENT]    Script Date: 19/08/2025 00:26:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [eda].[ETL_EVENT](
	[EVENT_ID] [int] IDENTITY(1,1) NOT NULL,
	[ETL_REF] [int] NOT NULL,
	[ETL_RUN_CODE] [int] NULL,
	[EVENT_STATUS] [varchar](50) NOT NULL,
	[EVENT_DATE_CREATE] [datetime] NOT NULL,
	[EVENT_SOURCE] [varchar](100) NOT NULL,
	[EVENT_INPUT] [varchar](255) NOT NULL,
	[EVENT_OUTPUT] [varchar](255) NOT NULL,
	[EVENT_USER_EMAIL] [varchar](1000) NOT NULL,
	[EVENT_KICKOFF_DATE] [datetime] NULL,
	[EVENT_DATE_START] [datetime] NULL,
	[EVENT_DATE_END] [datetime] NULL,
	[EVENT_COMMENT] [varchar](4000) NULL,
	[DATE_LAST_MODIFIED] [datetime] NOT NULL,
	[EVENT_EXECUTION_ID] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[EVENT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [eda].[ETL_EVENT_VARIABLES](
	[EVENT_ID] [int] NOT NULL,
	[VARIABLE_CODE] [varchar](50) NOT NULL,
	[DATA_TYPE] [varchar](50) NOT NULL,
	[VARIABLE_DESC] [varchar](255) NOT NULL,
	[VARIABLE_VALUE] [varchar](255) NOT NULL,
	[DATE_LAST_MODIFIED] [datetime] NOT NULL,
 CONSTRAINT [PK_CTL_JOB_CONFIG_VARIABLES] PRIMARY KEY CLUSTERED 
(
	[EVENT_ID] ASC,
	[VARIABLE_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [eda].[EXT_DEP_FULL](
	[Id] [int] NULL,
	[AgreementId] [int] NULL,
	[EmployeeId] [int] NULL,
	[payrollId] [varchar](100) NULL,
	[LeaveRuleId] [int] NULL,
	[LeaveLineId] [int] NULL,
	[PayCycleId] [int] NULL,
	[AreaId] [int] NULL,
	[displayName] [varchar](100) NULL,
	[firstName] [varchar](50) NULL,
	[lastName] [varchar](50) NULL,
	[payCentre] [varchar](255) NULL,
	[payPeriod] [varchar](50) NULL,
	[exportCode] [varchar](100) NULL,
	[JobCode] [varchar](100) NULL,
	[activityCode] [varchar](50) NULL,
	[areaName] [varchar](255) NULL,
	[locationName] [varchar](255) NULL,
	[branchName] [varchar](255) NULL,
	[timesheetStart] [datetime] NULL,
	[timesheetEnd] [datetime] NULL,
	[timesheetHours] [float] NULL,
	[timesheetCost] [float] NULL,
	[sourceType] [varchar](10) NULL,
	[sourceStart] [datetime] NULL,
	[sourceEnd] [datetime] NULL,
	[sourceHours] [float] NULL,
	[sourceCost] [float] NULL,
	[InProgress] [bit] NULL,
	[RealTime] [bit] NULL,
	[AutoProcessed] [bit] NULL,
	[PayApproved] [bit] NULL,
	[TimeApproved] [bit] NULL,
	[AutoPayApproved] [bit] NULL,
	[AutoTimeApproved] [bit] NULL,
	[Exported] [bit] NULL,
	[Invoiced] [bit] NULL,
	[emsminutes] [float] NULL,
	[ncrminutes] [float] NULL,
	[ponumber] [varchar](255) NULL,
	[ritm] [varchar](255) NULL,
	[sourcePO] [varchar](255) NULL,
	[sorceRITM] [varchar](255) NULL,
	[lineCost] [float] NULL,
	[lineHours] [float] NULL,
	[Overridden] [bit] NULL,
	[OverrideComment] [varchar](100) NULL,
	[PayTitle] [varchar](100) NULL,
	[PayActivityCode] [varchar](50) NULL,
	[BaseRate] [float] NULL,
	[SiteRate] [float] NULL,
	[ClientTierRate] [float] NULL,
	[phHours] [float] NULL,
	[altCredit] [bit] NULL,
	[phRef] [int] NULL,
	[MDEventId] [bigint] NULL
) ON [PRIMARY]
GO


CREATE TABLE [eda].[IMP_DEPEMPAGMIGRATE](
	[eventId] [int] NOT NULL,
	[employeeId] [int] NOT NULL,
	[currAgreeId] [int] NULL,
	[newAgreeId] [int] NULL,
	[newAgreeBody] [varchar](500) NULL,
	[errorMsg] [varchar](2000) NULL
) ON [PRIMARY]
GO


CREATE TABLE [eda].[IMP_DEPEMPEECUSTOM](
	[eventId] [int] NOT NULL,
	[employeeId] [int] NOT NULL,
	[customId] [int] NULL,
	[depBody] [varchar](255) NOT NULL,
	[processOutcome] [varchar](1000) NULL
) ON [PRIMARY]
GO

CREATE TABLE [eda].[IMP_DEPLEAVE](
	[EVENT_ID] [int] NOT NULL,
	[ROSTER_ID] [int] NULL,
	[LEAVE_ID] [int] NULL,
	[LEAVEDATE] [date] NULL,
	[JOBCODE] [varchar](50) NULL,
	[IMPJSON] [varchar](255) NULL,
	[COSTPERHR] [float] NULL
) ON [PRIMARY]
GO


CREATE TABLE [eda].[IMP_DEPRESOURCE](
	[eventId] [int] NOT NULL,
	[apiType] [varchar](50) NOT NULL,
	[resource] [varchar](50) NOT NULL,
	[recordId] [int] NULL,
	[isBulk] [bit] NOT NULL,
	[isInsert] [bit] NOT NULL,
	[reqBody] [varchar](2000) NOT NULL,
	[responseMsg] [varchar](2000) NULL
) ON [PRIMARY]
GO



CREATE TABLE [eda].[IMP_DEPTIMESHEETFIX](
	[eventId] [int] NOT NULL,
	[employeeId] [int] NOT NULL,
	[locationId] [int] NULL,
	[agreementId] [int] NOT NULL,
	[timesheets] [varchar](1000) NOT NULL,
	[respMessage] [varchar](500) NULL,
	[isAdditional] [bit] NULL
) ON [PRIMARY]
GO



