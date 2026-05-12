CREATE TABLE [staging].[DIM_DEPEMPLOYEEWORKPLACE] (
    [Id]              INT           NULL,
    [EmployeeId]      INT           NULL,
    [CompanyId]       INT           NULL,
    [AgreementId]     INT           NULL,
    [Creator]         VARCHAR (100) NULL,
    [Modified]        DATETIME      NULL,
    [AgreementActive] BIT           NULL
);

