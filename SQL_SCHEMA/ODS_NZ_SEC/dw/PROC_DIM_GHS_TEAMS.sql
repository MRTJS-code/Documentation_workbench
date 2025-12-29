
-- ========================================================
-- AUTHOR:      CHARLENE SY 
-- CREATE DATE: 2024-02-01 
-- DESCRIPTION: STORED PROC FOR BUILDING DIM_GHS_TEAMS
-- =========================================================
CREATE PROCEDURE [dw].[PROC_DIM_GHS_TEAMS]
    -- ADD THE PARAMETERS FOR THE STORED PROCEDURE HERE
    @P_JOB INT,  
    @P_RUN INT,    
    @P_PACK VARCHAR(70)   ,
    @P_user VARCHAR(70)   
AS

-- WITH CTE DEFINITION
WITH CTE AS (
    SELECT 
        T.[id],
        T.organization_id,
        ST.SK_DIM_ORGANISATIONS,
        T.[name],
        T.[description],
        T.[created_at],
        T.[updated_at],
        ROW_NUMBER() OVER (PARTITION BY T.[id] ORDER BY T.[id], ST.SK_DIM_ORGANISATIONS) AS rowNum
    FROM [ODS_NZ_SEC].[STAGING].[GHS_TEAMS] T
    LEFT JOIN [ODS_NZ_SEC].[dw].[DIM_GHS_ORGANISATIONS] ST ON T.organization_id = ST.PK_ID
)

-- MERGE STATEMENT USING CTE DIRECTLY
MERGE INTO [ODS_NZ_SEC].[dw].[DIM_GHS_TEAMS] T 
USING (
    SELECT 
        [id],
        SK_DIM_ORGANISATIONS,
        [name],
        [description],
        [created_at],
        [updated_at]
    FROM CTE
    WHERE rowNum = 1
) S ON T.[PK_TEAMS_ID] = S.[id] AND T.[FK_SK_DIM_GHS_ORGANISATIONS] = S.SK_DIM_ORGANISATIONS

WHEN NOT MATCHED THEN
    INSERT (
        [PK_TEAMS_ID],
        [FK_SK_DIM_GHS_ORGANISATIONS],
        [P_NAME],
        [P_DESCRIPTION],
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
        S.[id],
        S.SK_DIM_ORGANISATIONS,
        S.[name],
        S.[description],
        S.[created_at],
        S.[updated_at],
        GETDATE(),
        GETDATE(),
        @P_JOB,
        @P_RUN,
        @P_PACK,
        @P_USER,
        0
    )

WHEN MATCHED THEN
    UPDATE SET
        T.[PK_TEAMS_ID] = S.[id], 
        T.[FK_SK_DIM_GHS_ORGANISATIONS] = S.SK_DIM_ORGANISATIONS,
        T.[P_NAME] = S.[name],
        T.[P_DESCRIPTION] = S.[description],
        T.[P_CREATED_AT] = S.[created_at],
        T.[P_UPDATED_AT] = S.[updated_at],
        T.[MD_DATE_CREATED] = GETDATE(),
        T.[MD_DATE_MODIFIED] = GETDATE(),
        T.[MD_JOB_CODE] = @P_JOB,
        T.[MD_RUN_CODE] = @P_RUN,
        T.[MD_PACK_NAME] = @P_PACK,
        T.[MD_MODIFIED_USER] = @P_USER,
        T.[MD_LOGICAL_DELETE] = 0;