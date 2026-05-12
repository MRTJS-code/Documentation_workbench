CREATE TABLE [dw].[DIM_EMPLOYEE_PAY] (
    [SK_DIM_EMPLOYEE_PAY] BIGINT          IDENTITY (1, 1) NOT NULL,
    [FK_DIM_EMPLOYEE]     BIGINT          NOT NULL,
    [P_Base_Frequency]    VARCHAR (1)     NULL,
    [P_Base_Hours]        NUMERIC (11, 5) NULL,
    [P_Pay_Frequency]     VARCHAR (1)     NULL,
    [P_Base_Rate]         NUMERIC (15, 5) NULL,
    [P_EMS_Rate]          NUMERIC (11, 4) NULL,
    [MD_DATE_MODIFIED]    DATETIME        NULL,
    [MD_JOB_CODE]         INT             NULL,
    [MD_RUN_CODE]         BIGINT          NULL,
    [MD_ETL_RUN]          INT             NULL,
    [MD_LOGICAL_DELETE]   BIT             NULL,
    PRIMARY KEY CLUSTERED ([SK_DIM_EMPLOYEE_PAY] ASC),
    CONSTRAINT [FK_DIM_EMPLOYEE_PAY_DIM_EMPLOYEE] FOREIGN KEY ([FK_DIM_EMPLOYEE]) REFERENCES [dw].[DIM_EMPLOYEE] ([SK_DIM_EMPLOYEE])
);

