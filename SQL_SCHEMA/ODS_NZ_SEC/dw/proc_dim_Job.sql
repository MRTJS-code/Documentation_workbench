
-- ========================================================
-- Author:		Crispin Nicodemus 
-- Create date: 2023-02-17 
-- Modified :   2023-04-27
-- Description:	stored proc for building dim_Job
-- =========================================================
CREATE PROCEDURE [dw].[proc_dim_Job]
	-- Add the parameters for the stored procedure here
	@p_job int,  
	@p_run int,	
	@p_pack varchar(70)	
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;

If(OBJECT_ID('tempdb..#tempJob') Is Not Null)
Begin
 DROP TABLE #tempJob
End

BEGIN	

SELECT DISTINCT 
	a.[jobCode],
	a.[jobName],
	a.[oid_clsno],
	a.[oid_instid],
	a.[oid_parent_clsno],
	a.[oid_parent_instid],
	isnull(b.SK_DIM_ProfitCentre,0) as  [FK_DIM_ProfitCentre],
	--a.[myProfitCentre_clsno],
	--a.[myProfitCentre_instid],
	a.[createDate],
	a.[jobStatus],
	a.[jobClosed],
	a.[jobChargeType],
	a.[jobActivityGroup],
	a.[jobType],
	isnull(c.SK_DIM_Organisation,0) as [FK_DIM_Organisation],
	--a.[myCustomer_clsno],
	--a.[myCustomer_instid],
	a.[salesCodeOverride],
	isnull(d.SK_DIM_JOB_PRICE,0) as [FK_DIM_JOB_PRICE],
--	a.[priceBookCode],
--	a.[ordRate],
--	a.[t15Rate],
	a.[payRate],
	a.[lastDocDate],
	a.[billingGroup],
	a.[orderNumber],
	a.[clientReference],
	a.[jobReference],
	a.[quoteReference],
	a.[invoiceReportFormat],
	a.[jobManager],
	a.[AXCC],
	a.[GroupContract],
	a.[MajorContract],
	a.[StaticGuard]

INTO #tempJob
FROM staging.STG_GT_JOB a
LEFT JOIN dw.DIM_PROFITCENTRE b ON
a.[myProfitCentre_clsno] = b.P_Oid_clsno and
a.[myProfitCentre_instid] = b.P_Oid_instid
LEFT JOIN dw.DIM_ORGANISATION c ON
a.[myCustomer_clsno] = c.P_Oid_clsno and
a.[myCustomer_instid] = c.P_Oid_instid
LEFT JOIN dw.DIM_JOB_PRICE d ON
a.[priceBook_clsno] = d.P_Oid_clsno and
a.[priceBook_instid] = d.P_Oid_instid
;

