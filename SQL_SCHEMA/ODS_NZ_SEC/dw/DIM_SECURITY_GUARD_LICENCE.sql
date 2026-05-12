CREATE TABLE [dw].[DIM_SECURITY_GUARD_LICENCE] (
    [SK_DIM_Security_Guard_Licence]   BIGINT        IDENTITY (1, 1) NOT NULL,
    [PK_Security_Guard_Licence_ID]    VARCHAR (50)  NULL,
    [PK_DW_Source_System]             VARCHAR (50)  NOT NULL,
    [P_EmployeeId]                    VARCHAR (50)  NULL,
    [P_Full_Name]                     VARCHAR (50)  NULL,
    [PK_Expiry_Date]                  DATE          NULL,
    [P_Employee_Notified]             DATE          NULL,
    [P_Last_Checked]                  DATE          NULL,
    [P_Security_Guard_Licence_Status] VARCHAR (255) NULL,
    [MD_DATE_CREATED]                 DATE          NULL,
    [MD_DATE_MODIFIED]                DATE          NULL,
    [MD_LOGICAL_DELETE]               SMALLINT      NULL,
    [MD_JOB_CODE]                     INT           NULL,
    [MD_RUN_CODE]                     BIGINT        NULL,
    [MD_PACK_NAME]                    VARCHAR (70)  NULL,
    [MD_SOURCE_API]                   VARCHAR (255) NULL,
    CONSTRAINT [PK_DIM_SECURITY_GUARD_LICENCE] PRIMARY KEY CLUSTERED ([SK_DIM_Security_Guard_Licence] ASC)
);

