/** New Work Areas **/
INSERT INTO			lookup.DEP_WorkAreas (PK_WorkAreaID,WorkAreaName, FK_LocationCode, FK_CostCentre,FK_ProductCode)
SELECT				a.Id,
					a.Name,
					a.LocationId,
					CASE 
							WHEN CHARINDEX('|',a.PayrollExportName) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(a.PayrollExportName), '|', '.'), 1))
							ELSE a.PayrollExportName
						END CostCentre,
						CASE 
							WHEN CHARINDEX('|',a.PayrollExportName) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(a.PayrollExportName), '|', '.'), 2))
							ELSE NULL
						END ProductCode
FROM				lookup.DEP_WorkAreas wa
FULL OUTER JOIN		staging.DEP_Area a ON wa.PK_WorkAreaID = a.Id
WHERE				wa.PK_WorkAreaID is NULL

/** New Locations **/
INSERT INTO			lookup.DEP_Location (PK_LocationCode, FK_DebtorCode, LocationName)
SELECT				l.Id, l.CompanyNumber, l.Name
FROM				lookup.DEP_Location ll
FULL OUTER JOIN		staging.DEP_Location l ON ll.PK_LocationCode = l.Id
WHERE				ll.PK_LocationCode is null
AND					l.isPayroll = 0
AND					l.CompanyNumber NOT IN ('company','branch','region')
AND					l.Id != 14

/** Review Extract **/
SELECT				wa.*, l.FK_DebtorCode, l.LocationName, a.Active areaActive, lo.Active locationActive
FROM				lookup.DEP_WorkAreas wa
LEFT JOIN			lookup.DEP_Location l ON wa.FK_LocationCode = l.PK_LocationCode
LEFT JOIN			staging.DEP_Area a ON wa.PK_WorkAreaID = a.Id
LEFT JOIN			staging.DEP_Location lo ON  l.PK_LocationCode = lo.Id


SELECT				a.Id,
					CASE 
							WHEN CHARINDEX('|',a.PayrollExportName) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(a.PayrollExportName), '|', '.'), 2))
							ELSE NULL
						END ProductCode
FROM				staging.DEP_Area a