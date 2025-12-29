USE ODS_NZ_SEC
GO

/** Paid until 2025-08-17, Invoiced until 2025-08-10 **/
DECLARE					@fromDate date = '2025-08-17'; --greater than or equal to note: paid historic from 1/11/24, billed historic from 1/2/25
DECLARE					@toDate date = '2025-08-25'; -- less than

--Standard Code
WITH qry AS (									-- Leave commented out unless checking invoiced flag
SELECT					t.Id TimesheetId,
						ea.payrollId,
						t.AreaId,
						e.displayName,
						coalesce(lr.name, l.Name + ' | ' + a.Name) leaveAreaName,
						t.timesheetStart,
						t.timesheetEnd,
						t.timesheetHours,
						t.TimeApproved,
						t.PayApproved,
						t.Exported,
						t.Paid,
						t.Invoiced,
						t.PayCycleId,
						ep.PeriodId,
						CASE 
							WHEN CHARINDEX('|',a.PayrollExportName) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(a.PayrollExportName), '|', '.'), 1))
							ELSE a.PayrollExportName
						END jobCode,
						CASE 
							WHEN CHARINDEX('|',a.PayrollExportName) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(a.PayrollExportName), '|', '.'), 2))
							ELSE NULL
						END activityCode,
						ea.contractName,
						pc.Name payCentre,
						pr.hourlyRate payRate,
						pr.payExportCode
						
FROM					staging.FCT_DEP_TIMESHEET t
LEFT JOIN				staging.DEP_Employee e ON t.EmployeeId = e.employeeId
LEFT JOIN				staging.DEP_EmployeeAgreement ea ON t.EmployeeId = ea.employeeId AND ea.isActive = 1
LEFT JOIN				staging.DEP_Location pc ON ea.payCentreId = pc.Id
LEFT JOIN				staging.DEP_Payrules pr ON ea.payRuleId = pr.payRuleId
LEFT JOIN				staging.DEP_LeaveRules lr ON t.LeaveRuleId = lr.Id
LEFT JOIN				staging.DEP_Area a ON t.AreaId = a.Id
LEFT JOIN				staging.DEP_Location l ON a.LocationId = l.Id
LEFT JOIN				staging.DEP_EmployeePaycycle ep ON t.PayCycleId = ep.Id
WHERE					t.timesheetStart >= @fromDate
AND						t.timesheetStart < @toDate

------ Manual Reprocess
--AND						e.employeeId IN (296,419,2979,2978)
--AND						isnull(t.PayApproved,0) = 1
--AND						isnull(t.Discarded,0) = 0

----Pay Cycle Check
--AND						isnull(t.Discarded,0) = 0
--AND						isnull(t.TimeApproved,0) = 1
--AND						isnull(ep.PeriodId,0) = 0

---- Approved not extrated check
--AND							isnull(t.Discarded,0) = 0
--AND							isnull(t.TimeApproved,0) = 1 -- comment out this to pick up any remaining timesheets missing approvals
--AND							isnull(t.Exported,0) = 0
--AND							pc.name IN ('Employee Timesheets', 'Agency Timesheets')  -- add this to only check contractor/internal groups
------AND							isnull(lr.PaidLeave,1) = 0  -- add this to include/exclude unpaid leave
------AND							t.Id != 247283

---- Exported not paid
--AND							isnull(t.Discarded,0) = 0
--AND							isnull(t.Exported,0) = 1
--AND							isnull(t.Paid,0) = 0
----AND							pc.name NOT IN ('Contractor Timesheets', 'Internal Timesheets')  -- add this to only check contractor/internal groups

---- Historic not exported / paid
--AND							isnull(t.Discarded,0) = 0
--AND							isnull(t.Paid,0) = 0
--ORDER BY					t.timesheetStart

