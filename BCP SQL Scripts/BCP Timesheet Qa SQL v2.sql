/** SQL Script to check for timesheets that have not been approved / tagged
** Can be adapted into a stored procedue for live querying of data later (following a fresh Deputy extract)
**/
DECLARE					@dateFrom date = '2025-12-01'; -- inclusive date from
DECLARE					@dateTo date = '2025-12-31'; -- inclusive date to
DECLARE					@historicFrom date ='2025-07-01' -- how far back to check history.  Earliest dates: paid - 2024-11-01, invoiced - 2025-02-01
DECLARE					@timeApprovalCheck bit = 1; -- check approved (1) vs not approved (0)
DECLARE					@payApprovalCheck bit = 1 -- check approved (1) vs not approved (0)
DECLARE					@tagCheck varchar(20) = 'Invoiced'; -- Exported or Invoiced or Paid
DECLARE					@payrollOnly bit = 0 -- 1 to only look at payroll timesheets, 0 to review all
DECLARE					@agreementCheck bit = 0 ;-- 1 to include missing agreement / period ids, 0 to skip
DECLARE					@timesheetFixCode bit = 0; -- 1 to provide a timesheet fix load, 0 to skip
DECLARE					@checkHistoric bit = 0;
DECLARE					@paidUnapprovedCheck bit = 0;
DECLARE					@invoicedDiscardedCheck bit = 0;

/** Roster Missing Timesheets check
**/
IF						@checkHistoric = 0
BEGIN
SELECT					r.Id,
						e.displayName,
						a.Name areaName,
						l.Name locationName,
						b.Name branchName,
						rg.name regionName,
						r.RosterStart,
						r.RosterEnd,
						r.Comment,
						r.Warning,
						r.WarningOverride,
						r.ModifiedDate
FROM					staging.FCT_DEP_ROSTER r
LEFT JOIN				staging.DEP_Area a on r.AreaId = a.Id
LEFT JOIN				staging.DEP_Employee e ON r.EmployeeId = e.employeeId
LEFT JOIN				staging.DEP_Location l ON a.LocationId = l.Id
LEFT JOIN				staging.DEP_Location b ON l.ParentId = b.Id
LEFT JOIN				staging.DEP_Location rg ON b.ParentId = rg.Id
WHERE					r.RosterDate >= @dateFrom
AND						r.RosterDate < DATEADD(DAY,1,@dateTo)
AND						isnull(r.TimesheetId,0) = 0
AND						r.EmployeeId != 0
AND						l.ParentId != 59 -- Ignore workforce planning branch
AND						rg.ParentId = 1 -- Ignore test roster and invalid location setups
ORDER BY				r.RosterStart;
END;

/** Roster Missing Timesheets check - historic
**/
IF						@checkHistoric = 1
BEGIN
SELECT					r.Id,
						e.displayName,
						a.Name areaName,
						l.Name locationName,
						b.Name branchName,
						rg.name regionName,
						r.RosterStart,
						r.RosterEnd,
						r.Comment,
						r.Warning,
						r.WarningOverride,
						r.ModifiedDate
FROM					staging.FCT_DEP_ROSTER r
LEFT JOIN				staging.DEP_Area a on r.AreaId = a.Id
LEFT JOIN				staging.DEP_Employee e ON r.EmployeeId = e.employeeId
LEFT JOIN				staging.DEP_Location l ON a.LocationId = l.Id
LEFT JOIN				staging.DEP_Location b ON l.ParentId = b.Id
LEFT JOIN				staging.DEP_Location rg ON b.ParentId = rg.Id
WHERE					r.RosterDate >= @historicFrom
AND						r.RosterDate < DATEADD(DAY,1,@dateFrom)
AND						isnull(r.TimesheetId,0) = 0
AND						r.EmployeeId != 0
AND						l.ParentId != 59 -- Ignore workforce planning branch
AND						rg.ParentId = 1 -- Ignore test roster and invalid location setups
ORDER BY				r.RosterStart
END;

/** Current Period Check
**/
IF						@checkHistoric = 0
BEGIN
WITH searchQry As(
SELECT					--t.*,
						t.Id,
						e.displayName,
						a.Name areaName,
						isnull(l.Name,lr.Name) locationName,
						t.timesheetStart,
						t.timesheetEnd,
						t.timesheetHours,
						t.TimeApproved,
						t.PayApproved,
						t.Exported,
						t.Paid,
						t.Invoiced,
						t.Modified ModifyDate,
						CASE 
							WHEN CHARINDEX('|',a.PayrollExportName) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(a.PayrollExportName), '|', '.'), 2))
							ELSE NULL
						END productCode,
						ep.PeriodId,
						pc.Name payCentreName,
						lr.Name leaveRuleName
