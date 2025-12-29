CREATE TABLE [ods].[STG_GT_EMPEE] (
    [gtId]                VARCHAR (34)  NULL,
    [empid]               INT           NULL,
    [firstname]           NVARCHAR (31) NULL,
    [surname]             NVARCHAR (31) NULL,
    [fullname]            NVARCHAR (63) NULL,
    [gender]              VARCHAR (31)  NULL,
    [email]               VARCHAR (MAX) NULL,
    [homePhone]           VARCHAR (51)  NULL,
    [businessPhone]       VARCHAR (51)  NULL,
    [mobile]              VARCHAR (51)  NULL,
    [isInactive]          BIT           NULL,
    [payGroup]            VARCHAR (31)  NULL,
    [branchCode]          VARCHAR (7)   NULL,
    [hrBasis]             VARCHAR (61)  NULL,
    [hrType]              VARCHAR (61)  NULL,
    [startDate]           DATE          NULL,
    [nextAnniversaryDate] DATE          NULL,
    [terminationDate]     DATE          NULL
);

