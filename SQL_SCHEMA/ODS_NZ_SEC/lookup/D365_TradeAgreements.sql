CREATE TABLE lookup.D365_TradeAgreements (
	SKTradeAgreement bigint PRIMARY KEY,
	SKProduct varchar(36),
	SKCustomer varchar(36),
	AgreeAmount float,
	AgreeFrom datetime,
	AgreeTo datetime,
	ETLModified datetime
)