FROM					staging.FCT_DEP_TIMESHEET t
LEFT JOIN				staging.DEP_Area a on t.AreaId = a.Id
LEFT JOIN				staging.DEP_EmployeePaycycle ep on t.PayCycleId = ep.Id
LEFT JOIN				staging.DEP_EmployeeAgreement ea ON t.AgreementId = ea.agreementId
LEFT JOIN				staging.DEP_Employee e ON t.EmployeeId = e.employeeId
LEFT JOIN				staging.DEP_Location pc ON ea.payCentreId = pc.Id
LEFT JOIN				staging.DEP_LeaveRules lr ON t.LeaveRuleId = lr.Id
LEFT JOIN				staging.DEP_Location l ON a.LocationId = l.Id
WHERE					t.timesheetStart >= @dateFrom
AND						t.timesheetStart < DATEADD(day,1,@dateTo)
AND						isnull(lr.PaidLeave,1) = 1
AND						isnull(t.TimeApproved,0) = @timeApprovalCheck
AND						isnull(t.PayApproved,0) = @payApprovalCheck
AND						CASE @tagCheck WHEN 'Exported' THEN isnull(t.Exported,0) ELSE 0 END = 0
AND						CASE @tagCheck WHEN 'Invoiced' THEN isnull(t.Invoiced,0) ELSE 0  END = 0
AND						CASE @tagCheck WHEN 'Paid' THEN isnull(t.Paid,0) ELSE 0 END = 0
AND						isnull(t.Discarded,0) = 0
)

SELECT					*
FROM					searchQry
WHERE					((( @tagCheck= 'Invoiced' AND searchQry.productCode like 'SG%') OR @tagCheck != 'Invoiced')
OR						(( @tagCheck= 'Invoiced' AND searchQry.productCode like 'RBSG%') OR @tagCheck != 'Invoiced'))
AND						(searchQry.payCentreName =  CASE WHEN @tagCheck != 'Invoiced' AND @payrollOnly = 1 THEN 'Employee Timesheets' ELSE searchQry.payCentreName END
OR						searchQry.payCentreName =  CASE WHEN @tagCheck != 'Invoiced' AND @payrollOnly = 1  THEN 'Agency Timesheets' ELSE searchQry.payCentreName END) 
--AND						searchQry.Id = 321948
ORDER BY				searchQry.PeriodId, searchQry.Id;
END;

/** Prior Period Check
**/
IF						@checkHistoric = 1
BEGIN
WITH searchQry As(
SELECT					--t.*,
						t.Id,
						e.displayName,
						a.Name areaName,
						isnull(l.Name,lr.Name) locationName,
						t.timesheetStart,
						t.timesheetEnd,
						t.timesheetHours,
						t.TimeApproved,
						t.PayApproved,
						t.Exported,
						t.Paid,
						t.Invoiced,
						t.Modified ModifyDate,
						CASE 
							WHEN CHARINDEX('|',a.PayrollExportName) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(a.PayrollExportName), '|', '.'), 2))
							ELSE NULL
						END productCode,
						ep.PeriodId,
						pc.Name payCentreName,
						lr.Name leaveRuleName
FROM					staging.FCT_DEP_TIMESHEET t
LEFT JOIN				staging.DEP_Area a on t.AreaId = a.Id
LEFT JOIN				staging.DEP_EmployeePaycycle ep on t.PayCycleId = ep.Id
LEFT JOIN				staging.DEP_EmployeeAgreement ea ON t.AgreementId = ea.agreementId
LEFT JOIN				staging.DEP_Employee e ON t.EmployeeId = e.employeeId
LEFT JOIN				staging.DEP_Location pc ON ea.payCentreId = pc.Id
LEFT JOIN				staging.DEP_LeaveRules lr ON t.LeaveRuleId = lr.Id
LEFT JOIN				staging.DEP_Location l ON a.LocationId = l.Id
WHERE					t.timesheetStart >= @historicFrom
AND						t.timesheetStart < @dateFrom
AND						isnull(lr.PaidLeave,1) = 1
AND						isnull(t.TimeApproved,0) = @timeApprovalCheck
AND						isnull(t.PayApproved,0) = @payApprovalCheck
AND						CASE @tagCheck WHEN 'Exported' THEN isnull(t.Exported,0) ELSE 0 END = 0
AND						CASE @tagCheck WHEN 'Invoiced' THEN isnull(t.Invoiced,0) ELSE 0  END = 0
AND						CASE @tagCheck WHEN 'Paid' THEN isnull(t.Paid,0) ELSE 0 END = 0
AND						isnull(t.Discarded,0) = 0
)