MERGE INTO dw.DIM_JOB t USING #tempJob s
ON t.P_oid_clsno = s.oid_clsno and t.P_oid_instid = s.oid_instid
WHEN MATCHED AND
	(
	isnull(	t.[P_JobCode],'') <> isnull(s.[jobCode],'') or 
	isnull(	t.[P_JobName],'') <> isnull(s.[jobName],'') or 
	isnull(	t.[P_oid_parent_clsno],0) <> isnull(s.[oid_parent_clsno],0) or 
	isnull(	t.[P_oid_parent_instid],0) <> isnull(s.[oid_parent_instid],0) or 
	isnull(	t.[FK_DIM_ProfitCentre],0) <> isnull(s.[FK_DIM_ProfitCentre],0) or 
	--isnull(t.[myProfitCentre_clsno],'') <> isnull(s.[myProfitCentre_clsno],'') or 
	--isnull(t.[myProfitCentre_instid],'') <> isnull(s.[myProfitCentre_instid],'') or 
	isnull(	t.[P_createDate],'') <> isnull(s.[createDate],'') or 
	isnull(	t.[P_jobStatus],'') <> isnull(s.[jobStatus],'') or 
	isnull(	t.[P_jobClosed],0) <> isnull(s.[jobClosed],0) or 
	isnull(	t.[P_jobChargeType],'') <> isnull(s.[jobChargeType],'') or 
	isnull(	t.[P_jobActivityGroup],'') <> isnull(s.[jobActivityGroup],'') or 
	isnull(	t.[P_jobType],'') <> isnull(s.[jobType],'') or 
	isnull(	t.[FK_DIM_Organisation],0) <> isnull(s.[FK_DIM_Organisation],0) or 
	--isnull(t.[myCustomer_clsno],'') <> isnull(s.[myCustomer_clsno],'') or 
	--isnull(t.[myCustomer_instid],'') <> isnull(s.[myCustomer_instid],'') or 
	isnull(	t.[P_salesCodeOverride],'') <> isnull(s.[salesCodeOverride],'') or 
	isnull(	t.[FK_DIM_Job_Price],0) <> isnull(s.[FK_DIM_Job_Price],0) or
	--isnull(	t.[P_priceBookCode],'') <> isnull(s.[priceBookCode],'') or 
	--isnull(	t.[P_ordRate],0) <> isnull(s.[ordRate],0) or 
	--isnull(	t.[P_t15Rate],0) <> isnull(s.[t15Rate],0) or 
	isnull(	t.[P_payRate],0) <> isnull(s.[payRate],0) or 
	isnull(	t.[P_lastDocDate],'') <> isnull(s.[lastDocDate],'') or 
	isnull(	t.[P_billingGroup],'') <> isnull(s.[billingGroup],'') or 
	isnull(	t.[P_orderNumber],'') <> isnull(s.[orderNumber],'') or 
	isnull(	t.[P_clientReference],'') <> isnull(s.[clientReference],'') or 
	isnull(	t.[P_jobReference],'') <> isnull(s.[jobReference],'') or 
	isnull(	t.[P_quoteReference],'') <> isnull(s.[quoteReference],'') or 
	isnull(	t.[P_invoiceReportFormat],'') <> isnull(s.[invoiceReportFormat],'') or 
	isnull(	t.[P_jobManager],'') <> isnull(s.[jobManager],'') or 
	isnull(t.P_AXCC,'') <> isnull(s.AXCC,'') or 
	isnull(t.P_GroupContract,'') <> isnull(s.GroupContract,'') or 
	isnull(t.P_MajorContract,'') <> isnull(s.MajorContract,'') or 
	isnull(t.P_StaticGuard,0) <> isnull(s.StaticGuard,0) 
	)
	THEN UPDATE SET
	t.[P_JobCode] = s.[jobCode],
	t.[P_JobName] = s.[jobName],
	t.[P_oid_parent_clsno] = s.[oid_parent_clsno],
	t.[P_oid_parent_instid] = s.[oid_parent_instid],
	t.[FK_DIM_ProfitCentre] = s.[FK_DIM_ProfitCentre],
	--isnull(t.[myProfitCentre_clsno] = s.[myProfitCentre_clsno],
	--isnull(t.[myProfitCentre_instid] = s.[myProfitCentre_instid],
	t.[P_createDate] = s.[createDate],
	t.[P_jobStatus] = s.[jobStatus],
	t.[P_jobClosed] = s.[jobClosed],
	t.[P_jobChargeType] = s.[jobChargeType],
	t.[P_jobActivityGroup] = s.[jobActivityGroup],
	t.[P_jobType] = s.[jobType],
	t.[FK_DIM_Organisation] = isnull(s.[FK_DIM_Organisation],0),
	--isnull(t.[myCustomer_clsno] = s.[myCustomer_clsno],
	--isnull(t.[myCustomer_instid] = s.[myCustomer_instid],
	t.[P_salesCodeOverride] = s.[salesCodeOverride],
	t.[FK_DIM_Job_Price] = isnull(s.[FK_DIM_Job_Price],0),
	--t.[P_priceBookCode] = s.[priceBookCode],
	--t.[P_ordRate] = s.[ordRate],
	--t.[P_t15Rate] = s.[t15Rate],
	t.[P_payRate] = s.[payRate],
	t.[P_lastDocDate] = s.[lastDocDate],
	t.[P_billingGroup] = s.[billingGroup],
	t.[P_orderNumber] = s.[orderNumber],
	t.[P_clientReference] = s.[clientReference],
	t.[P_jobReference] = s.[jobReference],
	t.[P_quoteReference] = s.[quoteReference],
	t.[P_invoiceReportFormat] = s.[invoiceReportFormat],
	t.[P_jobManager] = s.[jobManager],
	t.[P_AXCC] = s.[AXCC],
	t.[P_GroupContract] = s.[GroupContract],
	t.[P_MajorContract] = s.[MajorContract],
	t.[P_StaticGuard] = s.[StaticGuard]
    ,[MD_DATE_CREATED] = getdate()
    ,[MD_DATE_MODIFIED] = getdate()
    ,[MD_JOB_CODE] = @p_job
    ,[MD_RUN_CODE] = @p_run
	,[MD_PACK_NAME] = @p_pack
	 
WHEN NOT MATCHED
	THEN INSERT 
	(
       [P_jobCode]
      ,[P_jobName]
      ,[P_oid_clsno]
      ,[P_oid_instid]
      ,[P_oid_parent_clsno]
      ,[P_oid_parent_instid]
      ,[FK_DIM_PROFITCENTRE]
      ,[P_createDate]
      ,[P_jobStatus]
      ,[P_jobClosed]
      ,[P_jobChargeType]
      ,[P_jobActivityGroup]
      ,[P_jobType]
      ,[FK_DIM_ORGANISATION]
      ,[P_salesCodeOverride]
      ,[FK_DIM_Job_Price]
--      ,[P_priceBookCode]
--      ,[P_ordRate]
--      ,[P_t15Rate]
      ,[P_payRate]
      ,[P_lastDocDate]
      ,[P_billingGroup]
      ,[P_orderNumber]
      ,[P_clientReference]
      ,[P_jobReference]
      ,[P_quoteReference]
      ,[P_invoiceReportFormat]
      ,[P_jobManager]
      ,[P_AXCC]
      ,[P_GroupContract]
      ,[P_MajorContract]
      ,[P_StaticGuard]
      ,[MD_DATE_CREATED]
      ,[MD_DATE_MODIFIED]
      ,[MD_JOB_CODE]
      ,[MD_RUN_CODE]
      ,[MD_PACK_NAME]
	)
	VALUES 
	(
      s.[jobCode],
      s.[jobName],
      s.[oid_clsno],
      s.[oid_instid],
      s.[oid_parent_clsno],
      s.[oid_parent_instid],
      s.[FK_DIM_PROFITCENTRE],
      s.[createDate],
      s.[jobStatus],
      s.[jobClosed],
      s.[jobChargeType],
      s.[jobActivityGroup],
      s.[jobType],
      s.[FK_DIM_ORGANISATION],
      s.[salesCodeOverride],
      s.[FK_DIM_JOB_PRICE],
--      s.[priceBookCode],
--      s.[ordRate],
--      s.[t15Rate],
      s.[payRate],
      s.[lastDocDate],
      s.[billingGroup],
      s.[orderNumber],
      s.[clientReference],
      s.[jobReference],
      s.[quoteReference],
      s.[invoiceReportFormat],
      s.[jobManager],
      s.[AXCC],
      s.[GroupContract],
      s.[MajorContract],
      s.[StaticGuard],
	getdate(),
	getdate(),
	@p_job, 
	@p_run,
	@p_pack	
	);

END;
