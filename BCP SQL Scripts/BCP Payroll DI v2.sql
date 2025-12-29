 --Payroll Extract Code
DECLARE					@eventId int = 6349;

--Base Extract
SELECT					'H' [Record Type],
						t.payrollId [ID Number],
						CAST(t.timesheetStart as Date) [Costing Date],
						CASE
							WHEN t.AreaProduct = 'EMS' AND isnull(t.TierRate,0) = 0 AND t.EMSRate >0 THEN 'E1'
							WHEN t.AreaProduct = 'TRAIN' THEN '06'
							WHEN t.AreaProduct = 'NBORD' THEN 'NO'
							ELSE t.payActivityCode 
						END [Hours Code],
						ISNULL(t.lineHours, t.timesheetHours)[Hours Amount],
						CASE
							WHEN t.AreaProduct = 'EMS' AND isnull(t.TierRate,0) = 0 THEN NULL
							WHEN isnull(t.TierRate,0) > 0 THEN t.TierRate
							WHEN t.SiteRate > t.BaseRate THEN t.SiteRate
							ELSE NULL
						END [Hourly Rate],
						CASE t.payActivityCode
							WHEN '01' THEN NULL
							ELSE CAST(t.timesheetStart as Date)
						END [Date From],
						CASE t.payActivityCode
							WHEN '01' THEN NULL
							ELSE CAST(t.timesheetStart as Date)
						END [Date To],
						CASE t.payActivityCode
							WHEN 'AW' THEN 'AL'
							WHEN 'AH' THEN 'AS'
							WHEN '24' THEN 'BV'
							WHEN 'PP' THEN 'PP'
							WHEN '21' THEN 'NM'
							WHEN '20' THEN 'NP'
							WHEN '19' THEN 'NS'
							WHEN 'SP' THEN 'OO'
							WHEN 'TL' THEN 'LL'
							WHEN 'LX' THEN 'NP'
							WHEN 'OL' THEN 'OO'
							WHEN 'ER' THEN 'OS'
							ELSE NULL
						END [Leave Reason],
						CASE
							WHEN t.payActivityCode = '25' OR t.payActivityCode = 'AH' THEN isnull(t.lineHours,t.timesheetHours) / dyLvHrs.totHours
						END [Leave Units],
						NULL [A/D Code],
						NULL [Units],
						NULL [Unit Rate],
						t.CostCentre [Account],
						'D' + CAST(t.Id as varchar(10)) [Labour Costing 3],
						SUBSTRING(t.locationName,5,10) [User Costing 1],
						SUBSTRING(t.areaName,0,10) [User Costing 2],
						NULL [Blank],
						t.BaseRate,
						t.EMSRate,
						t.SiteRate,
						t.TierRate,
						t.branchName,
						t.AreaRateName,
						t.TierRateName
FROM					eda.EXT_DEP_FULL t
LEFT JOIN	(

SELECT					t.payrollId,
						Cast(t.timesheetStart as Date) timesheetDate,
						sum(t.timesheetHours) totHours
FROM					eda.EXT_DEP_FULL t
WHERE					t.MDEventId = @eventId
AND						t.TimeApproved = 1
AND						isnull(t.Exported,0) = 0
AND						t.payActivityCode != 'OD'
AND						t.payCentre IN ('Employee Timesheets', 'Agency Timesheets')
AND 					isnull(t.lineHours,t.timesheetHours) > 0.12
GROUP BY				t.payrollId, Cast(t.timesheetStart as Date) 

			) dyLvHrs	ON t.payrollId = dyLvHrs.payrollId AND Cast(t.timesheetStart as Date) = dyLvHrs.timesheetDate
WHERE					t.MDEventId = @eventId
AND						t.TimeApproved = 1
AND						t.payActivityCode != 'OD'
AND						ISNULL(t.LeaveRuleId,0) NOT IN (11,27,28,29,30,31)
AND						t.payCentre IN ('Employee Timesheets', 'Agency Timesheets')
AND 					isnull(t.lineHours,t.timesheetHours) > 0.12

-- EMS Hours
UNION

