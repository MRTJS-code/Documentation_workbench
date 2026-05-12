CREATE TABLE [staging].[IT_ATT_ERROR] (
    [employeeId] VARCHAR (50)  NULL,
    [attName]    VARCHAR (50)  NULL,
    [attRef]     VARCHAR (50)  NULL,
    [attValue]   VARCHAR (50)  NULL,
    [locName]    VARCHAR (100) NULL,
    [locRef]     VARCHAR (50)  NULL,
    [actNam]     VARCHAR (100) NULL,
    [actRef]     VARCHAR (50)  NULL,
    [validFrom]  DATETIME      NULL,
    [validTo]    DATETIME      NULL,
    [note]       VARCHAR (255) NULL,
    [endpoint]   VARCHAR (100) NULL,
    [errorMsg]   TEXT          NULL
);

