/** Development to Do
 ** Add Roster source with leave rule ID
 ** Add Leave source with area ID
 **/

DECLARE @eventId int = 6337

SELECT * FROM(
SELECT t.Id
      ,t.AgreementId
      ,t.EmployeeId
      ,e.payrollId
      ,t.LeaveRuleId
      ,t.LeaveLineId
      ,t.PayCycleId
      ,t.AreaId
      ,e.displayName
      ,e.firstName
      ,e.lastName
	  ,e.employer
      ,pc.Name payCentre
      ,e.payPeriod
      ,t.JobCode areaExportCode
	  ,CAST(CASE 
		WHEN CHARINDEX('|',t.JobCode) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(t.JobCode), '|', '.'), 1))
		ELSE t.JobCode
	   END as varchar(50)) CostCentre
	  ,CAST(CASE 
		WHEN CHARINDEX('|',t.JobCode) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(t.JobCode), '|', '.'), 2))
		ELSE NULL
	   END as varchar(50)) AreaProduct
	  ,sr.RateName AreaRateName
      ,t.AreaName
      ,lo.Name [locationName]
      ,b.name branchName
      ,t.[timesheetStart]
      ,t.[timesheetEnd]
      ,t.[timesheetHours]
      ,t.[timesheetCost]
      ,t.[sourceType]
      ,t.[sourceStart]
      ,t.[sourceEnd]
      ,t.[sourceHours]
      ,t.[sourceCost]
      ,t.[InProgress]
      ,t.[RealTime]
      ,t.[AutoProcessed]
      ,t.[PayApproved]
      ,t.[TimeApproved]
      ,t.[AutoPayApproved]
      ,t.[AutoTimeApproved]
      ,t.[Exported]
	  ,t.Invoiced
      ,t.[emsminutes]
      ,t.[ncrminutes]
      ,t.[ponumber]
      ,t.[ritm]
      ,r.PurchaseOrder [sourcePO]
      ,r.RITM [sorceRITM]
      ,l.Cost [lineCost]
	  ,CAST(CASE
		WHEN t.LeaveRuleId is not NULL THEN  CASE WHEN CHARINDEX('|',lr.PayrollCategory) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(lr.PayrollCategory), '|', '.'), 1)) ELSE lr.PayrollCategory END
		ELSE isnull(pr.PayActivityCode, '01')
	   END AS varchar(50)) PayActivityCode
	  ,CASE
		WHEN t.LeaveRuleId is not NULL THEN lr.Name
		ELSE pr.PayTitle
	   END PayTitle
      ,round((isnull(l.Hours,t.timesheetHours) - (round(isnull(t.emsminutes,0)/60*4,0)/4) - round(isnull(t.ncrminutes,0)/60*4,0)/4)*4,0)/4 [lineHours]
	  ,round(isnull(t.emsminutes,0)/60*4,0)/4 emsHours
	  ,round(isnull(t.ncrminutes,0)/60*4,0)/4 ncrHours
      ,l.Overridden [Overridden]
      ,l.OverrideComment [OverrideComment]
      ,pe.P_Base_Rate BaseRate
	  ,pe.P_EMS_Rate EMSRate
	  ,sr.PayAmount SiteRate
	  ,ctr.PayAmount TierRate
	  ,ctr.FK_ProductCode TierProductCode
	  ,ctr.RateName TierRateName
      ,NULL [phHours]
      ,NULL [altCredit]
      ,NULL [phRef]
      ,@eventId [MDEventId]