SELECT					'H' [Record Type],
						t.payrollId [ID Number],
						CAST(t.timesheetStart as Date) [Costing Date],
						CASE
							WHEN isnull(t.TierRate,0) = 0 AND t.EMSRate > 0 AND t.EMSRate > isnull(t.SiteRate,0) THEN 'E1'
							ELSE '01'
						END[Hours Code],
						t.emsHours [Hours Amount],
						CASE
							WHEN isnull(t.TierRate,0) = 0 AND t.EMSRate > isnull(t.SiteRate,0) THEN NULL
							WHEN isnull(t.TierRate,0) > 0 THEN t.TierRate
							WHEN t.SiteRate > t.BaseRate THEN t.SiteRate
							ELSE NULL
						END [Hourly Rate],
						CASE t.payActivityCode
							WHEN '01' THEN NULL
							ELSE CAST(t.timesheetStart as Date)
						END [Date From],
						CASE t.payActivityCode
							WHEN '01' THEN NULL
							ELSE CAST(t.timesheetStart as Date)
						END [Date To],
						CASE t.payActivityCode
							WHEN 'AW' THEN 'AL'
							WHEN 'AH' THEN 'AS'
							WHEN '24' THEN 'BV'
							WHEN 'PP' THEN 'PP'
							WHEN '21' THEN 'NM'
							WHEN '20' THEN 'NP'
							WHEN '19' THEN 'NS'
							WHEN 'SP' THEN 'OO'
							WHEN 'TL' THEN 'LL'
							WHEN 'LX' THEN 'NP'
							WHEN 'OL' THEN 'OO'
							WHEN 'ER' THEN 'OS'
							ELSE NULL
						END [Leave Reason],
						NULL [Leave Units],
						NULL [A/D Code],
						NULL [Units],
						NULL [Unit Rate],
						SUBSTRING(t.CostCentre,1,4) + '50002' [Account],
						'D' + CAST(t.Id as varchar(10)) [Labour Costing 3],
						SUBSTRING(t.locationName,6,10) [User Costing 1],
						'EMS' [User Costing 2],
						NULL [Blank],
						t.BaseRate,
						t.EMSRate,
						t.SiteRate,
						t.TierRate,
						t.branchName,
						t.AreaRateName,
						t.TierRateName
FROM					eda.EXT_DEP_FULL t
WHERE					t.MDEventId = @eventId
AND						t.TimeApproved = 1
AND						isnull(t.Exported,0) = 0
AND						t.payActivityCode != 'OD'
AND						ISNULL(t.LeaveRuleId,0) NOT IN (11,27,28,29,30,31)
AND						t.payCentre IN ('Employee Timesheets', 'Agency Timesheets')
AND						t.emsHours > 0.12


-- NCR Hours
UNION

SELECT					'H' [Record Type],
						t.payrollId [ID Number],
						CAST(t.timesheetStart as Date) [Costing Date],
						CASE
							WHEN t.AreaProduct = 'TRAIN' THEN '06'
							WHEN t.AreaProduct = 'NBORD' THEN 'NO'
							ELSE t.payActivityCode 
						END [Hours Code],
						t.ncrHours [Hours Amount],
						CASE
							WHEN isnull(r.PayAmount,0) > isnull(t.SiteRate,0) THEN r.PayAmount
							WHEN t.SiteRate > t.BaseRate THEN t.SiteRate
							ELSE NULL
						END [Hourly Rate],
						CASE t.payActivityCode
							WHEN '01' THEN NULL
							ELSE CAST(t.timesheetStart as Date)
						END [Date From],
						CASE t.payActivityCode
							WHEN '01' THEN NULL
							ELSE CAST(t.timesheetStart as Date)
						END [Date To],
						CASE t.payActivityCode
							WHEN 'AW' THEN 'AL'
							WHEN 'AH' THEN 'AS'
							WHEN '24' THEN 'BV'
							WHEN 'PP' THEN 'PP'
							WHEN '21' THEN 'NM'
							WHEN '20' THEN 'NP'
							WHEN '19' THEN 'NS'
							WHEN 'SP' THEN 'OO'
							WHEN 'TL' THEN 'LL'
							WHEN 'LX' THEN 'NP'
							WHEN 'OL' THEN 'OO'
							WHEN 'ER' THEN 'OS'
							ELSE NULL
						END [Leave Reason],
						NULL [Leave Units],
						NULL [A/D Code],
						NULL [Units],
						NULL [Unit Rate],
						SUBSTRING(t.CostCentre,1,4) + '10004' [Account],
						'D' + CAST(t.Id as varchar(10)) [Labour Costing 3],
						SUBSTRING(t.locationName,6,10) [User Costing 1],
						'NCR' [User Costing 2],
						NULL [Blank],
						t.BaseRate,
						t.EMSRate,
						t.SiteRate,
						isnull(r.PayAmount,0) TierRate,
						t.branchName,
						t.AreaRateName,
						t.TierRateName
