-- Preceda Type Data
SELECT					e.PK_PR_ID_Number,
						e.P_Employee_Type,
						e.P_Employement_Type
FROM					dw.DIM_EMPLOYEE e
WHERE					e.PK_DW_Source_System = 'Preceda'
AND						e.P_PR_Termination_Date is NULL

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
AND						e.P_PR_Termination_Date is NULL

-- Employee Data Extract
SELECT					e.employeeId,
						e.displayName,
						ebl.Role,
						ea.payrollId,
						l.Name PrimaryLocation,
						pc.Name employeePaycentre,
						pr.payTitle,
						ebl.employer,
						ebl.customfieldId,
						ea.contractId,
						ea.agreementId
FROM					staging.DEP_Employee e
LEFT JOIN				staging.DEP_EmployeeAgreement ea ON e.employeeId = ea.employeeId
LEFT JOIN				staging.DEP_EmployeeBranchLocation ebl ON e.employeeId = ebl.Id
LEFT JOIN				staging.DEP_Location l ON ebl.Company = l.Id
LEFT JOIN				staging.DEP_Location pc ON ea.payCentreId = pc.Id
LEFT JOIN				staging.DEP_Payrules pr On ea.payRuleId = pr.payRuleId
WHERE					e.terminationDate is NULL
AND						ea.isActive = 1
AND						ebl.isActive = 1