


-- ========================================================
-- Author:		CHARLENE SY 
-- Create date: 2024-02-01 
-- Description:	stored proc for building dim_GHS_USERS
-- =========================================================
CREATE PROCEDURE [dw].[PROC_DIM_GHS_USERS]
	-- Add the parameters for the stored procedure here
	@P_JOB INT,  
	@P_RUN INT,	
	@P_PACK VARCHAR(70),
	@P_USER VARCHAR(70)
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;


-- Assuming these parameters are set before executing the script

WITH EmployeeCTE AS (
    SELECT
        U.[ID] AS PK_USER_ID,
        E1.SK_DIM_EMPLOYEE AS FK_SK_GT_DIM_EMPLOYEE,
        E2.SK_DIM_EMPLOYEE AS FK_SK_PR_DIM_EMPLOYEE,
        SG.SK_DIM_SECURITYGUARD,
        U.[FULL_NAME],
        U.[FIRST_NAME],
        U.[LAST_NAME],
        U.[EMAIL],
        U.[CC_EMAIL],
        U.[COUNTRY],
        U.[MOBILE],
        U.[ALTERNATIVE_PHONE],
        U.[TIMEZONE],
        U.[STATUS],
        U.[INVITATION_STATUS],
        U.[CREATED_AT],
        U.[UPDATED_AT],
        U.[LAST_LOGIN],
        ROW_NUMBER() OVER (PARTITION BY U.ID ORDER BY U.ID, E1.SK_DIM_EMPLOYEE, E2.SK_DIM_EMPLOYEE) AS rowNum
    FROM
        [ODS_NZ_SEC].[STAGING].[GHS_USERS] U
    LEFT JOIN
        [ODS_NZ_SEC].[DW].[DIM_EMPLOYEE] E1 ON LEFT(U.EMAIL, CHARINDEX('@', U.EMAIL) - 1) = E1.PK_GT_ID_NUMBER
    LEFT JOIN
        [ODS_NZ_SEC].[DW].[DIM_EMPLOYEE] E2 ON LEFT(U.EMAIL, CHARINDEX('@', U.EMAIL) - 1) = E2.PK_PR_ID_NUMBER
    LEFT JOIN
        [ODS_NZ_SEC].[DW].[DIM_SECURITYGUARD] SG ON SG.PK_IT_EmployeeId = E1.PK_GT_ID_NUMBER
                                                    OR SG.PK_IT_EmployeeId = E1.PK_PR_ID_NUMBER
                                                    OR SG.PK_IT_EmployeeId = E2.PK_GT_ID_NUMBER
                                                    OR SG.PK_IT_EmployeeId = E2.PK_PR_ID_NUMBER
    WHERE
        U.STATUS = 'ACTIVE' AND U.INVITATION_STATUS = 'ACCEPTED'
)

-- Create or replace the temporary table with explicit column names
SELECT *
INTO #tempEmp
FROM EmployeeCTE
WHERE rowNum = 1;

-- Perform the MERGE operation
MERGE INTO [dw].[DIM_GHS_USERS] AS target
USING #tempEmp AS source
ON target.PK_USER_ID = source.PK_USER_ID
WHEN MATCHED THEN
    UPDATE SET
        target.FK_SK_DIM_EMPLOYEE = CASE 
                                    WHEN source.FK_SK_PR_DIM_EMPLOYEE IS NOT NULL THEN source.FK_SK_PR_DIM_EMPLOYEE 
                                    ELSE source.FK_SK_GT_DIM_EMPLOYEE 
                                END,
        target.FK_SK_DIM_SECURITYGUARD = source.SK_DIM_SECURITYGUARD,
        target.P_FULL_NAME = source.FULL_NAME,
        target.P_FIRST_NAME = source.FIRST_NAME,
        target.P_LAST_NAME = source.LAST_NAME,
        target.P_EMAIL = source.EMAIL,
        target.P_CC_EMAIL = source.CC_EMAIL,
        target.P_COUNTRY = source.COUNTRY,
        target.P_MOBILE = source.MOBILE,
        target.P_ALTERNATIVE_PHONE = source.ALTERNATIVE_PHONE,
        target.P_TIMEZONE = source.TIMEZONE,
        target.P_STATUS = source.STATUS,
        target.P_INVITATION_STATUS = source.INVITATION_STATUS,
        target.P_CREATED_AT = source.CREATED_AT,
        target.P_UPDATED_AT = source.UPDATED_AT,
        target.P_LAST_LOGIN = source.LAST_LOGIN,
        target.MD_DATE_MODIFIED = GETDATE(),
        target.MD_JOB_CODE = @P_JOB,
        target.MD_RUN_CODE = @P_RUN,
        target.MD_PACK_NAME = @P_PACK,
        target.MD_MODIFIED_USER = @P_USER,
        target.MD_LOGICAL_DELETE = 0
WHEN NOT MATCHED THEN
    INSERT (
        PK_USER_ID,
        FK_SK_DIM_EMPLOYEE,
        FK_SK_DIM_SECURITYGUARD,
        P_FULL_NAME,
        P_FIRST_NAME,
        P_LAST_NAME,
        P_EMAIL,
        P_CC_EMAIL,
        P_COUNTRY,
        P_MOBILE,
        P_ALTERNATIVE_PHONE,
        P_TIMEZONE,
        P_STATUS,
        P_INVITATION_STATUS,
        P_CREATED_AT,
        P_UPDATED_AT,
        P_LAST_LOGIN,
        MD_DATE_CREATED,
        MD_DATE_MODIFIED,
        MD_JOB_CODE,
        MD_RUN_CODE,
        MD_PACK_NAME,
        MD_MODIFIED_USER,
        MD_LOGICAL_DELETE
    )
    VALUES (
        source.PK_USER_ID,
        CASE 
            WHEN source.FK_SK_PR_DIM_EMPLOYEE IS NOT NULL THEN source.FK_SK_PR_DIM_EMPLOYEE 
            ELSE source.FK_SK_GT_DIM_EMPLOYEE 
        END,
        source.SK_DIM_SECURITYGUARD,
        source.FULL_NAME,
        source.FIRST_NAME,
        source.LAST_NAME,
        source.EMAIL,
        source.CC_EMAIL,
        source.COUNTRY,
        source.MOBILE,
        source.ALTERNATIVE_PHONE,
        source.TIMEZONE,
        source.STATUS,
        source.INVITATION_STATUS,
        source.CREATED_AT,
        source.UPDATED_AT,
        source.LAST_LOGIN,
        GETDATE(), 
        GETDATE(), 
        @P_JOB, 
        @P_RUN,
        @P_PACK,
        @P_USER,
        0
    );

-- Drop the temporary table
DROP TABLE #tempEmp;