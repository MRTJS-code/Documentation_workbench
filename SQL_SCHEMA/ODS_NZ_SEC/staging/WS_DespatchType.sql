CREATE TABLE [staging].[WS_DespatchType] (
    [DespatchTypeId]       INT          NULL,
    [Code]                 VARCHAR (64) NULL,
    [FK_DIM_BUSINESS]      INT          NULL,
    [DespatchTypeCategory] VARCHAR (50) NULL
);

