CREATE TABLE [dw].[DIM_JOB] (
    [SK_DIM_JOB]            BIGINT        IDENTITY (1, 1) NOT NULL,
    [P_jobCode]             VARCHAR (20)  NOT NULL,
    [P_jobName]             VARCHAR (120) NULL,
    [P_oid_clsno]           INT           NOT NULL,
    [P_oid_instid]          BIGINT        NOT NULL,
    [P_oid_parent_clsno]    INT           NULL,
    [P_oid_parent_instid]   BIGINT        NULL,
    [FK_DIM_PROFITCENTRE]   BIGINT        NULL,
    [P_createDate]          DATE          NULL,
    [P_jobStatus]           VARCHAR (20)  NULL,
    [P_jobClosed]           BIT           NULL,
    [P_jobChargeType]       VARCHAR (6)   NULL,
    [P_jobActivityGroup]    VARCHAR (30)  NULL,
    [P_jobType]             VARCHAR (6)   NULL,
    [FK_DIM_ORGANISATION]   BIGINT        NULL,
    [P_salesCodeOverride]   VARCHAR (MAX) NULL,
    [FK_DIM_JOB_PRICE]      BIGINT        NULL,
    [P_payRate]             FLOAT (53)    NULL,
    [P_lastDocDate]         DATE          NULL,
    [P_billingGroup]        VARCHAR (30)  NULL,
    [P_orderNumber]         VARCHAR (30)  NULL,
    [P_clientReference]     VARCHAR (20)  NULL,
    [P_jobReference]        VARCHAR (20)  NULL,
    [P_quoteReference]      VARCHAR (20)  NULL,
    [P_invoiceReportFormat] VARCHAR (70)  NULL,
    [P_jobManager]          VARCHAR (10)  NULL,
    [P_AXCC]                VARCHAR (13)  NULL,
    [P_GroupContract]       VARCHAR (60)  NULL,
    [P_MajorContract]       VARCHAR (50)  NULL,
    [P_StaticGuard]         BIT           NULL,
    [MD_DATE_CREATED]       DATE          NULL,
    [MD_DATE_MODIFIED]      DATE          NULL,
    [MD_JOB_CODE]           INT           NULL,
    [MD_RUN_CODE]           BIGINT        NULL,
    [MD_PACK_NAME]          VARCHAR (70)  NULL,
    [MD_MODIFIED_USER]      VARCHAR (100) NULL,
    [MD_LOGICAL_DELETE]     SMALLINT      NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_JOB] ASC),
    CONSTRAINT [FK_DIM_JOB_DIM_JOB_PRICE] FOREIGN KEY ([FK_DIM_JOB_PRICE]) REFERENCES [dw].[DIM_JOB_PRICE] ([SK_DIM_JOB_PRICE]),
    CONSTRAINT [FK_DIM_JOB_DIM_ORGANISATION] FOREIGN KEY ([FK_DIM_ORGANISATION]) REFERENCES [dw].[DIM_ORGANISATION] ([SK_DIM_Organisation]),
    CONSTRAINT [FK_DIM_JOB_DIM_PROFITCENTRE] FOREIGN KEY ([FK_DIM_PROFITCENTRE]) REFERENCES [dw].[DIM_PROFITCENTRE] ([SK_DIM_ProfitCentre])
);


GO
CREATE NONCLUSTERED INDEX [IX_DIM_JOB_P_oid_instid]
    ON [dw].[DIM_JOB]([P_oid_instid] ASC, [P_oid_clsno] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DIM_JOB_P_jobCode]
    ON [dw].[DIM_JOB]([P_jobCode] ASC);

