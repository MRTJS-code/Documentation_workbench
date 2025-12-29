CREATE TABLE [ods].[DEP_LocationRegister] (
    [id]               INT            IDENTITY (1, 1) NOT NULL,
    [locationId]       INT            NOT NULL,
    [parentLocationSK] INT            NOT NULL,
    [locationCode]     NVARCHAR (50)  NOT NULL,
    [locationName]     NVARCHAR (100) NOT NULL,
    [isWorkplace]      BIT            NOT NULL,
    [isPayCentre]      BIT            NOT NULL,
    [isActive]         BIT            NOT NULL,
    [isDeleted]        BIT            NOT NULL,
    [exportCode]       NVARCHAR (50)  NULL,
    [modifiedDate]     DATETIME       NOT NULL,
    [modifiedBy]       NVARCHAR (100) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    UNIQUE NONCLUSTERED ([locationId] ASC)
);

