CREATE TABLE [staging].[STG_GT_GLACCOUNT] (
    [oid_clsno]         INT           NULL,
    [oid_instid]        BIGINT        NULL,
    [accountNo]         VARCHAR (32)  NULL,
    [description]       VARCHAR (50)  NULL,
    [modifiedTimeStamp] DATETIME2 (7) NULL,
    [modifiedUser]      VARCHAR (50)  NULL,
    [accountType]       VARCHAR (50)  NULL,
    [accountStatus]     VARCHAR (50)  NULL,
    [FK_DIM_GT_COA]     INT           NULL,
    [FK_DIM_BRANCH]     INT           NULL,
    [FK_DIM_BUSINESS]   INT           NULL
);

