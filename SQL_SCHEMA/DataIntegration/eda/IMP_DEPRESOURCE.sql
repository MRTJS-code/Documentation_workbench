CREATE TABLE [eda].[IMP_DEPRESOURCE] (
    [eventId]     INT            NOT NULL,
    [apiType]     VARCHAR (50)   NOT NULL,
    [resource]    VARCHAR (50)   NOT NULL,
    [recordId]    INT            NULL,
    [isBulk]      BIT            NOT NULL,
    [isInsert]    BIT            NOT NULL,
    [reqBody]     VARCHAR (2000) NOT NULL,
    [responseMsg] VARCHAR (2000) NULL
);

