-- =============================================
-- Author:		Tony Smith
-- Create date: 18/06/2021
-- Description:	Updates DIM_STAFF status and type from Payroll and Roster Data
-- =============================================
CREATE PROCEDURE [ods].[DIM_STAFF_STATUSTYPE]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

--Wipe previous status 
UPDATE						ods.DIM_STAFF
SET							DIM_STAFF.Status = NULL,
							DIM_STAFF.Type = NULL;

--build temp roster table with max assignmentdate aggregate.  Faster than using a subquery
SELECT						ro.itStaffId,
							max(ro.assignmentDate) maxAssign
INTO						#itAssignSummary
FROM						ods.FCT_ROSTER ro
GROUP BY					ro.itStaffId;

--build temp aggregate payroll data table
SELECT						pyl.empeeId,
							max(pyl.postingDate) maxPay
INTO						#gtPaySummary
FROM						ods.FCT_PAYROLL pyl
GROUP BY					pyl.empeeId;

--create temp table for storing staff type results for active employees
CREATE TABLE #activeStaff(
	StaffID bigint NULL,
	staffType varchar(50) NULL,
	maxAssignDate date NULL);

--Add active employees (active and paid in the last 60 days)
INSERT INTO			#activeStaff
SELECT				StaffID,
					--subQuery.gtId,
					'Employee' as staffType,
					maxIntimeAssignDate
FROM (SELECT DISTINCT		sta.StaffID,
							ee.empid as gtId,
							its.employeeId as itId,
							ee.fullname,
							ee.hrBasis,
							ee.hrType,
							ee.terminationDate,
							ro.maxAssign as maxIntimeAssignDate,
							py.maxPay as maxPayrunDate
FROM						ods.DIM_STAFF sta
INNER JOIN					ods.DIM_EMPEE ee ON sta.StaffID = ee.staffid
INNER JOIN					#gtPaySummary py ON ee.gtId = py.empeeId
LEFT JOIN					ods.DIM_INTIMESTAFF its ON cast(ee.empid as nvarchar(255)) = its.employeeId
LEFT JOIN					#itAssignSummary ro ON its.employeeId = ro.itStaffId
WHERE						ee.isInactive = 0) subQuery
WHERE						DATEDIFF(day,maxPayrunDate,sysdatetimeoffset() at time zone 'New Zealand Standard Time') < 60;


-- Casual Employees who have not been actively on payroll in the last 60 days, but have InTime activity in the last 6 months
SELECT				StaffID,
					subQuery.gtid,
					'Employee' as staffType,
					maxIntimeAssignDate
INTO				#inactiveCasualEmpee
FROM (SELECT DISTINCT		sta.StaffID,
							ee.empid as gtId,
							its.employeeId as itId,
							ee.fullname,
							ee.hrBasis,
							ee.hrType,
							ee.terminationDate,
							ro.maxAssign as maxIntimeAssignDate,
							py.maxPay as maxPayrunDate
FROM						ods.DIM_STAFF sta
INNER JOIN					ods.DIM_EMPEE ee ON sta.StaffID = ee.staffid
INNER JOIN					#gtPaySummary py ON ee.gtId = py.empeeId
LEFT JOIN					ods.DIM_INTIMESTAFF its ON cast(ee.empid as nvarchar(255)) = its.employeeId
LEFT JOIN					#itAssignSummary ro ON its.employeeId = ro.itStaffId
WHERE						ee.isInactive = 0) subQuery
WHERE				DATEDIFF(day,maxPayrunDate,sysdatetimeoffset() at time zone 'New Zealand Standard Time') >= 60
AND					subQuery.hrType = 'Casual'
AND					DATEDIFF(day,maxIntimeAssignDate,sysdatetimeoffset() at time zone 'New Zealand Standard Time') <= 183

--Add Active InTime records that could be employees (numeric reference but not mapped to Greentree)
INSERT INTO					#activeStaff
SELECT						sta.StaffID,
							--its.employeeId,
							CASE
								WHEN ice.gtId is not null THEN 'Employee' 
								ELSE 'Employee (no Payroll Match)' 
							END as staffType,
							ros.maxAssign
FROM						ods.DIM_STAFF sta
FULL OUTER JOIN				#activeStaff ees ON sta.StaffID = ees.StaffID
INNER JOIN					ods.DIM_INTIMESTAFF its ON sta.StaffID = its.staffId
INNER JOIN					#itAssignSummary ros ON its.employeeId = ros.itStaffId
LEFT JOIN					#inactiveCasualEmpee ice ON its.employeeId = cast(ice.gtId as nvarchar(50))
WHERE						ees.StaffID is null
AND							(its.terminationDate is null OR its.terminationDate > SYSDATETIMEOFFSET() at time zone 'New Zealand Standard Time')
AND							DATEDIFF(day,ros.maxAssign,sysdatetimeoffset() at time zone 'New Zealand Standard Time') < 60
AND							its.employeeId LIKE '[25][0][0-9][0-9][0-9][0-9][0-9]%'
AND							its.employeeId != replace(its.coa,'-','');

