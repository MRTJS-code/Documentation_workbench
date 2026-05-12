CREATE TABLE [eda].[EXT_IT_BILLLEGACY] (
    [customerName]    VARCHAR (200) NULL,
    [debtorCode]      VARCHAR (50)  NULL,
    [locationName]    VARCHAR (200) NULL,
    [locShortName]    VARCHAR (50)  NULL,
    [jobCode]         VARCHAR (50)  NULL,
    [locBillType]     VARCHAR (200) NULL,
    [subLocationName] VARCHAR (200) NULL,
    [empDisplayName]  VARCHAR (150) NULL,
    [employeeRefId]   VARCHAR (50)  NULL,
    [regularHours]    FLOAT (53)    NULL,
    [phHours]         FLOAT (53)    NULL,
    [startTime]       DATETIME      NULL,
    [endTime]         DATETIME      NULL,
    [multCode]        VARCHAR (50)  NULL,
    [narration]       VARCHAR (MAX) NULL,
    [eventId]         INT           NULL
);

