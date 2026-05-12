CREATE TABLE [ods].[DIM_GT_GL] (
    [oid]         VARCHAR (34) NOT NULL,
    [accountNo]   VARCHAR (33) NOT NULL,
    [description] VARCHAR (51) NOT NULL,
    [branchID]    INT          NULL,
    [businessID]  INT          NULL,
    [coaID]       INT          NULL,
    PRIMARY KEY CLUSTERED ([oid] ASC),
    CONSTRAINT [FK_DIM_GT_GL_DIM_BRANCH] FOREIGN KEY ([branchID]) REFERENCES [ods].[DIM_BRANCH] ([id]),
    CONSTRAINT [FK_DIM_GT_GL_DIM_BUSINESS] FOREIGN KEY ([businessID]) REFERENCES [ods].[DIM_BUSINESS] ([id]),
    CONSTRAINT [FK_DIM_GT_GL_DIM_GT_COA] FOREIGN KEY ([coaID]) REFERENCES [ods].[DIM_GT_COA] ([id])
);

