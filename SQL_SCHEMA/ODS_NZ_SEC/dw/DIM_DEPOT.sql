CREATE TABLE [dw].[DIM_DEPOT] (
    [SK_DIM_DEPOT]        INT           IDENTITY (1, 1) NOT NULL,
    [PK_SourceSystem]     VARCHAR (50)  NOT NULL,
    [PK_SourceId]         INT           NULL,
    [PK_SourceIdStr]      VARCHAR (50)  NULL,
    [FK_DIM_BRANCH]       INT           NULL,
    [FK_DIM_REGION]       INT           NULL,
    [FK_DIM_ADDRESS]      BIGINT        NULL,
    [FK_DIM_CONTACT]      BIGINT        NULL,
    [DepotRegion]         VARCHAR (100) NULL,
    [DepotCompany]        VARCHAR (100) NULL,
    [DepotActive]         BIT           NULL,
    [DepotName]           VARCHAR (128) NULL,
    [MD_CreateDate]       DATETIME      NULL,
    [MD_ModifiedDate]     DATETIME      NULL,
    [MD_ETLJobCode]       INT           NULL,
    [MD_ETLRunCode]       BIGINT        NULL,
    [MD_ETLRun]           BIGINT        NULL,
    [MD_ModifiedUser]     VARCHAR (100) NULL,
    [FK_QA_QUALITYHEADER] BIGINT        NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_DEPOT] ASC),
    CONSTRAINT [FK_DIM_DEPOT_DIM_BRANCH] FOREIGN KEY ([FK_DIM_BRANCH]) REFERENCES [dw].[DIM_BRANCH] ([SK_DIM_BRANCH])
);

