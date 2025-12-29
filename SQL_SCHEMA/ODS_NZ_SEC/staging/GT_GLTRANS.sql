CREATE TABLE [staging].[GT_GLTRANS] (
    [modifiedUser]            VARCHAR (30)    NULL,
    [modifiedTimeStamp]       DATETIME2 (7)   NULL,
    [documentDate]            DATE            NULL,
    [sourceTranType]          VARCHAR (30)    NULL,
    [reference]               VARCHAR (20)    NULL,
    [detail]                  VARCHAR (30)    NULL,
    [subCode]                 VARCHAR (20)    NULL,
    [standardText]            VARCHAR (MAX)   NULL,
    [quantity]                NUMERIC (14, 2) NULL,
    [accountNetAmount]        NUMERIC (14, 2) NULL,
    [accountTaxAmount]        NUMERIC (14, 2) NULL,
    [mySourceLineItem_clsno]  INT             NULL,
    [mySourceLineItem_instid] BIGINT          NULL,
    [oid_instid]              BIGINT          NULL,
    [oid_clsno]               INT             NULL,
    [myPeriod_clsno]          INT             NULL,
    [myPeriod_instid]         BIGINT          NULL,
    [myGLAccount_clsno]       INT             NULL,
    [myGLAccount_instid]      BIGINT          NULL,
    [postingDate]             DATE            NULL,
    [myCostActivity_clsno]    INT             NULL,
    [myCostActivity_instid]   BIGINT          NULL,
    [myJob_clsno]             INT             NULL,
    [myJob_instid]            BIGINT          NULL,
    [myOrganisation_clsno]    INT             NULL,
    [myOrganisation_instid]   BIGINT          NULL
);


GO
CREATE CLUSTERED INDEX [CX_staging_GT_GLTRANS]
    ON [staging].[GT_GLTRANS]([myPeriod_instid] ASC, [myPeriod_clsno] ASC, [myGLAccount_instid] ASC, [myGLAccount_clsno] ASC, [myCostActivity_instid] ASC, [myCostActivity_clsno] ASC, [myJob_instid] ASC, [myJob_clsno] ASC, [myOrganisation_instid] ASC, [myOrganisation_clsno] ASC);

