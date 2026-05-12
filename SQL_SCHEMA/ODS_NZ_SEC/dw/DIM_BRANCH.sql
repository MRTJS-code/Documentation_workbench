CREATE TABLE [dw].[DIM_BRANCH] (
    [SK_DIM_BRANCH]           INT           IDENTITY (1, 1) NOT NULL,
    [P_Branch_id]             INT           NOT NULL,
    [P_Branch]                VARCHAR (2)   NOT NULL,
    [P_Business Code]         VARCHAR (2)   NULL,
    [P_Branch Name]           VARCHAR (50)  NOT NULL,
    [P_Branch Reporting Name] VARCHAR (30)  NOT NULL,
    [P_Branch Sub Group]      VARCHAR (30)  NOT NULL,
    [P_Branch Group]          VARCHAR (30)  NOT NULL,
    [P_First]                 BIT           NOT NULL,
    [P_AX_RegionCode]         VARCHAR (3)   NOT NULL,
    [P_AX_RegionName]         VARCHAR (20)  NOT NULL,
    [P_address_id]            DECIMAL (18)  NULL,
    [MD_DATE_CREATED]         DATE          NULL,
    [MD_DATE_MODIFIED]        DATE          NULL,
    [MD_JOB_CODE]             INT           NULL,
    [MD_RUN_CODE]             BIGINT        NULL,
    [MD_PACK_NAME]            VARCHAR (70)  NULL,
    [MD_MODIFIED_USER]        VARCHAR (100) NULL,
    [MD_LOGICAL_DELETE]       SMALLINT      NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_BRANCH] ASC)
);

