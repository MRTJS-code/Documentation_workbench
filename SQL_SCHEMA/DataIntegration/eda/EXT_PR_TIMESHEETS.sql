CREATE TABLE [eda].[EXT_PR_TIMESHEETS] (
    [Record Type]      VARCHAR (1)     NOT NULL,
    [ID Number]        VARCHAR (50)    NULL,
    [Costing Date]     DATE            NULL,
    [Hours Code]       VARCHAR (2)     NULL,
    [Hours Amount]     FLOAT (53)      NULL,
    [Hourly Rate]      FLOAT (53)      NULL,
    [Date From]        DATE            NULL,
    [Date To]          DATE            NULL,
    [Leave Reason]     VARCHAR (2)     NULL,
    [Leave Units]      NUMERIC (10, 5) NULL,
    [A/D Code]         VARCHAR (2)     NULL,
    [Units]            INT             NULL,
    [Unit Rate]        FLOAT (53)      NULL,
    [Labour Costing 1] VARCHAR (10)    NULL,
    [Labour Costing 2] VARCHAR (10)    NULL,
    [Labour Costing 3] VARCHAR (20)    NULL,
    [User Costing 1]   VARCHAR (10)    NULL,
    [itDRGLAccount]    VARCHAR (30)    NULL,
    [gtSource]         VARCHAR (20)    NULL,
    [accountNo]        VARCHAR (32)    NULL
);

