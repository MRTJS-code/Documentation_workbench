CREATE TABLE [staging].[WS_DespatchDepot] (
    [DespatchZoneDepotId] INT           NULL,
    [Status]              BIT           NULL,
    [Code]                VARCHAR (128) NULL,
    [DepotLat]            VARCHAR (64)  NULL,
    [DepotLong]           VARCHAR (64)  NULL,
    [Copy of DepotLat]    REAL          NULL,
    [Copy of DepotLong]   REAL          NULL,
    [FKDimBranch]         INT           NULL,
    [FKDimRegion]         INT           NULL
);

