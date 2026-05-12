CREATE TABLE [eda].[LKP_GT_JOB] (
    [jobCode]       VARCHAR (20)  NULL,
    [jobName]       VARCHAR (120) NULL,
    [jobStatus]     VARCHAR (20)  NULL,
    [isClosed]      BIT           NULL,
    [jobDrGL]       VARCHAR (30)  NULL,
    [sendToPreceda] BIT           NULL,
    [billingType]   VARCHAR (20)  NULL,
    [wageRate]      FLOAT (53)    NULL,
    [gtSource]      VARCHAR (20)  NULL,
    [jobType]       VARCHAR (6)   NULL,
    [custCode]      VARCHAR (12)  NULL,
    [custName]      VARCHAR (50)  NULL
);

