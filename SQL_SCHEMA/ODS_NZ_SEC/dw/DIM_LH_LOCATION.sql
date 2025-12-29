CREATE TABLE [dw].[DIM_LH_LOCATION] (
    [SK_DIM_LH_LOCATION] BIGINT        IDENTITY (1, 1) NOT NULL,
    [P_Application_id]   VARCHAR (255) NULL,
    [P_Location_id]      VARCHAR (255) NULL,
    [P_Location_name]    VARCHAR (255) NULL,
    [P_Location_street]  VARCHAR (255) NULL,
    [P_Location_city]    VARCHAR (255) NULL,
    [P_Location_state]   VARCHAR (255) NULL,
    [P_Location_country] VARCHAR (255) NULL,
    [MD_DATE_CREATED]    DATE          NULL,
    [MD_DATE_MODIFIED]   DATE          NULL,
    [MD_JOB_CODE]        INT           NULL,
    [MD_RUN_CODE]        BIGINT        NULL,
    [MD_PACK_NAME]       VARCHAR (70)  NULL,
    [MD_MODIFIED_USER]   VARCHAR (100) NULL,
    [MD_LOGICAL_DELETE]  SMALLINT      NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_LH_LOCATION] ASC)
);

