CREATE TABLE [staging].[DEP_AGREEHISTORY] (
    [AgreeHistId]  INT           NULL,
    [AgreementId]  INT           NULL,
    [PayrollId]    VARCHAR (100) NULL,
    [Active]       BIT           NULL,
    [StartDate]    DATETIME      NULL,
    [CreateDate]   DATETIME      NULL,
    [ModifiedDate] DATETIME      NULL,
    [CreatedUser]  VARCHAR (100) NULL
);

