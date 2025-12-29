WITH qry AS (
SELECT
						a.Id AreaId,
						a.Name AreaName,
						CASE 
							WHEN CHARINDEX('|',a.PayrollExportName) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(a.PayrollExportName), '|', '.'), 1))
							ELSE a.PayrollExportName
						END CostCentre,
						CASE 
							WHEN CHARINDEX('|',a.PayrollExportName) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(a.PayrollExportName), '|', '.'), 2))
							ELSE NULL
						END Product,
						CASE
							WHEN l.ParentId = 0 THEN NULL
							WHEN b.ParentId = 0 THEN NULL
							WHEN r.ParentId = 0 THEN NULL
							ELSE l.Id 
						END LocationId,
						CASE
							WHEN l.ParentId = 0 THEN NULL
							WHEN b.ParentId = 0 THEN NULL
							WHEN r.ParentId = 0 THEN l.Id
							ELSE b.Id
						END BranchId,
						CASE
							WHEN l.ParentId = 0 THEN NULL
							WHEN b.ParentId = 0 THEN l.Id
							WHEN r.ParentId = 0 THEN b.Id
							ELSE r.Id
						END RegionId,
						CASE
							WHEN l.ParentId = 0 then l.Id
							WHEN b.ParentId = 0 then b.Id
							WHEN r.ParentId = 0 then r.Id
							ELSE c.Id
						END CompanyId,
						CASE
							WHEN l.ParentId = 0 THEN NULL
							WHEN b.ParentId = 0 THEN NULL
							WHEN r.ParentId = 0 THEN NULL
							ELSE l.Code 
						END LocationCode,
						CASE
							WHEN l.ParentId = 0 THEN NULL
							WHEN b.ParentId = 0 THEN NULL
							WHEN r.ParentId = 0 THEN l.Code
							ELSE b.Code 
						END BranchCode,
						CASE
							WHEN l.ParentId = 0 THEN NULL
							WHEN b.ParentId = 0 THEN l.Code
							WHEN r.ParentId = 0 THEN b.Code
							ELSE r.Code
						END RegionCode,
						CASE
							WHEN l.ParentId = 0 then l.Code
							WHEN b.ParentId = 0 then b.Code
							WHEN r.ParentId = 0 then r.Code
							ELSE c.Code
						END CompanyCode,
						l.CompanyNumber LocationDebtor,
						l.isWorkplace,
						l.isPayroll,
						b.Active BranchActive,
						CASE
							WHEN l.ParentId = 0 THEN NULL
							WHEN b.ParentId = 0 THEN NULL
							WHEN r.ParentId = 0 THEN NULL
							ELSE l.Name 
						END LocationName,
						l.CompanyNumber,
						CASE
							WHEN l.ParentId = 0 THEN NULL
							WHEN b.ParentId = 0 THEN NULL
							WHEN r.ParentId = 0 THEN l.Name
							ELSE b.Name 
						END BranchName,
						CASE
							WHEN l.ParentId = 0 THEN NULL
							WHEN b.ParentId = 0 THEN l.Name
							WHEN r.ParentId = 0 THEN b.Name
							ELSE r.Name 
						END RegionName,
						CASE
							WHEN l.ParentId = 0 then l.Name
							WHEN b.ParentId = 0 then b.Name
							WHEN r.ParentId = 0 then r.Name
							ELSE c.Name 
						END CompanyName,
						maxRoster.maxRosterDate,
						b.Creator,
						b.Modified
FROM					staging.DEP_Location l
LEFT JOIN				staging.DEP_Location b ON l.ParentId = b.Id
LEFT JOIN				staging.DEP_Location r ON b.ParentId = r.Id
LEFT JOIN				staging.DEP_Location c ON r.ParentId = c.Id
LEFT JOIN				staging.DEP_AREA a ON a.LocationId = l.Id
LEFT JOIN				(SELECT r.RosterAreaId, max(Cast(r.RosterFrom as Date)) maxRosterDate FROM dw.FACT_ROSTER r WHERE isnull(r.MD_LogicalDelete,0) = 0  GROUP BY r.RosterAreaId ) maxRoster ON a.Id = maxRoster.RosterAreaId
--WHERE					l.Id = 3996
)
--SELECT	DISTINCT		qry.AreaName, qry.CostCentre, qry.Product, qry.LocationCode, qry.LocationName, qry.BranchId, qry.BranchName, qry.RegionName, qry.CompanyName, qry.isPayroll,isnull(db.SKDIM_Branch,0) FK_DIM_Branch, 
--						qry.BranchActive, md.Creator, md.Modified, qry.maxRosterDate
--/** location setup **/
SELECT	DISTINCT		qry.LocationId, qry.CompanyNumber DebtorAccount,qry.LocationName, qry.BranchId, qry.BranchName, qry.RegionName, qry.CompanyName, qry.isPayroll,isnull(db.SKDIM_Branch,0) FK_DIM_Branch, 
						qry.BranchActive, md.Creator, md.Modified
/* Branch setup */
--SELECT	DISTINCT		qry.BranchId, qry.BranchName, qry.RegionName, qry.CompanyName, qry.isPayroll,isnull(db.SKDIM_Branch,0) FK_DIM_Branch, qry.BranchActive, md.Creator, md.Modified
--SELECT	DISTINCT		qry.AreaId, qry.AreaName, qry.CostCentre, qry.Product, qry.LocationId
FROM					qry
LEFT JOIN				lookup.DEP_DEPOTBRANCH db ON qry.BranchId = db.DepBranchId
LEFT JOIN				(SELECT Id, Creator, Modified FROM staging.DEP_Location) md ON qry.BranchId = md.Id
--WHERE					qry.BranchId is NOT NULL
--AND						qry.LocationName is not null
--AND						qry.AreaId is not null
WHERE						qry.BranchId = 3996
--ORDER BY				qry.isPayroll DESC,  qry.CompanyName, qry.RegionName, qry.BranchName

SELECT * FROM staging.DEP_Location l WHERE l.ParentId = 3996

