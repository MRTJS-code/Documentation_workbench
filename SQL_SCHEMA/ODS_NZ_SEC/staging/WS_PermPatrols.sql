CREATE TABLE [staging].[WS_PermPatrols] (
    [PermanentPatrolId]     INT           NULL,
    [ClientId]              INT           NULL,
    [DespatchZoneId]        INT           NULL,
    [PatrolType]            VARCHAR (9)   NULL,
    [PatrolStatus]          VARCHAR (8)   NULL,
    [PatrolServiceType]     VARCHAR (32)  NULL,
    [PatrolChargeType]      VARCHAR (11)  NULL,
    [PatrolPriceType]       VARCHAR (14)  NULL,
    [patrolName]            VARCHAR (128) NULL,
    [Comments]              VARCHAR (MAX) NULL,
    [PONumber]              VARCHAR (128) NULL,
    [PermWeeklyPatrolCount] INT           NULL,
    [LastDespatchDate]      DATETIME      NULL,
    [NeverCharge]           BIT           NULL
);

