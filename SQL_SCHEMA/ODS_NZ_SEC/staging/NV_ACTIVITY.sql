CREATE TABLE [staging].[NV_ACTIVITY] (
    [ActivityDateTime]     DATETIME        NULL,
    [Latitude]             FLOAT (53)      NULL,
    [Longitude]            FLOAT (53)      NULL,
    [GPSValid]             BIT             NULL,
    [OnSiteTime]           FLOAT (53)      NULL,
    [Location]             VARCHAR (255)   NULL,
    [IgnitionOn]           BIT             NULL,
    [Speed]                REAL            NULL,
    [EventSubType]         VARCHAR (200)   NULL,
    [IncrementalDistance]  DECIMAL (28, 5) NULL,
    [ODOMeter]             DECIMAL (28, 5) NULL,
    [TripDistance]         DECIMAL (28, 5) NULL,
    [ReceivedDateTime]     DATETIME        NULL,
    [CustomType]           INT             NULL,
    [MaxSpeed]             REAL            NULL,
    [IsUnauthorised]       BIT             NULL,
    [HDOP]                 DECIMAL (28, 5) NULL,
    [NumSatellites]        INT             NULL,
    [CustomID]             VARCHAR (100)   NULL,
    [SiteID]               VARCHAR (100)   NULL,
    [DriverID]             VARCHAR (100)   NULL,
    [DriverHourStatusID]   VARCHAR (100)   NULL,
    [ActivityLogID]        VARCHAR (100)   NULL,
    [VehicleID]            VARCHAR (100)   NULL,
    [OwnerID]              VARCHAR (100)   NULL,
    [CustomDescription]    VARCHAR (255)   NULL,
    [CustomData]           VARCHAR (255)   NULL,
    [OffRoadMeters]        FLOAT (53)      NULL,
    [DegreesBearing]       INT             NULL,
    [LocationType]         INT             NULL,
    [RegionCode]           VARCHAR (50)    NULL,
    [AreaCode]             VARCHAR (50)    NULL,
    [EventPriority]        VARCHAR (50)    NULL,
    [Version]              DECIMAL (28, 5) NULL,
    [Private]              BIT             NULL,
    [CommunicationChannel] VARCHAR (50)    NULL,
    [EventTypeDescription] VARCHAR (255)   NULL,
    [OutOfOrder]           BIT             NULL,
    [VehicleName]          VARCHAR (255)   NULL,
    [IsTollway]            BIT             NULL
)
GO

--Remove index once data warehouse builds are complete and staging data is no longer used directly by Power BI
CREATE CLUSTERED INDEX [ClusteredIndex-ActivityDateTime] ON [staging].[NV_ACTIVITY]
(
	[ActivityDateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO