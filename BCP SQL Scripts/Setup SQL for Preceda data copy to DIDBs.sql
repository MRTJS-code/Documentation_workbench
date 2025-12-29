SELECT				e.PK_PR_ID_Number,
					ep.P_Base_Rate,
					ep.P_EMS_Rate
FROM				dw.DIM_EMPLOYEE e
LEFT JOIN			dw.DIM_EMPLOYEE_PAY ep ON e.SK_DIM_EMPLOYEE = ep.FK_DIM_EMPLOYEE
WHERE				e.P_Payrun_Group = 'FW'
AND					e.P_PR_Termination_Date is NULL
AND					e.PK_DW_Source_System = 'Preceda'