FROM					eda.EXT_DEP_FULL t
LEFT JOIN				eda.LKP_DEP_ClientTier ct ON t.payrollId = ct.SKClientTier AND ct.FK_TierCard = 723 
							AND t.timesheetStart >= ct.EffectiveFrom AND t.timesheetStart <= isnull(ct.EffectiveTo,t.timesheetStart)
LEFT JOIN				eda.LKP_DEP_RateCard r ON ct.FK_TierCard = r.RateCode AND t.timesheetStart >= r.EffectiveFrom AND t.timesheetStart <= isnull(r.EffectiveTo,t.timesheetStart)
WHERE					t.MDEventId = @eventId
AND						t.TimeApproved = 1
AND						isnull(t.Exported,0) = 0
AND						t.payActivityCode != 'OD'
AND						ISNULL(t.LeaveRuleId,0) NOT IN (11,27,28,29,30,31)
AND						t.payCentre IN ('Employee Timesheets', 'Agency Timesheets')
AND						t.ncrHours > 0.12


-- OD Hours
UNION

SELECT					'H' [Record Type],
						t.payrollId [ID Number],
						CAST(t.timesheetStart as Date) [Costing Date],
						t.payActivityCode [Hours Code],
						t.lineHours [Hours Amount],
						CASE
							WHEN t.AreaProduct = 'EMS' AND isnull(t.TierRate,0) = 0 THEN NULL
							WHEN isnull(t.TierRate,0) > 0 THEN t.TierRate
							WHEN t.SiteRate > t.BaseRate THEN t.SiteRate
							ELSE NULL
						END [Hourly Rate],
						CASE t.payActivityCode
							WHEN '01' THEN NULL
							ELSE CAST(t.timesheetStart as Date)
						END [Date From],
						CASE t.payActivityCode
							WHEN '01' THEN NULL
							ELSE CAST(t.timesheetStart as Date)
						END [Date To],
						CASE t.payActivityCode
							WHEN 'AW' THEN 'AL'
							WHEN 'AH' THEN 'AS'
							WHEN '24' THEN 'BV'
							WHEN 'PP' THEN 'PP'
							WHEN '21' THEN 'NM'
							WHEN '20' THEN 'NP'
							WHEN '19' THEN 'NS'
							WHEN 'SP' THEN 'OO'
							WHEN 'TL' THEN 'LL'
							WHEN 'LX' THEN 'NP'
							WHEN 'OL' THEN 'OO'
							WHEN 'ER' THEN 'OS'
							ELSE NULL
						END [Leave Reason],
						NULL [Leave Units],
						NULL [A/D Code],
						NULL [Units],
						NULL [Unit Rate],
						t.CostCentre [Account],
						'D' + CAST(t.Id as varchar(10)) [Labour Costing 3],
						SUBSTRING(t.locationName,6,10) [User Costing 1],
						'ETU Ot' [User Costing 2],
						NULL [Blank],
						t.BaseRate,
						t.EMSRate,
						t.SiteRate,
						t.TierRate,
						t.branchName,
						t.AreaRateName,
						t.TierRateName
FROM					eda.EXT_DEP_FULL t
WHERE					t.MDEventId = @eventId
AND						t.TimeApproved = 1
AND						isnull(t.Exported,0) = 0
AND						t.payActivityCode = 'OD'
AND						ISNULL(t.LeaveRuleId,0) NOT IN (11,27,28,29,30,31)
AND						t.payCentre IN ('Employee Timesheets', 'Agency Timesheets')
AND						t.lineHours > 0.12

-- EMS OD Hours
UNION

SELECT					'H' [Record Type],
						t.payrollId [ID Number],
						CAST(t.timesheetStart as Date) [Costing Date],
						t.payActivityCode [Hours Code],
						t.emsHours [Hours Amount],
						CASE
							WHEN isnull(t.TierRate,0) = 0 AND t.EMSRate > isnull(t.SiteRate,0) THEN NULL
							WHEN isnull(t.TierRate,0) > 0 THEN t.TierRate
							WHEN t.SiteRate > t.BaseRate THEN t.SiteRate
							ELSE NULL
						END [Hourly Rate],
						CASE t.payActivityCode
							WHEN '01' THEN NULL
							ELSE CAST(t.timesheetStart as Date)
						END [Date From],
						CASE t.payActivityCode
							WHEN '01' THEN NULL
							ELSE CAST(t.timesheetStart as Date)
						END [Date To],
						CASE t.payActivityCode
							WHEN 'AW' THEN 'AL'
							WHEN 'AH' THEN 'AS'
							WHEN '24' THEN 'BV'
							WHEN 'PP' THEN 'PP'
							WHEN '21' THEN 'NM'
							WHEN '20' THEN 'NP'
							WHEN '19' THEN 'NS'
							WHEN 'SP' THEN 'OO'
							WHEN 'TL' THEN 'LL'
							WHEN 'LX' THEN 'NP'
							WHEN 'OL' THEN 'OO'
							WHEN 'ER' THEN 'OS'
							ELSE NULL
						END [Leave Reason],
						NULL [Leave Units],
						NULL [A/D Code],
						NULL [Units],
						NULL [Unit Rate],
						SUBSTRING(t.CostCentre,1,4) + '50002' [Account],
						'D' + CAST(t.Id as varchar(10)) [Labour Costing 3],
						SUBSTRING(t.locationName,6,10) [User Costing 1],
						'ETU Ot EMS' [User Costing 2],
						NULL [Blank],
						t.BaseRate,
						t.EMSRate,
						t.SiteRate,
						t.TierRate,
						t.branchName,
						t.AreaRateName,
						t.TierRateName
