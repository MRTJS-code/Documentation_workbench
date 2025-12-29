
-- =======================================================
-- Author:		Crispin Nicodemus 
-- Create date: 2023-2-16 
-- Description:	stored proc for building [proc_DIM_Empee]
-- =======================================================
CREATE PROCEDURE  [dw].[proc_dim_Empee]
	-- Add the parameters for the stored procedure here
	@p_job int,  
	@p_run int,	
	@p_pack varchar(70)	
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;

BEGIN
/*
We used to get payCode, er.rate STG_GT_EMPEERATES 
- this will be replaced by a separate snowflaked dim of dim_empee
default Paycode is NA and basehour rate = 0 for now
*/

--Merge Staging into Dimension
MERGE INTO dw.DIM_EMPEE t USING staging.STG_GT_EMPEE s
ON t.P_oid_clsno = s.oid_clsno and t.P_oid_instid = s.oid_instid and t.P_SourceSystem = 'Greentree'
WHEN MATCHED AND
	(
	isnull(t.P_empid, '') <> isnull(s.empid, '') or
	isnull(t.P_firstName, '') <> isnull(s.firstname, '') or
	isnull(t.P_surname, '') <> isnull(s.surname, '') or
	isnull(t.P_gender, '') <> isnull(s.gender, '') or
	isnull(t.P_email, '') <> isnull(s.email, '') or
	isnull(t.P_homePhone, '') <> isnull(s.homePhone, '') or
	isnull(t.P_businessPhone, '') <> isnull(s.businessPhone, '') or
	isnull(t.P_mobile, '') <> isnull(s.mobile, '') or
	isnull(t.P_isInactive, 0) <> isnull(s.isInactive, 0) or
	isnull(t.P_fullname, '') <> isnull(s.fullname, '') or
--	isnull(t.P_defaultPayCode, '') <> isnull(s.payCode, '') or
--	isnull(t.P_baseHourRate, '') <> isnull(s.rate, '') or
	isnull(t.P_branchCode, '') <> isnull(s.branchCode, '') or
	isnull(t.P_hrBasis, '') <> isnull(s.hrBasis, '') or
	isnull(t.P_hrType, '') <> isnull(s.hrType, '') or
	isnull(t.P_startDate, '') <> isnull(s.startDate, '') or
	isnull(t.P_nextAnniversaryDate, '') <> isnull(s.nextAnniversaryDate, '') or
	isnull(t.P_terminationDate, '') <> isnull(s.terminationDate, '') or
	isnull(t.P_payGroup, '') <> isnull(s.payGroup, '')
	)
 THEN UPDATE SET
	t.P_empid = s.empid,
	t.P_SourceSystem = 'Greentree',
	t.P_firstName = s.firstname,
	t.P_surname = s.surname,
	t.P_gender = s.gender,
	t.P_email = s.email,
	t.P_homePhone = s.homePhone,
	t.P_businessPhone = s.businessPhone,
	t.P_mobile = s.mobile,
	t.P_isInactive = s.isInactive,
	t.P_fullname = s.fullname,
	t.P_defaultPayCode = 'NA', 
	t.P_baseHourRate = 0, 
	t.P_branchCode = s.branchCode, 
	t.P_hrBasis = s.hrBasis, 
	t.P_hrType = s.hrType, 
	t.P_startDate = s.startDate,
	t.P_nextAnniversaryDate = s.nextAnniversaryDate, 
	t.P_terminationDate = s.terminationDate, 
	t.P_payGroup = s.payGroup
    ,[MD_DATE_CREATED] = getdate()
    ,[MD_DATE_MODIFIED] = getdate()
    ,[MD_JOB_CODE] = @p_job
    ,[MD_RUN_CODE] = @p_run
	,[MD_PACK_NAME] = @p_pack

WHEN NOT MATCHED
  THEN INSERT ( P_oid_clsno, 
				P_oid_instid, 
				P_empid, 
				P_SourceSystem,
				P_firstname, 
				P_surname, 
				P_gender,
				P_email, 
				P_homePhone, 
				P_businessPhone, 
				P_mobile, 
				P_isInactive, 
				P_fullname, 
				P_defaultPayCode, 
	            P_baseHourRate,
				P_branchCode,
				P_hrBasis,
				P_hrType,
				P_startDate,
				P_nextAnniversaryDate,
				P_terminationDate,
				P_payGroup
				,[MD_DATE_CREATED]
				,[MD_DATE_MODIFIED]
				,[MD_JOB_CODE]
				,[MD_RUN_CODE]
				,[MD_PACK_NAME]				
				)
  VALUES (		oid_clsno,
				oid_instid, 
				s.empid, 
				'GreenTree',
				s.firstname, 
				s.surname, 
				s.gender,
				s.email, 
				s.homePhone, 
				s.businessPhone, 
				s.mobile, 
				s.isInactive, 
				s.fullname, 
				'NA', 
				0,
				s.branchCode,
				s.hrBasis,
				s.hrType,
				s.startDate,
				s.nextAnniversaryDate,
				s.terminationDate,
				s.payGroup
				, getdate()
				, getdate()
				, @p_job
				, @p_run
				, @p_pack
				)
;
END
;