CREATE TABLE [dbo].[SQLFileAudit] (
    [SQLFileAuditID] INT            IDENTITY (1, 1) NOT NULL,
    [FilePath]       NVARCHAR (100) NULL,
    [FileName]       NVARCHAR (50)  NULL,
    [dDate]          DATETIME       CONSTRAINT [DF_SQLFileAudit_dDate] DEFAULT (getdate()) NULL,
    [UserName]       NVARCHAR (40)  CONSTRAINT [DF_SQLFileAudit_UserName] DEFAULT (user_name()) NULL
);

