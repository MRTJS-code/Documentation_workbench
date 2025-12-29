CREATE TABLE qa.QualityHeader (
    Id              bigint IDENTITY(1,1) NOT NULL PRIMARY KEY,
    sourceSystem    VARCHAR(50) NOT NULL,
    objectId        bigint  NOT NULL,
    objectTable     VARCHAR(100) NOT NULL, 
    sourceUrl       VARCHAR(1000) NULL 
);