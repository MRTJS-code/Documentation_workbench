/** Temp EDI SQL Code for manual SQL Events 
 **
 ** INPUT EVENT TYPES
 ** Leave Import / Leave Line Update: depcrated to do with transfer of leave from InTime
 ** Timesheet Paid: To mark a timesheet as paid in Deputy (requires a payload in eda.IMP_DEPRESOURCE)
 ** Employee Custom Field: To insert or update custom field values against an employee (requires payload in eda.IMP_DEPEMPPECUSTOM)
 ** General Resource: To create, update or bulk update Deputy data using it's Resource API (requires payload in eda.IMP_DEPRESOURCE)
 ** Emp Agree Migration: To archive an employee agreement and move all locations to another agreement record or create a new agreement record (requires payload in eda.IMP_DEPEMPAGMIGRATE)
 ** Timesheet Reprocess: To unapprove then reapprove timesheets - usually to fix pay cycle and costing (requires payload in eda.IMP_DEPTIMESHEETFIX)
 **/

DECLARE @event TABLE (eventId int)
DECLARE @eventId int

INSERT INTO eda.ETL_EVENT (ETL_REF, ETL_RUN_CODE, EVENT_STATUS, EVENT_DATE_CREATE, EVENT_SOURCE, EVENT_INPUT, EVENT_OUTPUT, EVENT_USER_EMAIL, DATE_LAST_MODIFIED, EVENT_KICKOFF_DATE)
OUTPUT Inserted.EVENT_ID INTO @event
VALUES (
	6002,
	0,
	'NEW',
	GETDATE(),
	'MANUAL EVENT', -- Event Source
	'GENERAL RESOURCE', -- Input Options: TIMESHEET PAID, EMPLOYEE CUSTOM FIELD, GENERAL RESOURCE, EMP AGREE MIGRATION, TIMESHEET REPROCESS, DEPUTY
	'DEPUTY', -- Output Options: DEPUTY, BILLING, PAYROLL, SUBCONTRACTOR
	'tony.smith@firstsecurity.co.nz', --tony.smith@firstsecurity.co.nz, melissa.kennedy@firstsecurity.co.nz, fsg.payroll@firstsecurity.co.nz
	GETDATE(),
	'2025-12-31 00:00' -- Event Kick off data: enter a date when this event should process
);

SELECT @eventId = eventId FROM @event;

/** Variable table insert for extracts 
*** Note "All" is the only current extract type for subcontractor extracts.  If used to formally extract for AP purposes later this can be amended.
***/
--INSERT INTO eda.ETL_EVENT_VARIABLES VALUES
--(@eventId,'EXTRACT_FROM','DateTime','Date to extract from (inclusive)','2025-12-22',SYSDATETIME()),
--(@eventId,'EXTRACT_TO','DateTime','Date to extract to (inclusive)','2025-12-28',SYSDATETIME()),
--(@eventId,'EXTRACT_STAGETYPE','String','BILLING, SUBCONTRACTOR or PAYROLL','SUBCONTRACTOR',SYSDATETIME()),  -- BILLING (not extracted for invoicing) or PAYROLL (not extracted fro payroll run)
--(@eventId,'EXTRACT_TYPE','String','ALL, DRAFT or EXTRACT','ALL',SYSDATETIME()) -- ALL = include previously extracted + nothing back to Deputy, draft = just not extracted + nothing back to Deputy, extract = just not extracted + extract / paid / invoiced will be updated in Deputy

/** Insert SQL templates for Excel generated Deputy data imports **/
INSERT INTO eda.IMP_DEPRESOURCE (eventId,apiType,resource,recordId,isBulk,isInsert,reqBody)
--INSERT INTO eda.IMP_DEPTIMESHEETFIX (eventId,employeeId,locationId,agreementId,timesheets)
--INSERT INTO eda.IMP_DEPEMPAGMIGRATE (eventId, employeeId,currAgreeId,newAgreeId,newAgreeBody)
--INSERT INTO eda.IMP_DEPEMPEECUSTOM (eventId, employeeId, customId, depBody)
VALUES 

/** Delete Code to tidy up **/
--DELETE FROM eda.IMP_DEPRESOURCE --WHERE eventId = 7540
--DELETE FROM eda.IMP_DEPTIMESHEETFIX
--DELETE FROM eda.IMP_DEPEMPAGMIGRATE
--DELETE FROM eda.IMP_DEPEMPEECUSTOM
--DELETE FROM eda.ETL_EVENT_VARIABLES

--UPDATE eda.ETL_EVENT SET EVENT_STATUS	 = 'Retry' /*,EVENT_INPUT = 'GENERAL RESOURCE', EVENT_OUTPUT = 'DEPUTY'*/  WHERE EVENT_ID IN (7610)
--UPDATE eda.IMP_DEPRESOURCE SET responseMsg = 'Completed' WHERE eventId IN 


/** EDA table checker **/	
	SELECT * FROM eda.ETL_EVENT WHERE EVENT_ID > 7606
	--SELECT * FROM eda.ETL_EVENT_VARIABLES --WHERE EVENT_ID = 7606
	--SELECT * FROM eda.IMP_DEPEMPAGMIGRATE
	--SELECT * FROM eda.IMP_DEPEMPEECUSTOM
	--SELECT * FROM eda.IMP_DEPLEAVE
	SELECT * FROM eda.IMP_DEPRESOURCE WHERE eventId IN (7610)
	--SELECT * FROM eda.IMP_DEPTIMESHEETFIX

--SELECT * FROM eda.STG_UNAPPROVEDTS

--SELECT * FROM eda.LKP_PHTRACKER WHERE timesheetDate > '2025-12-23' -- temp code to check PH tracker impact bug 2737
--SELECT * FROM eda.LKP_PHTRACKER ORDER BY timesheetDate