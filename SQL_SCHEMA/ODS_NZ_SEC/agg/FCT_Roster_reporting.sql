CREATE TABLE [agg].[FCT_Roster_reporting] (
    [PKAssign]             VARCHAR (15)     NULL,
    [assignmentId]         BIGINT           NULL,
    [itStaffId]            NVARCHAR (255)   NULL,
    [dateFrom]             DATETIME         NULL,
    [dateTo]               DATETIME         NULL,
    [enteredHours]         NUMERIC (28, 10) NULL,
    [itCustomer]           NVARCHAR (255)   NULL,
    [itLocation]           NVARCHAR (255)   NULL,
    [itSubLocation]        NVARCHAR (255)   NULL,
    [noCharge]             NVARCHAR (20)    NULL,
    [branchID]             INT              NULL,
    [bsid]                 INT              NULL,
    [FK_DIM_SECURITYGUARD] BIGINT           NULL,
    [customerOid]          VARCHAR (34)     NULL,
    [payrollTransType]     NVARCHAR (255)   NULL,
    [leaveName]            NVARCHAR (255)   NULL,
    [jobOid]               VARCHAR (34)     NULL,
    [billActivityOid]      VARCHAR (34)     NULL,
    [assignmentDate]       DATE             NULL,
    [lastModified]         DATETIME         NULL,
    [created]              DATETIME         NULL
);