SELECT					*
FROM					searchQry
WHERE					((( @tagCheck= 'Invoiced' AND searchQry.productCode like 'SG%') OR @tagCheck != 'Invoiced')
OR						(( @tagCheck= 'Invoiced' AND searchQry.productCode like 'RBSG%') OR @tagCheck != 'Invoiced'))
AND						(searchQry.payCentreName =  CASE WHEN @tagCheck = 'Paid' AND @payrollOnly = 1 THEN 'Employee Timesheets' ELSE searchQry.payCentreName END
OR						searchQry.payCentreName =  CASE WHEN @tagCheck = 'Paid' AND @payrollOnly = 1  THEN 'Agency Timesheets' ELSE searchQry.payCentreName END) 
ORDER BY				searchQry.PeriodId, searchQry.Id;
END

/** SQL Script to provide a list of employees missing agreement / pay centre setups
** Requires a fixed update or manual run of the employee staging package to update tdate
**/
If						@agreementCheck = 1
BEGIN
SELECT					e.employeeId,
						ea.payrollId,
						e.displayName,
						Count(t.Id) timesheetCount
FROM					staging.FCT_DEP_TIMESHEET t
LEFT JOIN				staging.DEP_EmployeeAgreement ea ON t.AgreementId = ea.agreementId
LEFT JOIN				staging.DEP_Employee e ON t.EmployeeId = e.employeeId
LEFT JOIN				staging.DEP_Location pc ON ea.payCentreId = pc.Id
WHERE					t.timesheetStart >= @dateFrom
AND						t.timesheetStart < DATEADD(day,1,@dateTo)
AND						ea.agreementId is NULL
AND						isnull(t.Discarded,0) = 0
AND						CASE @tagCheck WHEN 'Paid' THEN isnull(t.Paid,0) ELSE 0 END = 0
GROUP BY				e.employeeId,
						ea.payrollId,
						e.displayName
END


/** SQL Script to build timesheet fix SQL body to reapprove timesheets
** Can be adapted into a stored procedue for immediate fixes of timesheets as long as the employee has a paycentre / agreement set
**/
IF						@timesheetFixCode = 1 
BEGIN
SELECT					'(@eventId,' + qry.EmployeeId + ',' + isnull(qry.LocationId,'NULL') + ',' + qry.agreementId + ',' + qry.timesheets + '),' qryValues
FROM (
SELECT					cast(t.EmployeeId as nvarchar) EmployeeId,
						cast(a.LocationId as nvarchar) LocationId,
						cast(ea.agreementId as nvarchar) agreementId,
						'''{"TimesheetId":[' + STRING_AGG(t.Id,',') + ']}''' timesheets
FROM					staging.FCT_DEP_TIMESHEET t
LEFT JOIN				staging.DEP_Area a ON t.AreaId = a.Id
LEFT JOIN				staging.DEP_EmployeeAgreement ea ON t.EmployeeId = ea.employeeId AND ea.isActive = 1
WHERE					t.timesheetStart >= @dateFrom
AND						t.timesheetStart < DATEADD(day,1,@dateTo)
AND						isnull(t.Discarded,0) = 0
AND						isnull(t.TimeApproved,0) = 1
AND						isnull(t.PayApproved,0) = 0
--AND						ea.employeeId IN (296,419,2979,2978)
GROUP BY				t.EmployeeId, a.LocationId, ea.agreementId
						) qry
END

/** SQL Script to check for paid timesheets that are not time and pay approved
** 
**/
IF						@PaidUnapprovedCheck = 1 AND @checkHistoric = 0
BEGIN
SELECT					t.Id,
						e.displayName,
						a.Name areaName,
						l.Name locationName,
						t.timesheetStart,
						t.timesheetEnd,
						t.timesheetHours,
						t.TimeApproved,
						t.PayApproved,
						t.Exported,
						t.Paid,
						t.Invoiced,
						t.Modified ModifyDate,
						ep.PeriodId
FROM					staging.FCT_DEP_TIMESHEET t
LEFT JOIN				staging.DEP_EmployeeAgreement ea ON t.AgreementId = ea.agreementId
LEFT JOIN				staging.DEP_Employee e ON t.EmployeeId = e.employeeId
LEFT JOIN				staging.DEP_Location pc ON ea.payCentreId = pc.Id
LEFT JOIN				staging.DEP_Area a on t.AreaId = a.Id
LEFT JOIN				staging.DEP_Location l ON a.LocationId = l.Id
LEFT JOIN				staging.DEP_EmployeePaycycle ep on t.PayCycleId = ep.Id
WHERE					t.timesheetStart >= @dateFrom
AND						t.timesheetStart < DATEADD(day,1,@dateTo)
AND						isnull(t.Discarded,0) = 0
AND						t.Paid = 1
AND						t.PayApproved = 0
END

