

-- ========================================================
-- AUTHOR:      CHARLENE SY 
-- CREATE DATE: 2024-02-01 
-- DESCRIPTION: STORED PROC FOR BUILDING DIM_GHS_ORGS
-- =========================================================
CREATE PROCEDURE [dw].[PROC_DIM_GHS_ORGANISATIONS]
    -- ADD THE PARAMETERS FOR THE STORED PROCEDURE HERE
    @P_JOB INT,  
    @P_RUN INT,    
    @P_PACK VARCHAR(70)   ,
    @P_user VARCHAR(70)   
AS


SELECT 
    [ID],
    C.F_SK_DIM_BRANCH AS PK_SK_DIM_BRANCH,
    [TITLE],
    [URL],
    [FULL_URL],
    [COUNTRY],
    [TIMEZONE],
    [ADDRESS],
    [REGION],
    [CITY],
    [EMAIL],
    [PHONE_NUMBER],
    [ORGANISATION_GROUP],
    [ENTERPRISE_ID],
    [CREATED_AT],
    [UPDATED_AT]
INTO #temptable
FROM [ODS_NZ_SEC].[STAGING].[GHS_ORGANISATIONS] O
LEFT JOIN [ODS_NZ_SEC].[LOOKUP].[GHS_ORG_CSV] C ON O.ID = C.PK_GHS_ORG;

MERGE INTO [DW].[DIM_GHS_ORGANISATIONS] A
USING #temptable B ON (A.PK_ID = B.ID)
WHEN MATCHED THEN
    UPDATE SET
        A.FK_SK_DIM_BRANCH = B.PK_SK_DIM_BRANCH,
        A.P_TITLE = B.TITLE,
        A.P_URL = B.URL,
        A.P_FULL_URL = B.FULL_URL,
        A.P_COUNTRY = B.COUNTRY,
        A.P_TIMEZONE = B.TIMEZONE,
        A.P_ADDRESS = B.ADDRESS,
        A.P_REGION = B.REGION,
        A.P_CITY = B.CITY,
        A.P_EMAIL = B.EMAIL,
        A.P_PHONE_NUMBER = B.PHONE_NUMBER,
        A.P_ORGANISATION_GROUP = B.ORGANISATION_GROUP,
        A.P_ENTERPRISE_ID = B.ENTERPRISE_ID,
        A.P_CREATED_AT = B.CREATED_AT,
        A.P_UPDATED_AT = B.UPDATED_AT,
        A.MD_DATE_MODIFIED = GETDATE(),
        A.MD_JOB_CODE = @P_JOB,
        A.MD_RUN_CODE = @P_RUN,
        A.MD_PACK_NAME = @P_PACK,
        A.MD_MODIFIED_USER = @P_USER,
        A.MD_LOGICAL_DELETE = 0
WHEN NOT MATCHED THEN
    INSERT (
        [PK_ID],
        [FK_SK_DIM_BRANCH],
        [P_TITLE],
        [P_URL],
        [P_FULL_URL],
        [P_COUNTRY],
        [P_TIMEZONE],
        [P_ADDRESS],
        [P_REGION],
        [P_CITY],
        [P_EMAIL],
        [P_PHONE_NUMBER],
        [P_ORGANISATION_GROUP],
        [P_ENTERPRISE_ID],
        [P_CREATED_AT],
        [P_UPDATED_AT],
        [MD_DATE_CREATED],
        [MD_DATE_MODIFIED],
        [MD_JOB_CODE],
        [MD_RUN_CODE],
        [MD_PACK_NAME],
        [MD_MODIFIED_USER],
        [MD_LOGICAL_DELETE]
    )
VALUES (
    B.[ID],
    B.PK_SK_DIM_BRANCH,
    B.[TITLE],
    B.[URL],
    B.[FULL_URL],
    B.[COUNTRY],
    B.[TIMEZONE],
    B.[ADDRESS],
    B.[REGION],
    B.[CITY],
    B.[EMAIL],
    B.[PHONE_NUMBER],
    B.[ORGANISATION_GROUP],
    B.[ENTERPRISE_ID],
    B.[CREATED_AT],
    B.[UPDATED_AT],
    GETDATE(),
    GETDATE(),
    @P_JOB,
    @P_RUN,
    @P_PACK,
    @P_USER,
    0
);

-- Drop the temporary table
DROP TABLE #temptable;