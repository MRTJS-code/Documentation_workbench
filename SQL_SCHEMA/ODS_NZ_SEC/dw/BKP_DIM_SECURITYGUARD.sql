CREATE TABLE [dw].[BKP_DIM_SECURITYGUARD] (
    [SK_DIM_SECURITYGUARD]          BIGINT         IDENTITY (1, 1) NOT NULL,
    [PK_IT_EmployeeId]              NVARCHAR (255) NULL,
    [PK_WS_EmployeeId]              VARCHAR (50)   NULL,
    [PK_DW_Source_System]           NVARCHAR (50)  NOT NULL,
    [FK_DIM_Security_Guard_Licence] BIGINT         NULL,
    [P_Guard_Code]                  VARCHAR (50)   NULL,
    [P_FirstName]                   NVARCHAR (255) NULL,
    [P_MiddleName]                  NVARCHAR (255) NULL,
    [P_lastName]                    NVARCHAR (255) NULL,
    [P_HireDate]                    DATE           NULL,
    [P_TerminationDate]             DATE           NULL,
    [P_DOB]                         DATE           NULL,
    [P_GuardType]                   VARCHAR (50)   NULL,
    [P_SubcontractorGroup]          VARCHAR (30)   NULL,
    [MD_DATE_CREATED]               DATE           NULL,
    [MD_DATE_MODIFIED]              DATE           NULL,
    [MD_JOB_CODE]                   INT            NULL,
    [MD_RUN_CODE]                   BIGINT         NULL,
    [MD_PACK_NAME]                  VARCHAR (70)   NULL,
    [MD_MODIFIED_USER]              VARCHAR (100)  NULL,
    [MD_LOGICAL_DELETE]             SMALLINT       NULL
);

