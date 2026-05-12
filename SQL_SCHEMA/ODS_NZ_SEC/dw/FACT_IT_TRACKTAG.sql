CREATE TABLE [dw].[FACT_IT_TRACKTAG] (
    [PKTag]            VARCHAR (12)   NOT NULL,
    [P_assignmentId]   BIGINT         NULL,
    [P_categoryName]   NVARCHAR (255) NULL,
    [P_categoryRef]    NVARCHAR (255) NULL,
    [P_tag]            NVARCHAR (255) NULL,
    [P_assignmentDate] DATE           NULL,
    [MD_DATE_CREATED]  DATE           NULL,
    [MD_DATE_MODIFIED] DATE           NULL,
    [MD_JOB_CODE]      INT            NULL,
    [MD_RUN_CODE]      BIGINT         NULL,
    [MD_PACK_NAME]     VARCHAR (70)   NULL,
    PRIMARY KEY CLUSTERED ([PKTag] ASC)
);

