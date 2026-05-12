CREATE TABLE [eda].[LKP_DEP_Location] (
    [PK_LocationCode]        INT            NOT NULL,
    [FK_DebtorCode]          VARCHAR (20)   NULL,
    [LocationName]           NVARCHAR (100) NULL,
    [UserLastModified]       NVARCHAR (100) NULL,
    [MD_LastModified_Deputy] DATETIME       NULL,
    [MD_LastRefreshed_ETL]   DATETIME       NULL
);

