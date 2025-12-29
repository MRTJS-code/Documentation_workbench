









CREATE VIEW [eda].[LKP_IT_STAFFREGFULL]
AS
SELECT				r.IT_ID,
					r.FIRSTNAME + CASE r.MIDDLENAME WHEN '' THEN '' ELSE ' ' + r.MIDDLENAME END + ' ' + r.LASTNAME FULLNAME,
					r.EMPLOYER,
					Cast(CASE WHEN e1.IT_ID is null THEN 0 ELSE 1 END as bit)INVALID_INTIME_ID,
					Cast(CASE WHEN e2.IT_ID is null THEN 0 ELSE 1 END as bit)NO_EMPLOYER,
					Cast(CASE WHEN e3.IT_ID is null THEN 0 ELSE 1 END as bit)EMPLOYEE_ID_INVALID,
					Cast(CASE WHEN e4.IT_ID is null THEN 0 ELSE 1 END as bit)EMPLOYER_INVALID,
					Cast(CASE WHEN e5.IT_ID is null THEN 0 ELSE 1 END as bit)NO_PRECEDA_MATCH
FROM				eda.LKP_IT_STAFFREGISTER r
INNER JOIN			(SELECT DISTINCT employeeRefId FROM eda.STG_ASSIGNHEAD) h ON r.IT_ID = h.employeeRefId
LEFT JOIN (		
SELECT				e.IT_ID
FROM				eda.LKP_IT_STAFFERROR e
WHERE				e.COMMENT = 'InTime Ref ID is invalid format'
					) e1 ON r.IT_ID = e1.IT_ID
LEFT JOIN (		
SELECT				e.IT_ID
FROM				eda.LKP_IT_STAFFERROR e
WHERE				e.COMMENT = 'No Employer Attribute Set'
					) e2 ON r.IT_ID = e2.IT_ID
LEFT JOIN (		
SELECT				e.IT_ID
FROM				eda.LKP_IT_STAFFERROR e
WHERE				e.COMMENT = 'Employee ID is not a valid Preceda format.'
					) e3 ON r.IT_ID = e3.IT_ID
LEFT JOIN (	
SELECT				e.IT_ID
FROM				eda.LKP_IT_STAFFERROR e
WHERE				e.COMMENT = 'Employer Attribute or Employee ID incorrect'
					) e4 ON r.IT_ID = e4.IT_ID
LEFT JOIN (	
SELECT				e.IT_ID
FROM				eda.LKP_IT_STAFFERROR e
WHERE				e.COMMENT = 'Employee ID does not exist in Preceda'
					) e5 ON r.IT_ID = e5.IT_ID
