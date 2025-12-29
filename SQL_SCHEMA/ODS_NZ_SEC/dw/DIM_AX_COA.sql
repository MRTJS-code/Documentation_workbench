CREATE TABLE [dw].[DIM_AX_COA] (
    [SK_DIM_AX_COA]              INT           NOT NULL,
    [PK_Main_Account_RECID_DAX]  BIGINT        NOT NULL,
    [P_Main_Account_Code]        VARCHAR (25)  NULL,
    [P_Main_Account]             VARCHAR (60)  NULL,
    [P_WG_Account_Category]      VARCHAR (100) NULL,
    [P_WG_Account_Category_Code] VARCHAR (25)  NULL,
    [P_WG_Account_Type_Code]     INT           NULL,
    [P_WG_Account_Type]          VARCHAR (40)  NULL,
    [P_FS_GL_Report]             VARCHAR (20)  NULL,
    [P_FS_Account_Type]          VARCHAR (20)  NULL,
    [P_FS_Account_SubType]       VARCHAR (30)  NULL,
    [P_FS_NOS]                   BIT           NULL,
    [MD_DATE_MODIFIED]           DATE          NULL,
    [MD_MODIFIED_USER]           VARCHAR (50)  NULL,
    [MD_JOB_CODE]                INT           NULL,
    [MD_RUN_CODE]                BIGINT        NULL,
    [MD_ETL_RUN]                 INT           NULL,
    [MD_LOGICAL_DELETE]          BIT           NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_AX_COA] ASC)
);

