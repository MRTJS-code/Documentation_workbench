CREATE TABLE [dw].[DIM_NV_DRIVER] (
    [SK_DIM_DRIVER]           INT           IDENTITY (1, 1) NOT NULL,
    [PK_DRIVERID]             VARCHAR (100) NOT NULL,
    [P_OWNERID]               VARCHAR (100) NULL,
    [P_DRIVERGROUPID]         VARCHAR (100) NULL,
    [P_TITLE]                 VARCHAR (50)  NULL,
    [P_FIRSTNAME]             VARCHAR (50)  NULL,
    [P_LASTNAME]              VARCHAR (255) NULL,
    [P_DRIVERPIN]             VARCHAR (50)  NULL,
    [P_DALLASKEYPIN]          VARCHAR (50)  NULL,
    [P_MULTIPLELOGINSALLOWED] BIT           NULL,
    [P_RESTRICTLOGONPININUSE] BIT           NULL,
    [P_DRIVERGROUPNAME]       VARCHAR (255) NULL,
    [P_HIREDATE]              DATE          NULL,
    [P_MOBILEPHONE]           VARCHAR (50)  NULL,
    [P_LASTPINLOGINDATETIME]  DATETIME      NULL,
    [MD_DATELASTMODIFIED]     DATETIME      NULL,
    [MD_ETLJOB]               BIGINT        NULL,
    [MD_ETLEXECUTION]         BIGINT        NULL,
    [MD_ETLRUN]               BIGINT        NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_DRIVER] ASC)
);

