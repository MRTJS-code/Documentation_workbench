CREATE TABLE [qa].[QualityDetail] (
    [Id]                   BIGINT        IDENTITY (1, 1) NOT NULL,
    [FK_Header]            BIGINT        NOT NULL,
    [qaSeverity]           VARCHAR (50)  NOT NULL,
    [dateFound]            DATETIME      NOT NULL,
    [dateResolved]         DATETIME      NULL,
    [qaCode]               INT           NOT NULL,
    [qaSummary]            VARCHAR (500) NULL,
    [qaDetail]             VARCHAR (MAX) NULL,
    [autoFixEventId]       INT           NULL,
    [autoFixEventAt]       DATETIME      NULL,
    [autoFixSuccess]       BIT           NULL,
    [autoFixMessage]       VARCHAR (200) NULL,
    [retryValue]           INT           NULL,
    [retryMax]             INT           NULL,
    [hasBillingAdjustment] BIT           NULL,
    [hasPayrollAdjustment] BIT           NULL,
    [createdBy]            VARCHAR (100) NULL,
    [modifiedBy]           VARCHAR (100) NULL,
    [createdDate]          DATETIME      NULL,
    [modifiedDate]         DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [CK_QualityDetail_qaSeverity] CHECK ([qaSeverity]='Issue' OR [qaSeverity]='Warning'),
    CONSTRAINT [FK_QualityDetail_Header] FOREIGN KEY ([FK_Header]) REFERENCES [qa].[QualityHeader] ([Id]),
    CONSTRAINT [FK_QualityDetail_Type] FOREIGN KEY ([qaCode]) REFERENCES [qa].[QualityType] ([Id])
);


GO
-- Relationships from DBML

-- Ref QualityHead_Detail: MD_QualityHeader.Id < MD_QualityDetail.FK_Header

GO
-- Ref QualDetail_Type: MD_QualityDetail.qaCode > MD_QualityType.Id

GO
