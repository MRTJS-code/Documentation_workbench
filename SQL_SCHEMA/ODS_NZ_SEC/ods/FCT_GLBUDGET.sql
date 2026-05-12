CREATE TABLE [ods].[FCT_GLBUDGET] (
    [id]        INT             IDENTITY (1, 1) NOT NULL,
    [periodOid] VARCHAR (34)    NULL,
    [ax final]  VARCHAR (6)     NULL,
    [br id]     INT             NULL,
    [bs id]     INT             NULL,
    [Total]     NUMERIC (14, 2) NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_FCT_GLBUDGET_DIM_AX_COA] FOREIGN KEY ([ax final]) REFERENCES [ods].[DIM_AX_COA] ([axGLAcc]),
    CONSTRAINT [FK_FCT_GLBUDGET_DIM_BRANCH] FOREIGN KEY ([br id]) REFERENCES [ods].[DIM_BRANCH] ([id]),
    CONSTRAINT [FK_FCT_GLBUDGET_DIM_BUSINESS] FOREIGN KEY ([bs id]) REFERENCES [ods].[DIM_BUSINESS] ([id]),
    CONSTRAINT [FK_FCT_GLBUDGET_DIM_GT_PERIOD] FOREIGN KEY ([periodOid]) REFERENCES [ods].[DIM_GT_PERIOD] ([oid])
);

