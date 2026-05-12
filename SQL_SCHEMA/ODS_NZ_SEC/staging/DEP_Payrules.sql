CREATE TABLE [staging].[DEP_Payrules] (
    [payRuleId]     INT             NULL,
    [payTitle]      VARCHAR (100)   NULL,
    [remunType]     INT             NULL,
    [remunBy]       INT             NULL,
    [salary]        DECIMAL (28, 2) NULL,
    [hourlyRate]    DECIMAL (28, 2) NULL,
    [isMultiplier]  BIT             NULL,
    [multiValue]    DECIMAL (28, 2) NULL,
    [multiBaseRate] INT             NULL,
    [minType]       INT             NULL,
    [maxType]       INT             NULL,
    [minValue]      DECIMAL (28, 2) NULL,
    [maxValue]      DECIMAL (28, 2) NULL,
    [isExported]    BIT             NULL,
    [unitValue]     DECIMAL (28, 2) NULL,
    [payPortion]    INT             NULL,
    [payExportCode] VARCHAR (50)    NULL,
    [rateType]      INT             NULL
);

