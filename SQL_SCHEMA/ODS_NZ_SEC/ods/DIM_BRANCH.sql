CREATE TABLE [ods].[DIM_BRANCH] (
    [id]                    INT          IDENTITY (1, 1) NOT NULL,
    [Branch]                VARCHAR (2)  NOT NULL,
    [Business Code]         VARCHAR (2)  NULL,
    [Branch Name]           VARCHAR (50) NOT NULL,
    [Branch Reporting Name] VARCHAR (30) NOT NULL,
    [Branch Sub Group]      VARCHAR (30) NOT NULL,
    [Branch Group]          VARCHAR (30) NOT NULL,
    [First]                 BIT          NOT NULL,
    [AX_RegionCode]         VARCHAR (3)  NOT NULL,
    [AX_RegionName]         VARCHAR (20) NOT NULL,
    [address_id]            NUMERIC (18) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

