WITH qry AS (
SELECT
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
						l.Active LocationActive,
						CASE
							WHEN l.ParentId = 0 THEN NULL
							WHEN b.ParentId = 0 THEN NULL
							WHEN r.ParentId = 0 THEN NULL
							ELSE l.Name 
						END LocationName,
						l.Creator,
						l.Modified,
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
						END CompanyName
FROM					staging.DEP_Location l
LEFT JOIN				staging.DEP_Location b ON l.ParentId = b.Id
LEFT JOIN				staging.DEP_Location r ON b.ParentId = r.Id
LEFT JOIN				staging.DEP_Location c ON r.ParentId = c.Id
)
SELECT					qry.LocationId,
						qry.BranchId,
						qry.LocationCode,
						qry.LocationName,
						qry.LocationDebtor,
						qry.LocationActive,
						qry.BranchCode,
						qry.BranchName,
						d.DepotName,
						qry.RegionCode,
						qry.RegionName,
						d.DepotRegion,
						qry.CompanyCode,
						qry.CompanyName,
						qry.Modified,
						qry.Creator,
						isnull(d.SK_DIM_DEPOT,0) FK_DIM_DEPOT
FROM					qry
LEFT JOIN				dw.DIM_DEPOT d ON qry.BranchId = d.PK_SourceId AND d.PK_SourceSystem = 'Deputy'
--WHERE					qry.LocationId is not null
WHERE					qry.CompanyId != 1
--WHERE						qry.CompanyCode = 'FSASH'
ORDER BY				qry.isPayroll DESC,  qry.CompanyName, qry.RegionName, qry.BranchName, qry.LocationName;
