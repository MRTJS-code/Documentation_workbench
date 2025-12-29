CREATE TABLE [ods].[DIM_ITS_ATTRIBUTE] (
    [itsAttId]           BIGINT         IDENTITY (1, 1) NOT NULL,
    [employeeId]         NVARCHAR (255) NULL,
    [attributeName]      NVARCHAR (255) NULL,
    [attributeReference] NVARCHAR (255) NULL,
    [attributeValue]     NVARCHAR (255) NULL,
    [locationName]       NVARCHAR (255) NULL,
    [locationReference]  NVARCHAR (255) NULL,
    [activityName]       NVARCHAR (255) NULL,
    [activityReference]  NVARCHAR (255) NULL,
    [validFrom]          DATETIME       NULL,
    [validTo]            DATETIME       NULL,
    [note]               NVARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([itsAttId] ASC),
    CONSTRAINT [FK_DIM_ITS_ATTRIBUTE_DIM_INTIMESTAFF] FOREIGN KEY ([employeeId]) REFERENCES [ods].[DIM_INTIMESTAFF] ([employeeId])
);

