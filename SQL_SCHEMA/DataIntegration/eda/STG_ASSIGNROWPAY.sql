CREATE TABLE [eda].[STG_ASSIGNROWPAY] (
    [assignmentId]            BIGINT        NULL,
    [assignmentRow]           INT           NULL,
    [hours]                   FLOAT (53)    NULL,
    [payRow]                  INT           NULL,
    [payType]                 VARCHAR (50)  NULL,
    [rate]                    FLOAT (53)    NULL,
    [rateCode]                VARCHAR (50)  NULL,
    [leaveName]               VARCHAR (100) NULL,
    [leaveShortName]          VARCHAR (50)  NULL,
    [leaveCode]               VARCHAR (50)  NULL,
    [payLeaveName]            VARCHAR (100) NULL,
    [timeBankPayoutReference] VARCHAR (50)  NULL,
    [timeBankName]            VARCHAR (100) NULL,
    [hoursModifierName]       VARCHAR (200) NULL,
    [hoursModifierShortName]  VARCHAR (50)  NULL,
    [hoursModifierReference]  VARCHAR (50)  NULL,
    [hourModifierType]        VARCHAR (50)  NULL,
    [hoursModifierCode]       VARCHAR (50)  NULL,
    [premium]                 FLOAT (53)    NULL,
    [rateMultiplier]          FLOAT (53)    NULL,
    [premiumHoursType]        VARCHAR (20)  NULL
);

