CREATE TABLE [staging].[WS_DespatchZone] (
    [DespatchZoneId]      VARCHAR (30)  NULL,
    [ZoneIdCode]          VARCHAR (30)  NULL,
    [Status]              BIT           NULL,
    [Name]                VARCHAR (128) NULL,
    [StateId]             INT           NULL,
    [ShiftStartTime]      DATETIME      NULL,
    [ShiftEndTime]        DATETIME      NULL,
    [DespatchZoneDepotId] INT           NULL
);