--Add all other Active InTime records, which will be subcontractors
INSERT INTO					#activeStaff
SELECT						sta.StaffID,
							--its.employeeId,
							'Contractor' as staffType,
							ros.maxAssign
FROM						ods.DIM_STAFF sta
FULL OUTER JOIN				#activeStaff ees ON sta.StaffID = ees.StaffID
INNER JOIN					ods.DIM_INTIMESTAFF its ON sta.StaffID = its.staffId
INNER JOIN					#itAssignSummary ros ON its.employeeId = ros.itStaffId
WHERE						ees.StaffID is null
AND							its.terminationDate is null
AND							DATEDIFF(day,ros.maxAssign,sysdatetimeoffset() at time zone 'New Zealand Standard Time') < 60;

-- Update DIM_STAFF with the new staff type and a status of active
UPDATE						sta
SET							sta.Type = ees.staffType,
							sta.Status = 'Active'
FROM						ods.DIM_STAFF sta
INNER JOIN					#activeStaff ees ON sta.StaffID = ees.StaffID;

-- Inactive Employees with no InTime Record
WITH historicGTOnly AS (
	SELECT	DISTINCT		sta.StaffID,
							'Employee' as staffType,
							CASE
								WHEN ee.isInactive = 1 THEN 'Terminated'
								ELSE 'Inactive'
							END as staffStatus
	FROM					ods.DIM_STAFF sta
	LEFT JOIN				ods.DIM_EMPEE ee ON sta.StaffID = ee.staffid
	LEFT JOIN				ods.DIM_INTIMESTAFF its ON sta.StaffID = its.staffId
	WHERE					sta.Type is NULL
	AND						its.employeeId is NULL)
UPDATE						sta
SET							sta.Type = hgt.staffType,
							sta.Status = hgt.staffStatus
FROM						ods.DIM_STAFF sta
INNER JOIN					historicGTOnly hgt ON sta.StaffID = hgt.StaffID;

--Active Contractors with future dated InTime termination
WITH activeContractors AS (
	SELECT DISTINCT			sta.StaffID,
							'Contractor' as staffType,
							'Active' as staffStatus
	FROM					ods.DIM_STAFF sta
	LEFT JOIN				ods.DIM_EMPEE ee ON sta.StaffID = ee.staffid
	LEFT JOIN				ods.DIM_INTIMESTAFF its ON sta.StaffID = its.staffId
	LEFT JOIN				#itAssignSummary ro ON its.employeeId = ro.itStaffId
	WHERE					sta.Type is NULL
	AND						its.employeeId NOT LIKE '[25][0][0-9][0-9][0-9][0-9][0-9]%'
	AND						its.terminationDate >= SYSDATETIMEOFFSET() AT TIME ZONE 'New Zealand Standard Time'
	AND						DATEDIFF(day,ro.maxAssign,sysdatetimeoffset() at time zone 'New Zealand Standard Time') < 60)
UPDATE						sta
SET							sta.Type = hgt.staffType,
							sta.Status = hgt.staffStatus
FROM						ods.DIM_STAFF sta
INNER JOIN					activeContractors hgt ON sta.StaffID = hgt.StaffID;


--Remainder are inactive contractors
WITH remainingStaff AS (
SELECT						staff.StaffID,
							CASE
								WHEN staff.empid IS NULL AND staff.employeeId LIKE '[25][0][0-9][0-9][0-9][0-9][0-9]%' THEN 'Employee (no Payroll Match)'
								WHEN staff.employeeId LIKE '[25][0][0-9][0-9][0-9][0-9][0-9]%' THEN 'Employee'
								ELSE 'Contractor'
							END as staffType,
							CASE
								WHEN staff.empid IS NOT NULL AND staff.employeeId LIKE '[25][0][0-9][0-9][0-9][0-9][0-9]%' AND staff.terminationDate IS NOT NULL THEN 'Terminated'
								ELSE 'Inactive'
							END as staffStatus
FROM (
SELECT						sta.StaffID,
							ee.empid,
							its.employeeId,
							ee.terminationDate,
							itp.maxAssign,
							ROW_NUMBER() OVER (PARTITION BY sta.StaffID ORDER BY itp.maxAssign DESC) stRank
FROM						ods.DIM_STAFF sta
LEFT JOIN					ods.DIM_EMPEE ee ON sta.StaffID = ee.staffid
LEFT JOIN					#gtPaySummary ep ON ee.gtId = ep.empeeId
LEFT JOIN					ods.DIM_INTIMESTAFF its ON sta.StaffID = its.staffId
LEFT JOIN					#itAssignSummary itp ON its.employeeId = itp.itStaffId
WHERE						sta.Type is NULL
							) staff 
WHERE						staff.stRank = 1)
UPDATE						sta
SET							sta.Type = hgt.staffType,
							sta.Status = hgt.staffStatus
FROM						ods.DIM_STAFF sta
INNER JOIN					remainingStaff hgt ON sta.StaffID = hgt.StaffID;
END
