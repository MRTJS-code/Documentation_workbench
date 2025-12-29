CREATE TABLE [lookup].[D365_Customers] (
    [SKCustomer]   VARCHAR (36)  NOT NULL,
    [CustomerCode] VARCHAR (12)  NULL,
    [CustomerName] VARCHAR (100) NULL,
    [ETLModified]  DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([SKCustomer] ASC)
);

