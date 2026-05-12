








CREATE view [dw].[REP_EMPEE_PAY]
as
SELECT				e.PK_PR_ID_Number empeeRef,
					p.P_Base_Rate baseRate,
					p.P_Base_Rate * 1.5 phRate
FROM				dw.DIM_EMPLOYEE e
INNER JOIN			dw.DIM_EMPLOYEE_PAY p on e.SK_DIM_EMPLOYEE = p.FK_DIM_EMPLOYEE
WHERE				e.PK_DW_Source_System = 'Preceda'
AND					e.P_Payrun_Group = 'FW'

--UNION ALL

--SELECT				g.PK_IT_EmployeeId empeeRef,
--					--DISTINCT a.P_AttributeValue empr,
--					isnull(s.P_ORD_RatePerHour,0) baseRate,
--					isnull(s.P_PH_RatePerHour,0) phRate
--FROM				dw.DIM_SECURITYGUARD g
--LEFT JOIN			dw.DIM_IT_STAFF_ATTRIBUTE a ON g.SK_DIM_SECURITYGUARD = a.FK_DIM_SECURITYGUARD
--LEFT JOIN			dw.DIM_SUBCONTRACTOR s ON a.P_AttributeValue = s.P_SubContractorName
--WHERE				a.P_AttributeReference = 'Empr'
--AND					a.P_AttributeValue != 'First Security'
