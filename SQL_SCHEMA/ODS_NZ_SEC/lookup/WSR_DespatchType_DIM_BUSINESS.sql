CREATE TABLE [lookup].[WSR_DespatchType_DIM_BUSINESS] (
    [DespatchTypeId]       INT           NULL,
    [despatchDescription]  VARCHAR (100) NULL,
    [FK_DIM_BUSINESS]      INT           NULL,
    [despatchTypeCategory] VARCHAR (50)  NULL
);

