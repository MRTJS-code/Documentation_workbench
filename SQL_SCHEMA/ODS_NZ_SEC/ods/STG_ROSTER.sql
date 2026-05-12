CREATE TABLE [ods].[STG_ROSTER] (
    [assignmentId]     BIGINT           NULL,
    [itStaffId]        NVARCHAR (255)   NULL,
    [start]            DATETIME         NULL,
    [end]              DATETIME         NULL,
    [enteredHours]     NUMERIC (28, 10) NULL,
    [itCustomer]       NVARCHAR (255)   NULL,
    [itLocation]       NVARCHAR (255)   NULL,
    [itSubLocation]    NVARCHAR (255)   NULL,
    [noCharge]         NVARCHAR (20)    NULL,
    [branchID]         INT              NULL,
    [bsId]             INT              NULL,
    [customerOid]      VARCHAR (34)     NULL,
    [gtEmpId]          VARCHAR (34)     NULL,
    [payrollTransType] NVARCHAR (255)   NULL,
    [leaveName]        NVARCHAR (255)   NULL,
    [jobOid]           VARCHAR (34)     NULL,
    [billActivityOid]  VARCHAR (34)     NULL,
    [assignmentDate]   DATE             NULL,
    [lastModified]     DATETIME         NULL
);