FROM			eda.STG_DEPTIMESHEET t
LEFT JOIN		eda.STG_DEP_ROSTER r on t.RosterId = r.RosterId
LEFT JOIN		eda.STG_DEP_TIMESHEETLINE l on t.id = l.TimesheetId
LEFT JOIN		eda.STG_DEP_PAYRULES pr ON l.PayRuleId = pr.Id
LEFT JOIN		eda.STG_DEP_LEAVERULE lr ON t.LeaveRuleId = lr.Id
LEFT JOIN		eda.STG_DEP_EMPLOYEE e ON t.EmployeeId = e.employeeId
LEFT JOIN		sen.LKP_EMPLOYEE pe ON e.payrollId = pe.PK_PR_ID_Number
LEFT JOIN		eda.STG_DEP_LOCATION pc on e.payPoint = pc.Id
LEFT JOIN		eda.STG_DEP_LOCATION lo on t.LocationId = lo.Id
LEFT JOIN		eda.STG_DEP_LOCATION b ON lo.ParentId = b.Id
LEFT JOIN		(

SELECT			a.PK_WorkAreaID, r.PayAmount, r.RateName, r.EffectiveFrom, r.EffectiveTo, r.RateCode
FROM			eda.LKP_DEP_RateCard r
LEFT JOIN		eda.LKP_DEP_WorkArea a ON a.FK_RateCard = r.RateCode

				) sr ON t.AreaId = sr.PK_WorkAreaID AND t.timesheetStart >= sr.EffectiveFrom AND t.timesheetStart < isnull(dateadd(DAY,1,sr.EffectiveTo),dateadd(minute,1,t.timesheetStart))
LEFT JOIN		(

SELECT			t.FK_SiteCard, t.FK_SecurityGuard,r.RateName , r.PayAmount, t.FK_ProductCode ,r.EffectiveFrom, r.EffectiveTo
FROM			eda.LKP_DEP_ClientTier t
LEFT JOIN		eda.LKP_DEP_RateCard r ON t.FK_TierCard = r.RateCode

				) ctr ON sr.RateCode = ctr.FK_SiteCard AND e.payrollId = CAST(ctr.FK_SecurityGuard as nvarchar) AND t.timesheetStart >= ctr.EffectiveFrom AND t.timesheetStart < isnull(dateadd(DAY,1,ctr.EffectiveTo),dateadd(minute,1,t.timesheetStart))
--WHERE			round((isnull(l.Hours,t.timesheetHours) - (round(isnull(t.emsminutes,0)/60*4,0)/4) - round(isnull(t.ncrminutes,0)/60*4,0)/4)*4,0)/4 < 0	
--WHERE			sr.RateCode = 348
--WHERE			e.payrollId = '500000'
--WHERE			sr.RateCode is NULL AND t.sourceType != 'Leave'
--WHERE			ctr.FK_SecurityGuard is NOT NULL
WHERE			isnull(pr.PayActivityCode, '01') != 'OD'  -- NOT IN when multiple pay line types exist

UNION

SELECT t.Id
      ,t.AgreementId
      ,t.EmployeeId
      ,e.payrollId
      ,t.LeaveRuleId
      ,t.LeaveLineId
      ,t.PayCycleId
      ,t.AreaId
      ,e.displayName
      ,e.firstName
      ,e.lastName
	  ,e.employer
      ,pc.Name payCentre
      ,e.payPeriod
      ,t.JobCode areaExportCode
	  ,CAST(CASE 
		WHEN CHARINDEX('|',t.JobCode) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(t.JobCode), '|', '.'), 1))
		ELSE t.JobCode
	   END as varchar(50)) CostCentre
	  ,CAST(CASE 
		WHEN CHARINDEX('|',t.JobCode) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(t.JobCode), '|', '.'), 2))
		ELSE NULL
	   END as varchar(50)) AreaProduct
	  ,sr.RateName AreaRateName
      ,t.AreaName
      ,lo.Name [locationName]
      ,b.name branchName
      ,t.[timesheetStart]
      ,t.[timesheetEnd]
      ,l.Hours timesheetHours
      ,t.[timesheetCost]
      ,t.[sourceType]
      ,t.[sourceStart]
      ,t.[sourceEnd]
      ,t.[sourceHours]
      ,t.[sourceCost]
      ,t.[InProgress]
      ,t.[RealTime]
      ,t.[AutoProcessed]
      ,t.[PayApproved]
      ,t.[TimeApproved]
      ,t.[AutoPayApproved]
      ,t.[AutoTimeApproved]
      ,t.[Exported]
	  ,t.Invoiced
      ,t.[emsminutes]
      ,t.[ncrminutes]
      ,t.[ponumber]
      ,t.[ritm]
      ,r.PurchaseOrder [sourcePO]
      ,r.RITM [sorceRITM]
      ,l.Cost [lineCost]
	  ,CAST(CASE
		WHEN t.LeaveRuleId is not NULL THEN  CASE WHEN CHARINDEX('|',lr.PayrollCategory) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(lr.PayrollCategory), '|', '.'), 1)) ELSE lr.PayrollCategory END
		ELSE isnull(pr.PayActivityCode, '01')
	   END AS varchar(50)) PayActivityCode
	  ,CASE
		WHEN t.LeaveRuleId is not NULL THEN lr.Name
		ELSE pr.PayTitle
	   END PayTitle
      ,round(isnull(l.Hours,t.timesheetHours)*4,0)/4 [lineHours]
	  ,round(isnull(t.emsminutes,0)/60*4,0)/4 emsHours
	  ,round(isnull(t.ncrminutes,0)/60*4,0)/4 ncrHours
      ,l.Overridden [Overridden]
      ,l.OverrideComment [OverrideComment]
      ,pe.P_Base_Rate BaseRate
	  ,pe.P_EMS_Rate EMSRate
	  ,sr.PayAmount SiteRate
	  ,ctr.PayAmount TierRate
	  ,ctr.FK_ProductCode TierProductCode
	  ,ctr.RateName TierRateName
      ,NULL [phHours]
      ,NULL [altCredit]
      ,NULL [phRef]
      ,@eventId [MDEventId]

