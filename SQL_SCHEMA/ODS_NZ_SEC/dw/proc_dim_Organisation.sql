
-- ========================================================
-- Author:		Crispin Nicodemus 
-- Create date: 2023-02-17 
-- Description:	stored proc for building dim_Organisation
-- =========================================================
CREATE PROCEDURE [dw].[proc_dim_Organisation]
	-- Add the parameters for the stored procedure here
	@p_job int,  
	@p_run int,	
	@p_pack varchar(70)	
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;

BEGIN
MERGE INTO dw.DIM_ORGANISATION t USING staging.STG_GT_ORGANISATION s
ON t.P_oid_clsno = s.oid_clsno and t.P_oid_instid = s.oid_instid

WHEN NOT MATCHED
	THEN INSERT 
	(
	P_oid_clsno, 
	P_oid_instid, 	
	[P_Code],
	[P_Name],
	[P_Status],
	P_OrgGroup,
	P_PayTerm,
	[P_Type],
	[P_Address1],
	[P_Address2],
	[P_Address3],
	[P_Suburb],
	[P_City],
	[P_PostCode],
	[P_PrimaryEmail],
	[P_PrimaryPhone],
	[P_PrimaryMobile],
	[P_PrimaryContact],
	[P_CustWebsite],
	[P_ReceiptType],
	[P_PoRequired],
	[P_InvoiceEmail],
	[P_StatementEmail],
	MD_DATE_CREATED,
	MD_DATE_MODIFIED,
	MD_JOB_CODE, 
	MD_RUN_CODE,
	MD_PACK_NAME
  ) 
	VALUES 
	(
	s.oid_clsno, 
	s.oid_instid, 	    
	s.[code],
	s.[name],
	s.[status],
	s.[group],
	s.payTerm,
	s.[type],
	s.[address1] ,
	s.[address2],
	s.[address3],
	s.[suburb],
	s.[city],
	s.[postCode],
	s.[primaryEmail],
	s.[primaryPhone],
	s.[primaryMobile],
	s.[primaryContact],
	s.[custWebsite],
	s.[receiptType],
	s.[poRequired],
	s.[invoiceEmail],
	s.[statementEmail],
	getdate(),
	getdate(),
	@p_job, 
	@p_run,
	@p_pack	
	)

WHEN MATCHED AND 
	(
	isnull(t.P_Code,'') <> isnull(s.code,'') or
	isnull(t.[P_name],'') <> isnull(s.[name],'') or
	isnull(t.[P_status],'') <> isnull(s.[status],'') or
	isnull(t.P_OrgGroup,'') <> isnull(s.[group],'') or
	isnull(t.P_PayTerm,'') <> isnull(s.payTerm,'') or
	isnull(t.[P_Type],'') <> isnull(s.[type],'') or
	isnull(t.[P_Address1],'') <> isnull(s.[address1],'') or
	isnull(t.[P_Address2],'') <> isnull(s.[address2],'') or
	isnull(t.[P_Address3],'') <> isnull(s.[address3],'') or
	isnull(t.[P_Suburb],'') <> isnull(s.[suburb],'') or
	isnull(t.[P_City],'') <> isnull(s.[city],'') or
	isnull(t.[P_PostCode],'') <> isnull(s.[postCode],'') or
	isnull(t.[P_PrimaryEmail],'') <> isnull(s.[primaryEmail],'') or
	isnull(t.[P_PrimaryPhone],'') <> isnull(s.[primaryPhone],'') or
	isnull(t.[P_PrimaryMobile],'') <> isnull(s.[primaryMobile],'') or
	isnull(t.[P_PrimaryContact],'') <> isnull(s.[primaryContact],'') or
	isnull(t.[P_CustWebsite],'') <> isnull(s.[custWebsite],'') or
	isnull(t.[P_ReceiptType],'') <> isnull(s.[receiptType],'') or
	isnull(t.[P_PoRequired],0) <> isnull(s.[poRequired],0) or
	isnull(t.[P_InvoiceEmail],'') <> isnull(s.[invoiceEmail],'') or
	isnull(t.[P_StatementEmail],'') <> isnull(s.[statementEmail],'')
	)
 THEN UPDATE SET

	t.P_Code = s.code,
	t.[P_name] = s.[name],
	t.[P_status] = s.[status],
	t.P_OrgGroup = s.[group],
	t.P_PayTerm = s.payTerm,
	t.[P_Type] = s.[type],
	t.[P_Address1] = s.[address1] ,
	t.[P_Address2] = s.[address2],
	t.[P_Address3] = s.[address3],
	t.[P_Suburb] = s.[suburb],
	t.[P_City] = s.[city],
	t.[P_PostCode] = s.[postCode],
	t.[P_PrimaryEmail] = s.[primaryEmail],
	t.[P_PrimaryPhone] = s.[primaryPhone],
	t.[P_PrimaryMobile] = s.[primaryMobile],
	t.[P_PrimaryContact] = s.[primaryContact],
	t.[P_CustWebsite] = s.[custWebsite],
	t.[P_ReceiptType] = s.[receiptType],
	t.[P_PoRequired] = s.[poRequired],
	t.[P_InvoiceEmail] = s.[invoiceEmail],
	t.[P_StatementEmail] = s.[statementEmail]
	,[MD_DATE_CREATED] = getdate()
    ,[MD_DATE_MODIFIED] = getdate()
    ,[MD_JOB_CODE] = @p_job
    ,[MD_RUN_CODE] = @p_run
	,[MD_PACK_NAME] = @p_pack
;

END
;