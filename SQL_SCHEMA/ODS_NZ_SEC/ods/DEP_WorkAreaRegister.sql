CREATE TABLE [ods].[DEP_WorkAreaRegister] (
    [id]           INT            IDENTITY (1, 1) NOT NULL,
    [workAreaId]   INT            NOT NULL,
    [locationSK]   INT            NOT NULL,
    [opUnitName]   NVARCHAR (100) NULL,
    [isActive]     BIT            NOT NULL,
    [exportCode]   NVARCHAR (50)  NULL,
    [modifiedDate] DATETIME       NOT NULL,
    [modifiedBy]   NVARCHAR (100) NOT NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

