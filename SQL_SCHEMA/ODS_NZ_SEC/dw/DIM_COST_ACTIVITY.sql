CREATE TABLE [dw].[DIM_COST_ACTIVITY] (
    [SK_DIM_Cost_Activity] BIGINT        IDENTITY (1, 1) NOT NULL,
    [P_Oid_clsno]          INT           NOT NULL,
    [P_Oid_instid]         BIGINT        NOT NULL,
    [P_Code]               VARCHAR (50)  NULL,
    [P_Description]        VARCHAR (50)  NULL,
    [MD_DATE_CREATED]      DATE          NULL,
    [MD_DATE_MODIFIED]     DATE          NULL,
    [MD_JOB_CODE]          INT           NULL,
    [MD_RUN_CODE]          BIGINT        NULL,
    [MD_PACK_NAME]         VARCHAR (70)  NULL,
    [MD_MODIFIED_USER]     VARCHAR (100) NULL,
    [MD_LOGICAL_DELETE]    SMALLINT      NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_Cost_Activity] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_DIM_COST_ACTIVITY_P_oid_instid]
    ON [dw].[DIM_COST_ACTIVITY]([P_Oid_instid] ASC, [P_Oid_clsno] ASC);

