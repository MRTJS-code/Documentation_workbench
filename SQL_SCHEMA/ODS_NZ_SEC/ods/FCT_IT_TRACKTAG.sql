CREATE TABLE [ods].[FCT_IT_TRACKTAG] (
    [PKTag]          VARCHAR (12)   NOT NULL,
    [assignmentId]   BIGINT         NULL,
    [categoryName]   NVARCHAR (255) NULL,
    [categoryRef]    NVARCHAR (255) NULL,
    [tag]            NVARCHAR (255) NULL,
    [assignmentDate] DATE           NULL,
    PRIMARY KEY CLUSTERED ([PKTag] ASC)
);

