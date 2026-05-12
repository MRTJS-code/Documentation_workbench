CREATE TABLE [ods].[STG_GT_STARJC] (
    [STARref]     VARCHAR (21)    NULL,
    [custCode]    VARCHAR (13)    NOT NULL,
    [lastInvDate] DATE            NULL,
    [endDate]     DATE            NULL,
    [STARLineRef] VARCHAR (34)    NULL,
    [Activity]    VARCHAR (31)    NULL,
    [Job]         VARCHAR (21)    NULL,
    [quantity]    NUMERIC (14, 4) NULL,
    [unitPrice]   NUMERIC (14, 4) NULL,
    [netAmount]   NUMERIC (14, 2) NULL
);