FROM					eda.EXT_DEP_FULL t
WHERE					t.MDEventId = @eventId
AND						t.TimeApproved = 1
AND						isnull(t.Exported,0) = 0
AND						t.payActivityCode = 'OD'
AND						ISNULL(t.LeaveRuleId,0) NOT IN (11,27,28,29,30,31)
AND						t.payCentre IN ('Employee Timesheets', 'Agency Timesheets')
AND						t.emsHours > 0.12

-- EMS OD Hours
UNION

SELECT					'H' [Record Type],
						t.payrollId [ID Number],
						CAST(t.timesheetStart as Date) [Costing Date],
						t.payActivityCode [Hours Code],
						t.ncrHours [Hours Amount],
						CASE
							WHEN isnull(r.PayAmount,0) > isnull(t.SiteRate,0) THEN r.PayAmount
							WHEN t.SiteRate > t.BaseRate THEN t.SiteRate
							ELSE NULL
						END [Hourly Rate],
						CASE t.payActivityCode
							WHEN '01' THEN NULL
							ELSE CAST(t.timesheetStart as Date)
						END [Date From],
						CASE t.payActivityCode
							WHEN '01' THEN NULL
							ELSE CAST(t.timesheetStart as Date)
						END [Date To],
						CASE t.payActivityCode
							WHEN 'AW' THEN 'AL'
							WHEN 'AH' THEN 'AS'
							WHEN '24' THEN 'BV'
							WHEN 'PP' THEN 'PP'
							WHEN '21' THEN 'NM'
							WHEN '20' THEN 'NP'
							WHEN '19' THEN 'NS'
							WHEN 'SP' THEN 'OO'
							WHEN 'TL' THEN 'LL'
							WHEN 'LX' THEN 'NP'
							WHEN 'OL' THEN 'OO'
							WHEN 'ER' THEN 'OS'
							ELSE NULL
						END [Leave Reason],
						NULL [Leave Units],
						NULL [A/D Code],
						NULL [Units],
						NULL [Unit Rate],
						SUBSTRING(t.CostCentre,1,4) + '10004' [Account],
						'D' + CAST(t.Id as varchar(10)) [Labour Costing 3],
						SUBSTRING(t.locationName,6,10) [User Costing 1],
						'ETU Ot NCR' [User Costing 2],
						NULL [Blank],
						t.BaseRate,
						t.EMSRate,
						t.SiteRate,
						isnull(r.PayAmount,0) TierRate,
						t.branchName,
						t.AreaRateName,
						t.TierRateName
FROM					eda.EXT_DEP_FULL t
LEFT JOIN				eda.LKP_DEP_ClientTier ct ON t.payrollId = ct.SKClientTier AND ct.FK_TierCard = 723 
							AND t.timesheetStart >= ct.EffectiveFrom AND t.timesheetStart <= isnull(ct.EffectiveTo,t.timesheetStart)
LEFT JOIN				eda.LKP_DEP_RateCard r ON ct.FK_TierCard = r.RateCode AND t.timesheetStart >= r.EffectiveFrom AND t.timesheetStart <= isnull(r.EffectiveTo,t.timesheetStart)
WHERE					t.MDEventId = @eventId
AND						t.TimeApproved = 1
AND						isnull(t.Exported,0) = 0
AND						t.payActivityCode = 'OD'
AND						ISNULL(t.LeaveRuleId,0) NOT IN (11,27,28,29,30,31)
AND						t.payCentre IN ('Employee Timesheets', 'Agency Timesheets')
AND						t.ncrHours > 0.12