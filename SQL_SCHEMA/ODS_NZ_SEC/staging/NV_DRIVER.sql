CREATE TABLE [staging].[NV_DRIVER] (
    [OwnerID]               VARCHAR (100) NULL,
    [DriverGroupID]         VARCHAR (100) NULL,
    [DriverID]              VARCHAR (100) NULL,
    [Title]                 VARCHAR (50)  NULL,
    [FirstName]             VARCHAR (50)  NULL,
    [LastName]              VARCHAR (255) NULL,
    [DriverPin]             VARCHAR (50)  NULL,
    [DallasKeyPin]          VARCHAR (50)  NULL,
    [MultipleLoginsAllowed] BIT           NULL,
    [RestrictLogonPINInUse] BIT           NULL,
    [DriverFullName]        VARCHAR (255) NULL,
    [DriverGroupName]       VARCHAR (255) NULL,
    [HireDate]              DATETIME      NULL,
    [MobilePhone]           VARCHAR (50)  NULL,
    [LastPinLoginDateTime]  DATETIME      NULL
);