/** SQL Script to check for paid timesheets that are not time and pay approved
** 
**/
IF						@PaidUnapprovedCheck = 1 AND @checkHistoric = 1
BEGIN
SELECT					t.Id,
						e.displayName,
						a.Name areaName,
						l.Name locationName,
						t.timesheetStart,
						t.timesheetEnd,
						t.timesheetHours,
						t.TimeApproved,
						t.PayApproved,
						t.Exported,
						t.Paid,
						t.Invoiced,
						t.Modified ModifyDate,
						ep.PeriodId
FROM					staging.FCT_DEP_TIMESHEET t
LEFT JOIN				staging.DEP_EmployeeAgreement ea ON t.AgreementId = ea.agreementId
LEFT JOIN				staging.DEP_Employee e ON t.EmployeeId = e.employeeId
LEFT JOIN				staging.DEP_Location pc ON ea.payCentreId = pc.Id
LEFT JOIN				staging.DEP_Area a on t.AreaId = a.Id
LEFT JOIN				staging.DEP_Location l ON a.LocationId = l.Id
LEFT JOIN				staging.DEP_EmployeePaycycle ep on t.PayCycleId = ep.Id
WHERE					t.timesheetStart >= @historicFrom
AND						t.timesheetStart < @dateFrom
AND						isnull(t.Discarded,0) = 0
AND						t.Paid = 1
AND						t.PayApproved = 0
END

/** Check for discarded timesheets that have been invocied
** 
**/
IF						@invoicedDiscardedCheck = 1 AND @checkHistoric = 0
BEGIN
SELECT					t.Id,
						e.displayName,
						a.Name areaName,
						l.Name locationName,
						t.timesheetStart,
						t.timesheetEnd,
						t.timesheetHours,
						t.TimeApproved,
						t.PayApproved,
						t.Exported,
						t.Paid,
						t.Invoiced,
						t.Modified ModifyDate,
						ep.PeriodId
FROM					staging.FCT_DEP_TIMESHEET t
LEFT JOIN				staging.DEP_EmployeeAgreement ea ON t.AgreementId = ea.agreementId
LEFT JOIN				staging.DEP_Employee e ON t.EmployeeId = e.employeeId
LEFT JOIN				staging.DEP_Location pc ON ea.payCentreId = pc.Id
LEFT JOIN				staging.DEP_Area a on t.AreaId = a.Id
LEFT JOIN				staging.DEP_Location l ON a.LocationId = l.Id
LEFT JOIN				staging.DEP_EmployeePaycycle ep on t.PayCycleId = ep.Id
WHERE					t.timesheetStart >= @dateFrom
AND						t.timesheetStart < DATEADD(day,1,@dateTo)
AND						isnull(t.Discarded,0) = 1
AND						t.Invoiced = 1
END


/** SQL Script to check for paid timesheets that are not time and pay approved
** 
**/
IF						@InvoicedDiscardedCheck = 1 AND @checkHistoric = 1
BEGIN
SELECT					t.Id,
						e.displayName,
						a.Name areaName,
						l.Name locationName,
						t.timesheetStart,
						t.timesheetEnd,
						t.timesheetHours,
						t.TimeApproved,
						t.PayApproved,
						t.Exported,
						t.Paid,
						t.Invoiced,
						t.Modified ModifyDate,
						ep.PeriodId
FROM					staging.FCT_DEP_TIMESHEET t
LEFT JOIN				staging.DEP_EmployeeAgreement ea ON t.AgreementId = ea.agreementId
LEFT JOIN				staging.DEP_Employee e ON t.EmployeeId = e.employeeId
LEFT JOIN				staging.DEP_Location pc ON ea.payCentreId = pc.Id
LEFT JOIN				staging.DEP_Area a on t.AreaId = a.Id
LEFT JOIN				staging.DEP_Location l ON a.LocationId = l.Id
LEFT JOIN				staging.DEP_EmployeePaycycle ep on t.PayCycleId = ep.Id
WHERE					t.timesheetStart >= @historicFrom
AND						t.timesheetStart < @dateFrom
AND						isnull(t.Discarded,0) = 1
AND						t.Invoiced = 1
END