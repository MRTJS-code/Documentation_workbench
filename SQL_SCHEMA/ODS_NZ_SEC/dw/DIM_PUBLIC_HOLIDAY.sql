CREATE TABLE [dw].[DIM_PUBLIC_HOLIDAY] (
    [SK_DIM_PUBLIC_HOLIDAY] INT          NOT NULL,
    [P_Holiday_Name]        VARCHAR (50) NULL,
    [P_Is_National]         BIT          NULL,
    [P_Is_Active]           BIT          NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_PUBLIC_HOLIDAY] ASC)
);

