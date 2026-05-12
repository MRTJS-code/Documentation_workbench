CREATE TABLE [ods].[FCT_WS_MISSEDPATROLS] (
    [id]                INT             IDENTITY (1, 1) NOT NULL,
    [custName]          VARCHAR (MAX)   NULL,
    [gtDebtor]          VARCHAR (64)    NULL,
    [zoneName]          NVARCHAR (255)  NULL,
    [missedCount]       INT             NULL,
    [missedValue]       NUMERIC (38, 2) NULL,
    [PermanentPatrolId] INT             NULL,
    [totalCount]        INT             NULL,
    [branchID]          INT             NULL,
    [patrolDate]        DATETIME        NULL,
    [ZoneIDcode]        VARCHAR (8)     NULL,
    [JobCode]           VARCHAR (13)    NULL,
    [jobOID]            VARCHAR (34)    NULL,
    [custOID]           VARCHAR (34)    NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_FCT_WS_MISSEDPATROLS_DIM_BRANCH] FOREIGN KEY ([branchID]) REFERENCES [ods].[DIM_BRANCH] ([id]),
    CONSTRAINT [FK_FCT_WS_MISSEDPATROLS_DIM_DATE] FOREIGN KEY ([patrolDate]) REFERENCES [ods].[DIM_DATE] ([PK_Date]),
    CONSTRAINT [FK_FCT_WS_MISSEDPATROLS_DIM_JOB] FOREIGN KEY ([jobOID]) REFERENCES [ods].[DIM_JOB] ([oid]),
    CONSTRAINT [FK_FCT_WS_MISSEDPATROLS_DIM_ORGANISATION] FOREIGN KEY ([custOID]) REFERENCES [ods].[DIM_ORGANISATION] ([oid])
);

