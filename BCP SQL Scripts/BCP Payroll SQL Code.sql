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

---- Deputy Employee
--SELECT					e.employeeId,
--						ea.payrollId,
--						e.firstName,
--						e.lastName,
--						e.displayName,
--						db.Name employeeBranch,
--						dr.Name employeeRegion,
--						ebl.employer
--FROM					staging.DEP_Employee e
--LEFT JOIN				staging.DEP_EmployeeAgreement ea ON e.employeeId = ea.employeeId
--LEFT JOIN				staging.DEP_EmployeeBranchLocation ebl on e.employeeId = ebl.Id
--LEFT JOIN				staging.DEP_Location db ON ebl.Company = db.Id
--LEFT JOIN				staging.DEP_Location dr ON db.ParentId = dr.Id
--WHERE					ea.isActive = 1
--ORDER BY				e.employeeId

---- Deputy Aera
--SELECT					qry.*, j.P_jobStatus GTJobStatus
--FROM (
--SELECT					a.Id AreaId,
--						CASE 
--							WHEN CHARINDEX('|',a.PayrollExportName) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(a.PayrollExportName), '|', '.'), 1))
--							ELSE a.PayrollExportName
--						END DeputyJobCode,
--						a.Name AreaName,
--						l.Name LocationName,
--						lb.Name BranchName,
--						lr.Name RegionName
--FROM					staging.DEP_Area a
--LEFT JOIN				staging.DEP_Location l ON a.LocationId = l.Id
--LEFT JOIN				staging.DEP_Location lb ON l.ParentId = lb.Id
--LEFT JOIN				staging.DEP_Location lr ON lb.ParentId = lr.Id
--						) qry
--LEFT JOIN				dw.DIM_JOB J on qry.DeputyJobCode = j.P_jobCode

---- Employee Base Rates
--SELECT					e.PK_PR_ID_Number idNumber,
--						e.P_First_Name + ' ' + e.P_Surname fullName,
--						e.P_Personal_Email personalEmail,
--						e.P_PR_Termination_Date termDate,
--						ep.P_Base_Hours baseHrs,
--						e.P_Region region,
--						ep.P_Pay_Frequency payFreq,
--						ep.P_Base_Rate payRate1,
--						ep.P_EMS_Rate payRate4
--FROM					dw.DIM_EMPLOYEE e
--LEFT JOIN				dw.DIM_EMPLOYEE_PAY ep ON e.SK_DIM_EMPLOYEE = ep.FK_DIM_EMPLOYEE
--WHERE					e.PK_DW_Source_System = 'Preceda'

---- Leave Roster Tracker
--SELECT					*
--FROM					lookup.DEP_LeaveCostTracker

---- Leave History Tracker
--DECLARE					@effectiveDate date = '2025-06-02'

--SELECT					ea.payrollId,
--						datename(dw,r.RosterDate) wkDay,
--						CASE 
--							WHEN CHARINDEX('|',a.PayrollExportName) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(a.PayrollExportName), '|', '.'), 1))
--							ELSE a.PayrollExportName
--						END jobCode,
--						count(r.Id) rosterCount
--FROM					staging.FCT_DEP_ROSTER r
--LEFT JOIN				staging.DEP_EmployeeAgreement ea ON r.EmployeeId = ea.employeeId
--LEFT JOIN				staging.DEP_Area a ON r.AreaId = a.Id
--WHERE					r.RosterDate >= DATEADD(Week,-13,@effectiveDate)
--AND						r.RosterDate < @effectiveDate
--AND						ea.isActive = 1
--GROUP BY				ea.payrollId,
--						datename(dw,r.RosterDate),
--						CASE 
--							WHEN CHARINDEX('|',a.PayrollExportName) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(a.PayrollExportName), '|', '.'), 1))
--							ELSE a.PayrollExportName
--						END
--ORDER BY				ea.payrollId,
--						datename(dw,r.RosterDate),
--						count(r.Id) DESC