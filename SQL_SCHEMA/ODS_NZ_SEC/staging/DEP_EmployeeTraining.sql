CREATE TABLE [staging].[DEP_EmployeeTraining] (
    [Id]               INT           NULL,
    [EmployeeId]       INT           NULL,
    [TrainingId]       INT           NULL,
    [TrainingDate]     DATETIME      NULL,
    [ExpiryDate]       DATETIME      NULL,
    [Active]           BIT           NULL,
    [Comment]          VARCHAR (500) NULL,
    [TrainingName]     VARCHAR (100) NULL,
    [TrainingProvider] VARCHAR (100) NULL
);