---- Historic not exported to Invoice
AND							isnull(t.Discarded,0) = 0
AND							isnull(t.Invoiced,0) = 0)
SELECT						qry.*, tr.FK_ProductCode ClientTierProduct
FROM						qry
LEFT JOIN					lookup.DEP_WorkAreas wa ON qry.AreaId = wa.PK_WorkAreaID
								AND qry.timesheetStart >= wa.EffectiveFrom AND qry.timesheetStart < isnull(wa.EffectiveTo,dateadd(day,1,qry.timesheetStart))
LEFT JOIN					lookup.DEP_ClientTier dct ON qry.payrollId = cast(dct.FK_SecurityGuard as nvarchar) AND wa.FK_RateCard = dct.FK_SiteCard
								AND qry.timesheetStart >= dct.EffectiveFrom AND qry.timesheetStart < isnull(dct.EffectiveTo,dateadd(day,1,qry.timesheetStart))
LEFT JOIN					lookup.DEP_RateCard tr ON dct.FK_TierCard = tr.RateCode
								AND qry.timesheetStart >= tr.EffectiveFrom AND qry.timesheetStart < isnull(tr.EffectiveTo,dateadd(day,1,qry.timesheetStart))
WHERE						(isnull(tr.FK_ProductCode,qry.activityCode) like 'SG%' OR isnull(dct.FK_ProductCode,qry.activityCode) like 'RBSG%')
AND							qry.activityCode NOT IN ('OVH','FIXED','NBORD','TRAIN')
ORDER BY					qry.timesheetStart


---- Reprocess if employee has a contract.  Rerun Employee setup checks if contract is missing
--SELECT					'(@eventId,' + qry.EmployeeId + ',' + isnull(qry.LocationId,'NULL') + ',' + qry.agreementId + ',' + qry.timesheets + '),' qryValues
--FROM (
--SELECT					cast(t.EmployeeId as nvarchar) EmployeeId,
--						cast(a.LocationId as nvarchar) LocationId,
--						cast(ea.agreementId as nvarchar) agreementId,
--						'''{"TimesheetId":[' + STRING_AGG(t.Id,',') + ']}''' timesheets
--FROM					staging.FCT_DEP_TIMESHEET t
--LEFT JOIN				staging.DEP_Area a ON t.AreaId = a.Id
--LEFT JOIN				staging.DEP_EmployeeAgreement ea ON t.EmployeeId = ea.employeeId AND ea.isActive = 1
--WHERE					t.timesheetStart >= @fromDate
--AND						t.timesheetStart < @toDate
--AND						isnull(t.Discarded,0) = 0
--AND						isnull(t.TimeApproved,0) = 1
--AND						isnull(t.PayApproved,0) = 0
----AND						ea.employeeId IN (296,419,2979,2978)
--GROUP BY				t.EmployeeId, a.LocationId, ea.agreementId
--						) qry

----Timeshet Paid Extract
--SELECT					ep.PeriodId,
--						t.Id timesheetId
--FROM					staging.FCT_DEP_TIMESHEET t
----LEFT JOIN				staging.DEP_Employee e ON t.EmployeeId = e.employeeId
--LEFT JOIN				staging.DEP_EmployeeAgreement ea ON t.EmployeeId = ea.employeeId AND ea.isActive = 1
--LEFT JOIN				staging.DEP_Location pc ON ea.payCentreId = pc.Id
----LEFT JOIN				staging.DEP_Payrules pr ON ea.payRuleId = pr.payRuleId
--LEFT JOIN				staging.DEP_LeaveRules lr ON t.LeaveRuleId = lr.Id
----LEFT JOIN				staging.DEP_Area a ON t.AreaId = a.Id
----LEFT JOIN				staging.DEP_Location l ON a.LocationId = l.Id
--LEFT JOIN				staging.DEP_EmployeePaycycle ep ON t.PayCycleId = ep.Id
--WHERE					t.timesheetStart >= @fromDate
--AND						t.timesheetStart < @toDate
--AND						isnull(t.Discarded,0) = 0
--AND						isnull(t.Exported,0) = 1 -- 1 or 0 with time approval = 0
----AND						isnull(t.TimeApproved,1) = 1 -- include this with exported = 0 to pick up non payroll timesheets to lock
--AND						isnull(t.Paid,0) = 0
----AND						isnull(lr.PaidLeave,1) = 0  -- add this to include/exclude unpaid leave
----AND						pc.name NOT IN ('Contractor Timesheets', 'Internal Timesheets')  -- add this to only check contractor/internal groups
----AND						t.Id != 247283
--ORDER BY				ep.PeriodId, t.Id


