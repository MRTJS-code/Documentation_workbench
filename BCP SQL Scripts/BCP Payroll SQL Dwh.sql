/* Handy Case code to split text fields by pipe
CASE 
							WHEN CHARINDEX('|',a.PayrollExportName) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(a.PayrollExportName), '|', '.'), 1))
							ELSE a.PayrollExportName
						END jobCode,
						CASE 
							WHEN CHARINDEX('|',a.PayrollExportName) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(a.PayrollExportName), '|', '.'), 2))
							ELSE NULL
						END activityCode
*/

-- Employee Base Rates
SELECT					e.PK_PR_ID_Number idNumber,
						e.P_First_Name + ' ' + e.P_Surname fullName,
						e.P_Personal_Email personalEmail,
						e.P_PR_Termination_Date termDate,
						ep.P_Base_Hours baseHrs,
						e.P_Region region,
						ep.P_Pay_Frequency payFreq,
						ep.P_Base_Rate payRate1,
						ep.P_EMS_Rate payRate4
FROM					dw.DIM_EMPLOYEE e
LEFT JOIN				dw.DIM_EMPLOYEE_PAY ep ON e.SK_DIM_EMPLOYEE = ep.FK_DIM_EMPLOYEE
WHERE					e.PK_DW_Source_System = 'Preceda'

--Site Rates
SELECT PK_WorkAreaID, FK_CostCentre, FK_ProductCode, FK_QualityCheck, PayRate, PrecedaPayCode,EffectiveFrom,EffectiveTo,MD_ModifiedDate FROM lookup.DEP_WorkAreas

--Client Tier Rates
SELECT * FROM lookup.DEP_ClientTiers

-- Deputy Employee
SELECT					e.employeeId,
						ea.payrollId,
						e.firstName,
						e.lastName,
						e.displayName,
						db.Name employeeBranch,
						dr.Name employeeRegion,
						ebl.employer
FROM					staging.DEP_Employee e
LEFT JOIN				staging.DEP_EmployeeAgreement ea ON e.employeeId = ea.employeeId
LEFT JOIN				staging.DEP_EmployeeBranchLocation ebl on e.employeeId = ebl.Id
LEFT JOIN				staging.DEP_Location db ON ebl.Company = db.Id
LEFT JOIN				staging.DEP_Location dr ON db.ParentId = dr.Id
WHERE					ea.isActive = 1
--WHERE					e.employeeId = 72
ORDER BY				e.employeeId

-- Deputy Area
SELECT					qry.*, c.CostCentreName
FROM (
SELECT					a.Id AreaId,
						CASE 
							WHEN CHARINDEX('|',a.PayrollExportName) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(a.PayrollExportName), '|', '.'), 1))
							ELSE a.PayrollExportName
						END DeputyCostCentre,
						a.Name AreaName,
						l.Name LocationName,
						lb.Name BranchName,
						lr.Name RegionName
FROM					staging.DEP_Area a
LEFT JOIN				staging.DEP_Location l ON a.LocationId = l.Id
LEFT JOIN				staging.DEP_Location lb ON l.ParentId = lb.Id
LEFT JOIN				staging.DEP_Location lr ON lb.ParentId = lr.Id
						) qry
LEFT JOIN				lookup.D365_CostCentres c on qry.DeputyCostCentre = Cast(c.CostCentreCode as nvarchar)

-- Leave Roster Tracker
SELECT					t.*, r.AreaId
FROM					lookup.DEP_LeaveCostTracker t
INNER JOIN				staging.FCT_DEP_ROSTER r ON t.ROSTER_ID = r.Id

-- Clear Leave Roster Tracker data no longer required
DELETE					t
FROM					lookup.DEP_LeaveCostTracker t
LEFT JOIN				staging.FCT_DEP_LEAVELINE l ON t.LEAVE_ID = l.Id
WHERE					l.Id is NULL
OR						l.LeaveDate < '2025-08-11'

-- Leave History Tracker
DECLARE					@effectiveDate date = '2025-08-18'

SELECT					ea.payrollId,
						datename(dw,r.RosterDate) wkDay,
						r.AreaId,
						count(r.Id) rosterCount
FROM					staging.FCT_DEP_ROSTER r
LEFT JOIN				staging.DEP_EmployeeAgreement ea ON r.EmployeeId = ea.employeeId
WHERE					r.RosterDate >= DATEADD(Week,-13,@effectiveDate)
AND						r.RosterDate < @effectiveDate
AND						ea.isActive = 1
AND						ea.payrollId is NOT NULL
GROUP BY				ea.payrollId,
						datename(dw,r.RosterDate),
						r.AreaId
ORDER BY				ea.payrollId,
						datename(dw,r.RosterDate),
						count(r.Id) DESC


-- Timesheet Roster Leave Coding
SELECT					t.Id,
						r.Id RosterId,
						r.AreaId
FROM					staging.FCT_DEP_TIMESHEET t
LEFT JOIN				staging.FCT_DEP_ROSTER r on t.RosterId = r.Id
LEFT JOIN				staging.DEP_Area a ON r.AreaId = a.Id
WHERE					t.Id In (243616,
243630,
243641,
243657,
245970,
246348,
246380,
246381,
246384,
246517,
246540,
246541,
247270,
247904,
247994,
247995,
247996,
247997,
247998,
247999,
248000,
248001,
248002,
248003,
247991,
247992,
248113,
248866,
248867,
248869,
248864,
248873,
248876,
248878,
248879,
248892,
248893,
248899,
248900,
248896,
248962,
248991,
249261,
249262)


