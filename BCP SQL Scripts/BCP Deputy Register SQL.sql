--SELECT			a.PK_WorkAreaID WorkAreaId,
--				l.PK_LocationCode LocationId,
--				a.WorkAreaName,
--				l.LocationName,
--				a.FK_CostCentre CostCentre,
--				a.FK_ProductCode ProductCode,
--				l.FK_DebtorCode DebtorCode,
--				a.PrecedaPayCode,
--				a.PayRate WageRate,
--				a.EffectiveFrom,
--				a.EffectiveTo
--FROM			lookup.DEP_WorkAreas a
--LEFT JOIN		lookup.DEP_Location l ON a.FK_LocationCode = l.PK_LocationCode


--SELECT			t.FK_SecurityGuardID PayrollId,
--				t.FK_WorkAreaID WorkAreaId,
--				g.DisplayName,
--				wa.WorkAreaName,
--				l.LocationName,
--				t.PrecedaPayCode,
--				t.TierPayRate,
--				t.FK_ProductCode ProductOverride,
--				t.EffectiveFrom,
--				t.EffectiveTo
--FROM			lookup.DEP_ClientTiers t
--LEFT JOIN dw.DIM_EMPLOYEE e ON t.FK_SecurityGuardID = e.PK_PR_ID_Number
--LEFT JOIN staging.DEP_EmployeeAgreement a ON e.PK_PR_ID_Number = a.payrollId AND a.isActive = 1
--LEFT JOIN staging.DEP_Employee g ON a.employeeId = g.employeeId
--LEFT JOIN		lookup.DEP_WorkAreas wa ON t.FK_WorkAreaID = wa.PK_WorkAreaID
--LEFT JOIN		lookup.DEP_Location l ON  wa.FK_LocationCode = l.PK_LocationCode


CREATE TABLE lookup.DEP_Rates (
	SK_DEP_Rate bigint Identity(1,1) PRIMARY KEY,
	RateCote int NOT NULL,
	RateName varchar(100) NOT NULL,
	RateAmount float NULL,
	ProductOverride varchar(50) NULL,
	PayCodeOverride varchar(2) NULL,
	ChangeApprover varchar(100) NOT NULL,
	ChangeRef varchar(100) NULL,
	IsCurrent bit,
	CreateDate datetime,
	EffectiveFrom datetime,
	EffectiveTo datetime,
	FK_Quality int
)


SELECT			a.PK_DeputyId, a.AreaCostCentre, a.AreaProduct
FROM			dw.DIM_AREA a
--WHERE			a.PK_DeputyId = 4727


SELECT * FROM lookup.D365_CostCentres WHERE CostCentreCode = 331300092
