CREATE TABLE [dw].[DIM_PUBLIC_HOLIDAY_DATES] (
    [SK_DIM_PUBLIC_HOLIDAY_DATES] INT      NOT NULL,
    [FK_Holiday]                  INT      NULL,
    [FK_Date]                     BIGINT   NULL,
    [P_Main_Date]                 DATETIME NULL,
    [P_Alt_Date]                  DATETIME NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_PUBLIC_HOLIDAY_DATES] ASC)
);

