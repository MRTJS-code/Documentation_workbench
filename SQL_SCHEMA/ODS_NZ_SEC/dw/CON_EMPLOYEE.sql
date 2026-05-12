CREATE TABLE [dw].[CON_EMPLOYEE] (
    [SK_CON_EMPLOYEE]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [P_First_Name]      VARCHAR (100) NULL,
    [P_Middle_Name]     VARCHAR (100) NULL,
    [P_Surname]         VARCHAR (100) NOT NULL,
    [P_Birth_Date]      DATE          NULL,
    [P_Employee_Type]   VARCHAR (50)  NOT NULL,
    [MD_DATE_MODIFIED]  DATE          NULL,
    [MD_LOGICAL_DELETE] BIT           NULL,
    [MD_JOB_CODE]       INT           NULL,
    [MD_RUN_CODE]       BIGINT        NULL,
    [MD_ETL_RUN]        INT           NULL,
    PRIMARY KEY CLUSTERED ([SK_CON_EMPLOYEE] ASC)
);

