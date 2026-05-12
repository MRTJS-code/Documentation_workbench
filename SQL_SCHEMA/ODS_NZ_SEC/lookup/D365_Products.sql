CREATE TABLE lookup.D365_Products (
	SKProduct varchar(36) PRIMARY KEY,
	ProductCode varchar(10),
	ProductName varchar(50),
	ProductGroup varchar(15),
	ETLModified datetime
)