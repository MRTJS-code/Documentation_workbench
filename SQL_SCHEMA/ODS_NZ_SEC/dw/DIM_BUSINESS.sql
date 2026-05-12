CREATE TABLE [dw].[DIM_BUSINESS] (
    [SK_DIM_BUSINESS]             INT           IDENTITY (1, 1) NOT NULL,
    [P_Branch]                    VARCHAR (2)   NULL,
    [P_Business Code]             VARCHAR (2)   NOT NULL,
    [P_Business Type Description] VARCHAR (40)  NOT NULL,
    [P_Business Type Summary]     VARCHAR (20)  NOT NULL,
    [P_Include First]             BIT           NOT NULL,
    [P_Type Sale]                 VARCHAR (10)  NOT NULL,
    [P_GOS]                       BIT           NOT NULL,
    [P_Revenue]                   BIT           NOT NULL,
    [P_Static Guards]             BIT           NOT NULL,
    [P_BI Business Type Summary]  VARCHAR (40)  NULL,
    [P_BI Patrols Type]           VARCHAR (40)  NULL,
    [MD_DATE_CREATED]             DATE          NULL,
    [MD_DATE_MODIFIED]            DATE          NULL,
    [MD_JOB_CODE]                 INT           NULL,
    [MD_RUN_CODE]                 BIGINT        NULL,
    [MD_PACK_NAME]                VARCHAR (70)  NULL,
    [MD_MODIFIED_USER]            VARCHAR (100) NULL,
    [MD_LOGICAL_DELETE]           SMALLINT      NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_BUSINESS] ASC)
);

