CREATE TABLE [ods].[DIM_AX_COA] (
    [axGLAcc]   VARCHAR (6)  NOT NULL,
    [axGLDesc]  VARCHAR (50) NOT NULL,
    [glReport]  VARCHAR (3)  NOT NULL,
    [glType]    VARCHAR (20) NOT NULL,
    [glSubtype] VARCHAR (30) NOT NULL,
    [nos]       BIT          NULL,
    PRIMARY KEY CLUSTERED ([axGLAcc] ASC)
);

