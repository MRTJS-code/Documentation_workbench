CREATE TABLE [eda].[APP_MDA_PERMISSION] (
    [SK_ID]         INT           IDENTITY (1, 1) NOT NULL,
    [PK_EMAIL]      VARCHAR (100) NOT NULL,
    [P_NAME]        VARCHAR (200) NOT NULL,
    [LOC_VIEW]      BIT           NOT NULL,
    [LOC_EDIT]      BIT           NOT NULL,
    [LOC_EXTRACT]   BIT           NOT NULL,
    [STAFF_VIEW]    BIT           NOT NULL,
    [STAFF_ADD]     BIT           NOT NULL,
    [STAFF_EDIT]    BIT           NOT NULL,
    [STAFF_EXTRACT] BIT           NOT NULL,
    [USER_ADMIN]    BIT           NOT NULL,
    PRIMARY KEY CLUSTERED ([SK_ID] ASC)
);

