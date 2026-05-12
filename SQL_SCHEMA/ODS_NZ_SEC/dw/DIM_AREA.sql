CREATE TABLE [dw].[DIM_AREA] (
    [PK_DeputyId]         BIGINT        NOT NULL,
    [FK_Location]         BIGINT        NOT NULL,
    [FK_Address]          BIGINT        NULL,
    [FK_Contact]          BIGINT        NULL,
    [AreaLocationId]      BIGINT        NULL,
    [AreaContactId]       BIGINT        NULL,
    [AreaAddressid]       BIGINT        NULL,
    [AreaName]            VARCHAR (100) NOT NULL,
    [AreaActive]          BIT           NULL,
    [AreaCostCentre]      VARCHAR (100) NULL,
    [AreaProduct]         VARCHAR (100) NULL,
    [AreaSiteRate]        FLOAT (53)    NULL,
    [AreaSuspended]       BIT           NULL,
    [MD_CreateDate]       DATETIME      NULL,
    [MD_ModifiedDate]     DATETIME      NULL,
    [MD_ETLJobCode]       INT           NULL,
    [MD_ETLRunCode]       BIGINT        NULL,
    [MD_ETLRun]           BIGINT        NULL,
    [MD_ModifiedUser]     VARCHAR (100) NULL,
    [FK_QA_QUALITYHEADER] BIGINT        NULL,
    PRIMARY KEY CLUSTERED ([PK_DeputyId] ASC)
);

