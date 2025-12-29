CREATE TABLE [ods].[DIM_GT_COA] (
    [id]         INT          IDENTITY (1, 1) NOT NULL,
    [gtGLAcc]    VARCHAR (5)  NOT NULL,
    [gtGLDesc]   VARCHAR (50) NOT NULL,
    [gtBranch]   VARCHAR (2)  NULL,
    [gtBusiness] VARCHAR (2)  NULL,
    [axGLAcc]    VARCHAR (6)  NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_DIM_GT_COA_DIM_AX_COA] FOREIGN KEY ([axGLAcc]) REFERENCES [ods].[DIM_AX_COA] ([axGLAcc])
);

