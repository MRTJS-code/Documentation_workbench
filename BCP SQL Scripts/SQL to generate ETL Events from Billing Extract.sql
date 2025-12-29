DECLARE					@eventId int = 6336;
DECLARE					@userEmail varchar(100) = 'tony.smith@firstsecurity.co.nz';

DECLARE					@jsonObjLen int = len(@userEmail) + 50 + 5; -- allows 5 characters above typical object size + declared variables
DECLARE					@jsonObjMax int = 2000 / @jsonObjLen; -- 2000 is max character length for the DB field storing the JSON body for Deputy

-- Create Event to update Deputy
DECLARE @event TABLE (eventId int)
DECLARE @impeventId int

INSERT INTO eda.ETL_EVENT (ETL_REF, ETL_RUN_CODE, EVENT_STATUS, EVENT_DATE_CREATE, EVENT_SOURCE, EVENT_INPUT, EVENT_OUTPUT, EVENT_USER_EMAIL, DATE_LAST_MODIFIED, EVENT_KICKOFF_DATE)
OUTPUT Inserted.EVENT_ID INTO @event
VALUES (
	6002,
	0,
	'NEW',
	GETDATE(),
	'Billing Extract', -- Source of the Event
	'General Resource', --DATA SOURCE options: Timesheet Paid, Employee Custom Field, General Resource, Emp Agree Migration, Timesheet Reprocess, Deputy
	'Deputy', -- DATA TARGET options: Preceda, Billing, Subcontractor, Deputy
	@userEmail, -- Use your own email here
	GETDATE(),
	NULL -- NULL if you want the event to process now, otherwise provide datetime it should run server time (perth - UTC + 8)
);

SELECT @impeventId = eventId FROM @event;

-- Code to mark as invoiced
WITH					billExt As (
SELECT					qry.timeSheetID,
						ROW_NUMBER() OVER (ORDER BY qry.timesheetID) rowNum
FROM (
SELECT					--l.CompanyNumber [Customer ID],
--						d.locationName [Site/Locations],
						d.Id timeSheetID,
						--cast(d.timesheetStart as date) [Shift Date],
						--d.timesheetStart [Start Time],
						--d.timesheetEnd [End Time],
						--ROUND(d.timesheetHours*4,0) / 4 [Hours],
						--d.areaName [Area (Role)],
						--d.CostCentre [Cost Centre],
						--CASE 
						--	WHEN isnull(d.ponumber, d.sourcePO) = 'na' THEN NULL
						--	ELSE isnull(d.ponumber, d.sourcePO)
						--END [PO Number],
						--NULL [REF],
						isnull(d.TierProductCode, d.AreaProduct) [Product ID],
						--NULL [blank],
						--d.branchName [Deputy Branch],
						--d.AreaId [Deputy Area ID],
						--isnull(d.ritm, d.sorceRITM) [RITM],
						--d.payrollId [Payroll Id],
						--d.firstName + ' ' + d.lastName [Staff Name],
						d.AreaProduct [Area Product]--,
						--d.AreaRateName [Area Rate Card],
						--d.TierProductCode [Tier Product],
						--d.TierRateName [Tier Rate Card]
FROM					eda.EXT_DEP_FULL d
LEFT JOIN				eda.STG_DEPTIMESHEET t ON d.Id = t.Id
LEFT JOIN				eda.STG_DEP_LOCATION l ON t.LocationId = l.Id

WHERE					d.MDEventId = @eventId 
AND						d.payActivityCode != 'OD'  -- Update to exclude all allowance lines unless billable					
						) qry
WHERE					(qry.[Product ID] like 'SG%' OR qry.[Product ID] like 'RBSG%')
AND						(qry.[Area Product] like 'SG%' OR qry.[Area Product] like 'RBSG%')	
),
Grouped AS (			SELECT ((rowNum - 1) / @jsonObjMax) AS grp,  -- group number, 50 rows per group
						CONCAT('{"Id":', timeSheetID, ',"Invoiced":true, "InvoiceComment":"',@userEmail,'"}') AS JsonRow
						FROM billExt
)
INSERT INTO eda.IMP_DEPRESOURCE (eventId,apiType,resource,recordId,isBulk,isInsert,reqBody)
SELECT 
    @impeventId,
	'resource',
	'Timesheet',
	grp,
	1,
	0,
    CONCAT('[', STRING_AGG(JsonRow, ','), ']') AS JsonArray
FROM Grouped
GROUP BY grp
ORDER BY grp;