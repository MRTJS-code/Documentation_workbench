CREATE TABLE [dw].[DIM_ORGANISATION] (
    [SK_DIM_Organisation] BIGINT        IDENTITY (1, 1) NOT NULL,
    [P_Oid_clsno]         INT           NOT NULL,
    [P_Oid_instid]        BIGINT        NOT NULL,
    [P_Code]              VARCHAR (13)  NOT NULL,
    [P_Name]              VARCHAR (51)  NOT NULL,
    [P_Status]            VARCHAR (50)  NULL,
    [P_PayTerm]           VARCHAR (41)  NULL,
    [P_OrgGroup]          VARCHAR (55)  NULL,
    [P_Type]              VARCHAR (20)  NOT NULL,
    [P_Address1]          VARCHAR (51)  NULL,
    [P_Address2]          VARCHAR (51)  NULL,
    [P_Address3]          VARCHAR (51)  NULL,
    [P_Suburb]            VARCHAR (51)  NULL,
    [P_City]              VARCHAR (21)  NULL,
    [P_PostCode]          VARCHAR (11)  NULL,
    [P_PrimaryEmail]      VARCHAR (MAX) NULL,
    [P_PrimaryPhone]      VARCHAR (51)  NULL,
    [P_PrimaryMobile]     VARCHAR (51)  NULL,
    [P_PrimaryContact]    VARCHAR (31)  NULL,
    [P_CustWebsite]       VARCHAR (MAX) NULL,
    [P_ReceiptType]       VARCHAR (MAX) NULL,
    [P_PoRequired]        BIT           NULL,
    [P_InvoiceEmail]      VARCHAR (MAX) NULL,
    [P_StatementEmail]    VARCHAR (MAX) NULL,
    [MD_DATE_CREATED]     DATE          NULL,
    [MD_DATE_MODIFIED]    DATE          NULL,
    [MD_JOB_CODE]         INT           NULL,
    [MD_RUN_CODE]         BIGINT        NULL,
    [MD_PACK_NAME]        VARCHAR (70)  NULL,
    [MD_MODIFIED_USER]    VARCHAR (100) NULL,
    [MD_LOGICAL_DELETE]   SMALLINT      NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_Organisation] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_DIM_ORGANISATION_P_oid_instid]
    ON [dw].[DIM_ORGANISATION]([P_Oid_instid] ASC, [P_Oid_clsno] ASC);

