CREATE TABLE [dw].[DIM_CLIENT_DESPATCH_RESPONSE] (
    [SK_DIM_CLIENT_DESPATCH_RESPONSE] BIGINT       IDENTITY (1, 1) NOT NULL,
    [FK_DIM_CLIENTLOCATION]           BIGINT       NOT NULL,
    [FK_DIM_DESPATCH_TYPE]            BIGINT       NOT NULL,
    [PK_ClientId]                     INT          NOT NULL,
    [PK_DespatchTypeId]               INT          NOT NULL,
    [ResponseTimeDay]                 INT          NULL,
    [ResponseTimeNight]               INT          NULL,
    [ResponseSource]                  VARCHAR (25) NULL,
    [MD_DATE_CREATED]                 DATETIME     NULL,
    [MD_DATE_MODIFIED]                DATETIME     NULL,
    [MD_JOB_CODE]                     INT          NULL,
    [MD_RUN_CODE]                     BIGINT       NULL,
    [MD_ETL_RUN]                      INT          NULL,
    [MD_LOGICAL_DELETE]               BIT          NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_CLIENT_DESPATCH_RESPONSE] ASC)
);

