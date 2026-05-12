CREATE TABLE [eda].[IMP_DEPTIMESHEETFIX] (
    [eventId]      INT            NOT NULL,
    [employeeId]   INT            NOT NULL,
    [locationId]   INT            NULL,
    [agreementId]  INT            NOT NULL,
    [timesheets]   VARCHAR (1000) NOT NULL,
    [respMessage]  VARCHAR (500)  NULL,
    [isAdditional] BIT            NULL
);

