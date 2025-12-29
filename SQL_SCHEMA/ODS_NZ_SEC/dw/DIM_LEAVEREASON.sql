CREATE TABLE [dw].[DIM_LEAVEREASON] (
    [SK_DIM_LeaveReason]  INT           IDENTITY (1, 1) NOT NULL,
    [PK_PR_Code]          VARCHAR (10)  NULL,
    [PK_DW_Source_System] VARCHAR (50)  NOT NULL,
    [P_LeaveReason_Desc]  VARCHAR (100) NULL,
    [MD_DATE_MODIFIED]    DATETIME      NULL,
    [MD_JOB_CODE]         INT           NULL,
    [MD_RUN_CODE]         BIGINT        NULL,
    [MD_ETL_RUN]          INT           NULL,
    [MD_LOGICAL_DELETE]   BIT           NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_LeaveReason] ASC)
);

