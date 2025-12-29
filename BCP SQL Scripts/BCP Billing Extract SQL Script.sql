DECLARE					@eventId int = 6336

-- D365 Export Template
SELECT					* 
FROM (
SELECT					l.CompanyNumber [Customer ID],
						d.locationName [Site/Locations],
						d.Id timeSheetID,
						cast(d.timesheetStart as date) [Shift Date],
						d.timesheetStart [Start Time],
						d.timesheetEnd [End Time],
						ROUND(d.timesheetHours*4,0) / 4 [Hours],
						d.areaName [Area (Role)],
						d.CostCentre [Cost Centre],
						CASE 
							WHEN isnull(d.ponumber, d.sourcePO) = 'na' THEN NULL
							ELSE isnull(d.ponumber, d.sourcePO)
						END [PO Number],
						NULL [REF],
						isnull(d.TierProductCode, d.AreaProduct) [Product ID],
						NULL [blank],
						d.branchName [Deputy Branch],
						d.AreaId [Deputy Area ID],
						isnull(d.ritm, d.sorceRITM) [RITM],
						d.payrollId [Payroll Id],
						d.firstName + ' ' + d.lastName [Staff Name],
						d.AreaProduct [Area Product],
						d.AreaRateName [Area Rate Card],
						d.TierProductCode [Tier Product],
						d.TierRateName [Tier Rate Card]
FROM					eda.EXT_DEP_FULL d
LEFT JOIN				eda.STG_DEPTIMESHEET t ON d.Id = t.Id
LEFT JOIN				eda.STG_DEP_LOCATION l ON t.LocationId = l.Id

WHERE					d.MDEventId = @eventId 
AND						d.payActivityCode != 'OD'  -- Update to exclude all allowance lines unless billable				
						) qry
WHERE					(qry.[Product ID] like 'SG%' OR qry.[Product ID] like 'RBSG%')
AND						(qry.[Area Product] like 'SG%' OR qry.[Area Product] like 'RBSG%')				

-- Add Union to handle ord vs public holiday splitting
