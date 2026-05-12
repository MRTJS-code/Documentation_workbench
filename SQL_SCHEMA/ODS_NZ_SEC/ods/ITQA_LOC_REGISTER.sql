CREATE TABLE [ods].[ITQA_LOC_REGISTER] (
    [LOC_REFERENCE]        VARCHAR (7)   NULL,
    [LOC_CODE]             VARCHAR (25)  NULL,
    [LOC_NAME]             VARCHAR (100) NULL,
    [SUBLOC_NAME]          VARCHAR (100) NULL,
    [LOC_BRANCH]           VARCHAR (25)  NULL,
    [JOB_STATUS]           VARCHAR (25)  NULL,
    [DATE_CREATED]         DATETIME      NULL,
    [DATE_LAST_MODIFIED]   DATETIME      NULL,
    [DATE_LAST_ASSIGNMENT] DATE          NULL,
    [LOC_STATUS]           VARCHAR (25)  NULL,
    [locId]                INT           NULL,
    [itRefMissing]         BIT           NULL,
    [itNameChange]         BIT           NULL,
    [itJobCodeChange]      BIT           NULL,
    [itJobCodeInvalid]     BIT           NULL,
    [itJobCodeClosed]      BIT           NULL,
    [gtJobCodeReview]      BIT           NULL,
    [itNewLocation]        BIT           NULL,
    [itBadActivity]        BIT           NULL
);