---- Roster detail check
--SELECT					a.Name areaName, l.Name locationName, r.*
--FROM					staging.FCT_DEP_ROSTER r
--LEFT JOIN				staging.DEP_Area a ON r.AreaId = a.Id
--LEFT JOIN				staging.DEP_Location l on a.LocationId = l.Id
--WHERE					r.Id IN (174138,276396)

--SELECT * FROM staging.DEP_TIMESHEET t WHERE t.Id = 204731

--WITH DUPCHECK as (
--SELECT t.Id, ROW_NUMBER() OVER (PARTITION BY t.Id ORDER BY t.Id) rowNum
--FROM staging.DEP_Timesheet t)
--DELETE FROM DUPCHECK WHERE rowNum > 1


---- Lookup Table Build - Site Rate
--SELECT					isnull(wa.PK_WorkAreaID, a.PK_DeputyId) AreaId,
--						l.PK_SystemId LocationId,
--						isnull(wa.WorkAreaName, a.AreaName) AreaName,
--						l.LocName LocationName,
--						a.AreaCostCentre,
--						wa.FK_CostCentre LkpCostCentre,
--						a.AreaProduct,
--						wa.FK_ProductCode LkpProduct,
--						l.LocDebtorCode,
--						ll.FK_DebtorCode LkpDebtorCode,
--						wa.PrecedaPayCode,
--						wa.PayRate SitePayRate,
--						wa.EffectiveFrom,
--						wa.EffectiveTo,
--						wa.LastRefreshed
--FROM					lookup.DEP_WorkAreas wa
--FULL OUTER JOIN			dw.DIM_Area a ON wa.PK_WorkAreaID = a.PK_DeputyId AND a.AreaActive = 1
--LEFT JOIN				dw.DIM_CLIENTLOCATION l ON l.PK_SourceSystem = 'Deputy' AND (wa.FK_LocationCode = l.PK_SystemId OR a.FK_Location = l.SK_DIM_CLIENTLOCATION) AND l.LocActive = 1
--LEFT JOIN				lookup.DEP_Location ll ON l.PK_SystemId = ll.PK_LocationCode
--WHERE					l.SK_DIM_CLIENTLOCATION is not null


---- Lookup Table Build - Client Tier Rates
--SELECT					ct.FK_WorkAreaID AreaId,
--						ct.FK_ProductCode ClientTierProduct,
--						ct.FK_SecurityGuardID PayrollId,
--						a.AreaName,
--						l.LocName LocationName,
--						e.DisplayName employeeName,
--						e.TerminationDate,
--						ct.PrecedaPayCode,
--						ct.TierPayRate,
--						ct.EffectiveFrom,
--						ct.EffectiveTo,
--						ct.LastRefreshed
--FROM					lookup.DEP_ClientTiers ct
--LEFT JOIN				dw.DIM_AREA a ON ct.FK_WorkAreaID = a.PK_DeputyId AND a.AreaActive = 1
--LEFT JOIN				dw.DIM_CLIENTLOCATION l ON a.FK_Location = l.SK_DIM_CLIENTLOCATION AND l.LocActive = 1 AND l.PK_SourceSystem = 'Deputy'
--LEFT JOIN				staging.DEP_EmployeeAgreement ea ON cast(ct.FK_SecurityGuardID as nvarchar) = ea.payrollId AND ea.isActive = 1	
--LEFT JOIN				staging.DEP_Employee e ON ea.employeeId = e.employeeId
--WHERE					e.terminationDate is NULL
--ORDER BY				ea.payrollId


