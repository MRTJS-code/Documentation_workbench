CREATE TABLE [staging].[FCT_DEP_ROSTER] (
    [Id]              INT            NULL,
    [AreaId]          INT            NULL,
    [EmployeeId]      INT            NULL,
    [TimesheetId]     INT            NULL,
    [RosterDate]      DATETIME       NULL,
    [RosterStart]     DATETIME       NULL,
    [RosterEnd]       DATETIME       NULL,
    [Hours]           FLOAT (53)     NULL,
    [Cost]            FLOAT (53)     NULL,
    [Comment]         VARCHAR (1000) NULL,
    [Warning]         VARCHAR (500)  NULL,
    [WarningOverride] VARCHAR (500)  NULL,
    [Open]            BIT            NULL,
    [Published]       BIT            NULL,
    [PurchaseOrder]   VARCHAR (255)  NULL,
    [RITM]            VARCHAR (255)  NULL,
    [Creator]         VARCHAR (50)   NULL,
    [ModifiedDate]    DATETIME       NULL
);

