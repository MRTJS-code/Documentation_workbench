CREATE TABLE [dw].[DIM_CONTACT] (
    [SK_DIM_CONTACT]      BIGINT        IDENTITY (1, 1) NOT NULL,
    [PK_SourceSystem]     VARCHAR (100) NOT NULL,
    [PK_SourceId]         BIGINT        NOT NULL,
    [ContactNotes]        VARCHAR (100) NULL,
    [ContactPhone1]       VARCHAR (100) NULL,
    [ContactPhone2]       VARCHAR (100) NULL,
    [ContactPhone3]       VARCHAR (100) NULL,
    [ContactEmail1]       VARCHAR (100) NULL,
    [ContactEmail2]       VARCHAR (100) NULL,
    [ContactIM1]          VARCHAR (100) NULL,
    [ContactIM2]          VARCHAR (100) NULL,
    [ContactWebsite]      VARCHAR (100) NULL,
    [ContactSaved]        BIT           NULL,
    [MD_CreateDate]       DATETIME      NULL,
    [MD_ModifiedDate]     DATETIME      NULL,
    [MD_ETLJobCode]       INT           NULL,
    [MD_ETLRunCode]       BIGINT        NULL,
    [MD_ETLRun]           BIGINT        NULL,
    [MD_ModifiedUser]     VARCHAR (100) NULL,
    [FK_QA_QUALITYHEADER] BIGINT        NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_CONTACT] ASC)
);

