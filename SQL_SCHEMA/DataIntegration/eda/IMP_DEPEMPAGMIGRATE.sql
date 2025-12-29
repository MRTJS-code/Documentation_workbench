CREATE TABLE [eda].[IMP_DEPEMPAGMIGRATE] (
    [eventId]      INT            NOT NULL,
    [employeeId]   INT            NOT NULL,
    [currAgreeId]  INT            NULL,
    [newAgreeId]   INT            NULL,
    [newAgreeBody] VARCHAR (500)  NULL,
    [errorMsg]     VARCHAR (2000) NULL
);

