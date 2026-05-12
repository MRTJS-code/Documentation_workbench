CREATE TABLE [staging].[STG_SECURITY_GUARD_LICENCE] (
    [Security_Guard_Licence_ID]     VARCHAR (50)  NULL,
    [DW_Source_System]              VARCHAR (50)  NOT NULL,
    [EmployeeId]                    VARCHAR (50)  NULL,
    [Full_Name]                     VARCHAR (50)  NULL,
    [Expiry_Date]                   DATE          NULL,
    [Employee_Notified]             DATE          NULL,
    [Last_Checked]                  DATE          NULL,
    [Security_Guard_Licence_Status] VARCHAR (255) NULL
);