FROM			eda.STG_DEPTIMESHEET t
LEFT JOIN		eda.STG_DEP_ROSTER r on t.RosterId = r.RosterId
LEFT JOIN		eda.STG_DEP_TIMESHEETLINE l on t.id = l.TimesheetId
LEFT JOIN		eda.STG_DEP_PAYRULES pr ON l.PayRuleId = pr.Id
LEFT JOIN		eda.STG_DEP_LEAVERULE lr ON t.LeaveRuleId = lr.Id
LEFT JOIN		eda.STG_DEP_EMPLOYEE e ON t.EmployeeId = e.employeeId
LEFT JOIN		sen.LKP_EMPLOYEE pe ON e.payrollId = pe.PK_PR_ID_Number
LEFT JOIN		eda.STG_DEP_LOCATION pc on e.payPoint = pc.Id
LEFT JOIN		eda.STG_DEP_LOCATION lo on t.LocationId = lo.Id
LEFT JOIN		eda.STG_DEP_LOCATION b ON lo.ParentId = b.Id
LEFT JOIN		(

SELECT			a.PK_WorkAreaID, r.PayAmount, r.RateName, r.EffectiveFrom, r.EffectiveTo, r.RateCode
FROM			eda.LKP_DEP_RateCard r
LEFT JOIN		eda.LKP_DEP_WorkArea a ON a.FK_RateCard = r.RateCode

				) sr ON t.AreaId = sr.PK_WorkAreaID AND t.timesheetStart >= sr.EffectiveFrom AND t.timesheetStart < isnull(dateadd(DAY,1,sr.EffectiveTo),dateadd(minute,1,t.timesheetStart))
LEFT JOIN		(

SELECT			t.FK_SiteCard, t.FK_SecurityGuard, r.PayAmount, t.FK_ProductCode, r.RateName ,r.EffectiveFrom, r.EffectiveTo
FROM			eda.LKP_DEP_ClientTier t
LEFT JOIN		eda.LKP_DEP_RateCard r ON t.FK_TierCard = r.RateCode

				) ctr ON sr.RateCode = ctr.FK_SiteCard AND e.payrollId = CAST(ctr.FK_SecurityGuard as nvarchar) AND t.timesheetStart >= ctr.EffectiveFrom AND t.timesheetStart < isnull(dateadd(DAY,1,ctr.EffectiveTo),dateadd(minute,1,t.timesheetStart))
WHERE			pr.PayActivityCode = 'OD'
--ORDER BY		e.payrollId
)				qry
WHERE			qry.Id = 250093
