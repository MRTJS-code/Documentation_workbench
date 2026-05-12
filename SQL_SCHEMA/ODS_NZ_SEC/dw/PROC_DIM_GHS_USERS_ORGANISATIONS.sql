
-- ========================================================
-- AUTHOR:      CHARLENE SY 
-- CREATE DATE: 2024-02-01 
-- DESCRIPTION: STORED PROC FOR BUILDING DIM_GHS_USERS_ORGS
-- =========================================================
CREATE PROCEDURE [dw].[PROC_DIM_GHS_USERS_ORGANISATIONS]
     --ADD THE PARAMETERS FOR THE STORED PROCEDURE HERE
    @P_JOB INT,  
    @P_RUN INT,    
    @P_PACK VARCHAR(70),   
    @P_USER VARCHAR(70)   
AS
begin

	WITH CTE AS (
		SELECT 
			T.id
			,U.SK_DIM_USERS
			,DT.SK_DIM_ORGANISATIONS
			,ROW_NUMBER() OVER (PARTITION BY T.ID ORDER BY T.ID,U.SK_DIM_USERS,DT.SK_DIM_ORGANISATIONS) AS rowNum
			FROM [ODS_NZ_SEC].[STAGING].[GHS_USERS_ORGANISATIONS] T
			LEFT JOIN [ODS_NZ_SEC].[DW].[DIM_GHS_USERS] U ON T.user_id = U.PK_USER_ID
			LEFT JOIN [ODS_NZ_SEC].[DW].[DIM_GHS_ORGANISATIONS] DT ON T.organisations_id = DT.PK_ID 
	)

    MERGE INTO  [ODS_NZ_SEC].[dw].[DIM_GHS_USERS_ORGANISATIONS] T 
    USING(
		SELECT  S.ID,
            S.SK_DIM_USERS,
            S.SK_DIM_ORGANISATIONS
			FROM CTE S
			WHERE  rowNum = 1
	) S     ON  T.[P_USERS_ORG_ID] = S.ID AND T.[FK_SK_DIM_USERS] = S.SK_DIM_USERS AND T.[FK_SK_DIM_ORGANISATIONS]= S.SK_DIM_ORGANISATIONS

    WHEN NOT MATCHED THEN
        INSERT 
        (
			 [P_USERS_ORG_ID]
		    ,[FK_SK_DIM_USERS]
		    ,[FK_SK_DIM_ORGANISATIONS]
            ,[MD_DATE_CREATED]
            ,[MD_DATE_MODIFIED]
            ,[MD_JOB_CODE]
            ,[MD_RUN_CODE]
            ,[MD_PACK_NAME]
            ,[MD_MODIFIED_USER]
            ,[MD_LOGICAL_DELETE]
        ) 
        VALUES 
        (
            S.ID,
            S.SK_DIM_USERS,
            S.SK_DIM_ORGANISATIONS,
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
            T.[P_USERS_ORG_ID] = S.ID, 
            T.[FK_SK_DIM_USERS]= S.SK_DIM_USERS,
            T.[FK_SK_DIM_ORGANISATIONS]= S.SK_DIM_ORGANISATIONS,
            T.[MD_DATE_CREATED] = GETDATE(),
            T.[MD_DATE_MODIFIED] = GETDATE(),
            T.[MD_JOB_CODE] = @P_JOB,
            T.[MD_RUN_CODE] = @P_RUN,
            T.[MD_PACK_NAME] = @P_PACK,
            T.[MD_LOGICAL_DELETE] = 0;


END;