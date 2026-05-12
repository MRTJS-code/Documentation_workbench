CREATE TABLE [dw].[BKP_FACT_ROSTER] (
    [AssignmentID]            BIGINT           NOT NULL,
    [dim_AssignmentDate_key]  BIGINT           NULL,
    [dim_SecurityGuard_key]   BIGINT           NULL,
    [dim_IT_Activity_key]     BIGINT           NULL,
    [dim_IT_Customer_key]     BIGINT           NULL,
    [dim_IT_LocSubBranch_key] BIGINT           NULL,
    [dim_IT_Leave_key]        BIGINT           NULL,
    [dim_CostActivity_key]    BIGINT           NULL,
    [dateFrom]                DATETIME         NOT NULL,
    [dateTo]                  DATETIME         NULL,
    [entered_hours]           NUMERIC (28, 10) NULL,
    [sales_per_hour]          NUMERIC (28, 10) NULL,
    [cost_per_hour]           NUMERIC (28, 10) NULL,
    [MD_DATE_CREATED]         DATETIME         NULL,
    [MD_DATE_MODIFIED]        DATETIME         NULL,
    [MD_JOB_CODE]             INT              NULL,
    [MD_RUN_CODE]             BIGINT           NULL,
    [MD_PACK_NAME]            VARCHAR (70)     NULL,
    [MD_MODIFIED_USER]        VARCHAR (100)    NULL,
    [MD_LOGICAL_DELETE]       SMALLINT         NULL
);

