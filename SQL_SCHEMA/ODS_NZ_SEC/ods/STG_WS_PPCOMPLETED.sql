CREATE TABLE [ods].[STG_WS_PPCOMPLETED] (
    [PermanentPatrolCompletedId]   INT             NOT NULL,
    [PermanentPatrolId]            INT             NULL,
    [PatrolCompleteStatus]         INT             NULL,
    [OnsiteVehicleStoppedDateTime] DATETIME        NULL,
    [OnsiteLat]                    VARCHAR (64)    NULL,
    [OnsiteLong]                   VARCHAR (64)    NULL,
    [OnsiteDistanceFromSite]       VARCHAR (64)    NULL,
    [MissedReason]                 VARCHAR (128)   NULL,
    [OriginalVisitChargeIncGST]    DECIMAL (10, 2) NULL,
    [AddressWhenOnsited]           VARCHAR (MAX)   NULL,
    [AllowedTimeOnSite]            INT             NULL,
    [VisitChargeExGST]             DECIMAL (10, 2) NULL,
    [ValidationStatus]             INT             NULL,
    [ValidationAudit]              VARCHAR (MAX)   NULL,
    [Comments]                     VARCHAR (MAX)   NULL,
    [OffSiteDateTime]              DATETIME        NULL,
    [ETLRunID]                     INT             NULL,
    PRIMARY KEY CLUSTERED ([PermanentPatrolCompletedId] ASC)
);

