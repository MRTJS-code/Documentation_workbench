DECLARE					@eventId int = 1;

SELECT					t.Id timesheetId,
						t.locationName,
						t.areaName,
						j.custCode gtDebtorCode,
						j.jobName,
						j.jobType,
						t.JobCode,
						t.payrollId employeeId,
						t.displayName,
						t.branchName,
						e.employer,
						t.timesheetHours regularHours,
						isnull(t.phHours,0) statHours,
						t.timesheetStart,
						t.timesheetEnd
FROM					eda.EXT_DEP_FULL t
LEFT JOIN				eda.LKP_GT_JOB j ON t.JobCode = j.jobCode
LEFT JOIN				eda.STG_DEP_EMPLOYEE e ON t.EmployeeId = e.employeeId
WHERE					t.MDEventId = @eventId
AND						isnull(t.LeaveRuleId,0) = 0