CREATE TABLE qa.QualityNotify (
    Id              int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    FK_Detail       bigint           NOT NULL,
    notifyEmail     VARCHAR(100)  NULL,
    notifySent      DATETIME      NULL,
    notifyEventId   INT           NULL,
    notifyStatus    VARCHAR(50)   NULL,
    notifyMessage   VARCHAR(1000) NULL
);
GO
-- Ref QualDetail_Notify: MD_QualityDetail.Id < MD_QualityNotify.FK_Detail
ALTER TABLE qa.QualityNotify
ADD CONSTRAINT FK_QualityNotify_Detail
FOREIGN KEY (FK_Detail) REFERENCES qa.QualityDetail (Id);