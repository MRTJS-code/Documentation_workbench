CREATE TABLE [dw].[DIM_MONITOR_CENTRE] (
    [SK_DIM_MONITOR_CENTRE] INT           IDENTITY (1, 1) NOT NULL,
    [PK_DW_Source_System]   VARCHAR (50)  NOT NULL,
    [PK_Monitor_Centre_Id]  INT           NULL,
    [FK_DIM_SUBURB]         BIGINT        NULL,
    [P_Monitor_Prefix]      VARCHAR (16)  NULL,
    [P_Monitor_Name]        VARCHAR (128) NULL,
    [P_Address1]            VARCHAR (128) NULL,
    [P_Address2]            VARCHAR (128) NULL,
    [P_Contact_Name]        VARCHAR (128) NULL,
    [P_Contact_Email]       VARCHAR (MAX) NULL,
    [P_Contact_Phone_No]    VARCHAR (128) NULL,
    [P_Monitor_Status]      BIT           NULL,
    [MD_DATE_MODIFIED]      DATETIME      NULL,
    [MD_JOB_CODE]           INT           NULL,
    [MD_RUN_CODE]           BIGINT        NULL,
    [MD_ETL_RUN]            INT           NULL,
    [MD_LOGICAL_DELETE]     BIT           NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_MONITOR_CENTRE] ASC)
);

