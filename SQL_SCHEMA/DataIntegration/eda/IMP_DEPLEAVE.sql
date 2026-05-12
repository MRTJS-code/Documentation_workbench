CREATE TABLE [eda].[IMP_DEPLEAVE] (
    [EVENT_ID]  INT           NOT NULL,
    [ROSTER_ID] INT           NULL,
    [LEAVE_ID]  INT           NULL,
    [LEAVEDATE] DATE          NULL,
    [JOBCODE]   VARCHAR (50)  NULL,
    [IMPJSON]   VARCHAR (255) NULL,
    [COSTPERHR] FLOAT (53)    NULL
);

