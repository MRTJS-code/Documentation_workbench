CREATE TABLE [ods].[LKP_GT_CUSTOMER] (
    [oid]            VARCHAR (34)  NULL,
    [status]         VARCHAR (MAX) NULL,
    [payTerm]        VARCHAR (41)  NULL,
    [custCode]       VARCHAR (13)  NULL,
    [custName]       VARCHAR (51)  NULL,
    [address1]       VARCHAR (51)  NULL,
    [address2]       VARCHAR (51)  NULL,
    [address3]       VARCHAR (51)  NULL,
    [suburb]         VARCHAR (51)  NULL,
    [city]           VARCHAR (21)  NULL,
    [postCode]       VARCHAR (11)  NULL,
    [primaryEmail]   VARCHAR (MAX) NULL,
    [primaryPhone]   VARCHAR (51)  NULL,
    [primaryMobile]  VARCHAR (51)  NULL,
    [primaryContact] VARCHAR (31)  NULL,
    [custWebsite]    VARCHAR (MAX) NULL,
    [receiptType]    VARCHAR (MAX) NULL,
    [poRequired]     BIT           NULL,
    [invoiceEmail]   VARCHAR (MAX) NULL,
    [statementEmail] VARCHAR (MAX) NULL,
    [cust_group]     VARCHAR (55)  NULL
);

