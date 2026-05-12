CREATE TABLE qa.QualityType (
    Id       int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    qaName   VARCHAR(50) NOT NULL
);
GO
ALTER TABLE qa.QualityType
ADD CONSTRAINT UQ_QualityType_qaName UNIQUE (qaName);