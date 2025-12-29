CREATE TABLE [ods].[LKP_GT_CUSTOMER_OLD] (
    [oid]          VARCHAR (34)  NOT NULL,
    [code]         VARCHAR (13)  NOT NULL,
    [name]         VARCHAR (51)  NOT NULL,
    [status]       VARCHAR (50)  NOT NULL,
    [payTerm]      VARCHAR (41)  NULL,
    [emailAddress] VARCHAR (MAX) NULL,
    [cust_group]   VARCHAR (55)  NULL
);

