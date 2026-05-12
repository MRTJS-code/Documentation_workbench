CREATE TABLE [lookup].[IS_ALLINCIDENTS] (
    [Incident Number]                       VARCHAR (50)  NULL,
    [Occurred Date]                         DATETIME      NULL,
    [Incident Type]                         VARCHAR (100) NULL,
    [Injury Classification]                 VARCHAR (50)  NULL,
    [Mechanism of Injury Illness Near Miss] VARCHAR (200) NULL,
    [Description]                           VARCHAR (MAX) NULL,
    [Person Type]                           VARCHAR (100) NULL,
    [Impacted]                              VARCHAR (200) NULL,
    [Location]                              VARCHAR (250) NULL,
    [Person Responsible]                    VARCHAR (200) NULL,
    [Incident Severity]                     VARCHAR (100) NULL,
    [Residual Rating]                       VARCHAR (25)  NULL,
    [State Region]                          VARCHAR (50)  NULL,
    [Status]                                VARCHAR (50)  NULL,
    [Nature of Injury]                      VARCHAR (50)  NULL,
    [List  Body Part Injured]               VARCHAR (100) NULL,
    [Worksafe Notifiable?]                  VARCHAR (5)   NULL,
    [Business Unit]                         VARCHAR (100) NULL,
    [Hazard Potential Harm]                 VARCHAR (100) NULL,
    [Did this result in a Claim?]           VARCHAR (5)   NULL,
    [Did this result in an EIP?]            VARCHAR (5)   NULL
);

