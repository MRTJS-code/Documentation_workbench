CREATE TABLE [dw].[DIM_GHS_TEAMS] (
    [SK_DIM_TEAMS]                BIGINT        IDENTITY (1, 1) NOT NULL,
    [PK_TEAMS_ID]                 BIGINT        NULL,
    [FK_SK_DIM_GHS_ORGANISATIONS] BIGINT        NULL,
    [P_NAME]                      VARCHAR (256) NULL,
    [P_DESCRIPTION]               VARCHAR (256) NULL,
    [P_CREATED_AT]                DATETIME      NULL,
    [P_UPDATED_AT]                DATETIME      NULL,
    [MD_DATE_CREATED]             DATETIME      NULL,
    [MD_DATE_MODIFIED]            DATETIME      NULL,
    [MD_JOB_CODE]                 INT           NULL,
    [MD_RUN_CODE]                 BIGINT        NULL,
    [MD_PACK_NAME]                VARCHAR (70)  NULL,
    [MD_MODIFIED_USER]            VARCHAR (100) NULL,
    [MD_LOGICAL_DELETE]           SMALLINT      NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_TEAMS] ASC)
);

