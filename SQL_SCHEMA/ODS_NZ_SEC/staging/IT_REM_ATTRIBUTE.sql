CREATE TABLE [staging].[IT_REM_ATTRIBUTE] (
    [id]          BIGINT       IDENTITY (1, 1) NOT NULL,
    [employeeId]  VARCHAR (50) NULL,
    [attName]     VARCHAR (50) NULL,
    [attRef]      VARCHAR (50) NULL,
    [attValue]    VARCHAR (50) NULL,
    [locRef]      VARCHAR (50) NULL,
    [actRef]      VARCHAR (50) NULL,
    [validFrom]   DATETIME     NULL,
    [validTo]     DATETIME     NULL,
    [processDate] DATETIME     NULL
);

