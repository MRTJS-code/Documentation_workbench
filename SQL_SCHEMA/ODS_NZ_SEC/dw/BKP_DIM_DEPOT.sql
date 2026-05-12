CREATE TABLE [dw].[BKP_DIM_DEPOT] (
    [SK_DIM_DEPOT]        INT           IDENTITY (1, 1) NOT NULL,
    [PK_DW_Source_System] VARCHAR (50)  NOT NULL,
    [PK_WS_DepotId]       INT           NULL,
    [PK_IT_DepotId]       VARCHAR (50)  NULL,
    [FK_DIM_BRANCH]       INT           NULL,
    [P_Depot_Status]      BIT           NULL,
    [P_Depot_Name]        VARCHAR (128) NULL,
    [P_Depot_Lat]         REAL          NULL,
    [P_Depot_Long]        REAL          NULL,
    [MD_DATE_MODIFIED]    DATETIME      NULL,
    [MD_JOB_CODE]         INT           NULL,
    [MD_RUN_CODE]         BIGINT        NULL,
    [MD_ETL_RUN]          INT           NULL,
    [MD_LOGICAL_DELETE]   BIT           NULL
);

