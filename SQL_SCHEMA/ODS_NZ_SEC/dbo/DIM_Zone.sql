CREATE TABLE [dbo].[DIM_Zone] (
    [Numeric DespatchZoneId] INT           NULL,
    [ZoneIdCode]             VARCHAR (30)  NULL,
    [Status]                 BIT           NULL,
    [Name]                   VARCHAR (128) NULL,
    [RegionId]               INT           NULL,
    [ShiftStartTime]         DATETIME      NULL,
    [ShiftEndTime]           DATETIME      NULL,
    [zoneBranch]             VARCHAR (128) NULL
);

