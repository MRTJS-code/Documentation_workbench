CREATE TABLE [ods].[DIM_BUSINESS] (
    [id]                        INT          IDENTITY (1, 1) NOT NULL,
    [Branch]                    VARCHAR (2)  NULL,
    [Business Code]             VARCHAR (2)  NOT NULL,
    [Business Type Description] VARCHAR (40) NOT NULL,
    [Business Type Summary]     VARCHAR (20) NOT NULL,
    [Include First]             BIT          NOT NULL,
    [Type Sale]                 VARCHAR (10) NOT NULL,
    [GOS]                       BIT          NOT NULL,
    [Revenue]                   BIT          NOT NULL,
    [Static Guards]             BIT          NOT NULL,
    [BI Business Type Summary]  VARCHAR (40) NULL,
    [BI Patrols Type]           VARCHAR (40) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC)
);

