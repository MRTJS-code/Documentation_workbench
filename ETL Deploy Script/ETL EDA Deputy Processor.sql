USE [ETLFramework]
GO

/** Inserts
 ** Step 1 create the new ETL Record
 **/

--INSERT INTO [metadata].[CTL_JOB_CONFIG]
--           ([JOB_CODE]
--           ,[JOB_NAME]
--           ,[JOB_STATUS]
--           ,[JOB_INTERVAL_MODE]
--           ,[JOB_INTERVAL_VAL]
--           ,[JOB_DATE_KICK_OFF]
--           ,[DATA_RANGE_MODE]
--           ,[DATA_RANGE_FIXED_INTERVAL_MODE]
--           ,[DATA_RANGE_FIXED_INTERVAL_VAL]
--           ,[DATA_RANGE_INC_TIME]
--           ,[DATA_RANGE_DAYS_DELAY]
--           ,[DATA_RANGE_DATE_START]
--           ,[NOTIF_AFTER_CONS_FAILURE]
--           ,[NOTIF_AFTER_RUNNING_MINS]
--           ,[NOTIF_EMAIL_ADDRESS]
--           ,[ERROR_AFTER_CONS_FAILURE]
--           ,[ETL_INTEGRATED]
--           ,[ETL_FOLDER_NAME]
--           ,[ETL_PROJECT_NAME]
--           ,[ETL_PACKAGE_NAME]
--           ,[ETL_EXECUTION_ID]
--           ,[DATE_LAST_MODIFIED]
--           ,[SKIP_AFTER_CONS_FAILURE]
--           ,[FAIL_AFTER_RUNNING_MINS]
--           ,[JOB_SUPPORT_LINK]
--           ,[AREA_NAME]
--           ,[ETL_RUN_32BIT_MODE]
--		   ,JOB_EXCLUSION_TIME_START
--		   ,JOB_EXCLUSION_DURATION_HRS
--		   ,JOB_EXCLUSION_DAYS
--		   ,JOB_SUCCESSIVE_GROUPS
--		   ,JOB_DELTA_USE_RUN_DATE)
--     VALUES
--           (8029								--code
--           ,'JOB PBID ODS SEC NZ Customer Pricing'--name
--           ,'PAUSED'							--status
--           ,'DAILY'								--interval mode
--           ,1									--interval value
--           ,'2025-02-23 20:15'					--kick off (Perth Time)
--           ,'FIXED'								--data range mode
--           ,'NA'								--fixed interval mode
--           ,0									--fixed interval value
--           ,'NO'								--data range includes time?
--           ,-1									--data range days delay
--           ,'2025-02-23 00:00'					--data range date start
--           ,2									--notify after how many failures
--           ,10									--notify after running for how many minutes
--           ,'tony.smith@firstsecurity.co.nz'	--notify email address
--           ,2									--# errors before failure
--           ,'YES'								--ETL Integrated
--           ,'PowerBI Dataset'					--Folder Name
--           ,'Job PBID ODS_SEC_NZ Full DB'			--Project Name
--           ,'0 Job Plan.dtsx'					--Package Name
--           ,0									--execution ID
--           ,sysdatetime()						--date last modified
--           ,2									--skip after how many failures
--           ,30									--fail after running for how long?
--           ,NULL								--job support link
--           ,'ODS NZ Security'					--area name
--           ,'NO'								--32 bit more
--		   ,null								--Job Exclusion time start
--		   ,null								--Job Exclusion hours
--		   ,null								--Job Exclusion Days
--		   ,null								--Job Successive Groups
--		   ,'YES'								--Job Delta Use Run date
--		   )								
--GO

/** Step 2 - add any config variables (if any) **/
INSERT INTO [metadata].[CTL_JOB_CONFIG_VARIABLES]
           ([JOB_CODE]
           ,[OBJECT_TYPE_CODE]
           ,[VARIABLE_CODE]
           ,[DATA_TYPE]
           ,[VARIABLE_DESC]
           ,[VARIABLE_VALUE]
           ,[DATE_LAST_MODIFIED]
           ,[SCOPE])
     VALUES
           (6002													--job code
           ,20														--object type (20=project parameter)
           ,'ETL_CUS_MIN_DAYS'									--variable code
           ,'int'												--data type (int, datetime, nvarchar)
           ,'number working days for ph check'						--variable description
           ,7														--variable value
           ,sysdatetime()											--date last modified
           ,'Parameter'	),											--Scope (always parameter)
		   (6002													--job code
           ,20														--object type (20=project parameter)
           ,'ETL_CUS_WEEKS'									--variable code
           ,'int'												--data type (int, datetime, nvarchar)
           ,'number weeks for ph check'						--variable description
           ,13														--variable value
           ,sysdatetime()											--date last modified
           ,'Parameter'	)
GO


/** Step 3 - add any dependicies (if any) **/
--DELETE FROM metadata.CTL_JOB_CONFIG_DEPENDENCIES WHERE JOB_DEPENDER_CODE = 6002

INSERT INTO [metadata].[CTL_JOB_CONFIG_DEPENDENCIES]
           ([JOB_DEPENDER_CODE]
           ,[JOB_DEPENDEE_CODE]
           ,[DEPENDENCY_TYPE]
           ,[DATE_LAST_MODIFIED])
     VALUES
           (6002			--job code to wait
           ,8005			--job code it is waiting to run
           ,'SUCCESSIVE'	--data=this run needs data from the previous, successive=these runs can't process at the same time
           ,SYSDATETIME())	--date last modified
GO


/** UPDATE CODE
 ** STEP 1 Update the JOB CONFIG table
 **/

UPDATE [metadata].[CTL_JOB_CONFIG]
   SET [JOB_NAME] = 'Job EDA NZ SEC Deputy'
      ,[JOB_STATUS] = 'PAUSED'
      ,[JOB_INTERVAL_MODE] = 'MINUTELY'
      ,[JOB_INTERVAL_VAL] = 1
      ,[JOB_DATE_KICK_OFF] = '2025-12-02'
      ,[DATA_RANGE_MODE] = 'DELTA'
      ,[DATA_RANGE_FIXED_INTERVAL_MODE] = 'MINUTELY'
      ,[DATA_RANGE_FIXED_INTERVAL_VAL] = 1
      ,[DATA_RANGE_INC_TIME] = 'NO'
      ,[DATA_RANGE_DAYS_DELAY] = 0
      ,[DATA_RANGE_DATE_START] = '2025-12-02'
      ,[NOTIF_AFTER_CONS_FAILURE] = 1
      ,[NOTIF_AFTER_RUNNING_MINS] = 60
      ,[NOTIF_EMAIL_ADDRESS] = 'tony.smith@firstsecurity.co.nz'
      ,[ERROR_AFTER_CONS_FAILURE] = 1
      ,[ETL_INTEGRATED] = 'YES'
      ,[ETL_FOLDER_NAME] = 'Operational Data Store'
      ,[ETL_PROJECT_NAME] = 'Job EDA NZ SEC Deputy'
      ,[ETL_PACKAGE_NAME] = '0 Job Plan.dtsx'
      ,[ETL_EXECUTION_ID] = 0
      ,[DATE_LAST_MODIFIED] = sysdatetime()
      ,[SKIP_AFTER_CONS_FAILURE] = 0
      ,[FAIL_AFTER_RUNNING_MINS] = 120
 --     ,[JOB_SUPPORT_LINK] = ''
      ,[AREA_NAME] = 'ODS NZ Security'
      ,[ETL_RUN_32BIT_MODE] = 'NO'
      ,[JOB_EXCLUSION_TIME_START] = '14:00'
      ,[JOB_EXCLUSION_DURATION_HRS] = 8
      ,[JOB_EXCLUSION_DAYS] = 'MON;TUE;WED;THU;FRI;SAT;SUN'
 --     ,[JOB_SUCCESSIVE_GROUPS] = <JOB_SUCCESSIVE_GROUPS, varchar(100),>
      ,[JOB_DELTA_USE_RUN_DATE] = 'YES'
 WHERE JOB_CODE = 6002
GO

/** Step 2 - add any config variables (if any) **/
--UPDATE		metadata.CTL_JOB_CONFIG_VARIABLES
--SET			VARIABLE_VALUE = 1
--WHERE		JOB_CODE = 8024
--AND			VARIABLE_CODE = 'ETL_CUST_PERIOD_CHG'

/** Step 3 - add any dependicies (if any) **/
--UPDATE metadata.[CTL_JOB_CONFIG_DEPENDENCIES]
--	SET DEPENDENCY_TYPE = 'SUCCESSIVE'
--	, DATE_LAST_MODIFIED = SYSDATETIME()
--WHERE JOB_DEPENDER_CODE = 8024
--AND JOB_DEPENDEE_CODE = 8011

--DELETE FROM metadata.CTL_JOB_CONFIG_VARIABLES WHERE JOB_CODE = 8011
--DELETE FROM metadata.[CTL_JOB_CONFIG_DEPENDENCIES] WHERE JOB_DEPENDER_CODE = 8023 AND JOB_DEPENDEE_CODE = 8011

SELECT * FROM [metadata].[CTL_JOB_CONFIG] WHERE JOB_CODE IN (6002)

SELECT *
  FROM [metadata].[CTL_JOB_CONFIG_DEPENDENCIES]
  WHERE [JOB_DEPENDER_CODE] IN (6002)
  OR [JOB_DEPENDEE_CODE] IN (6002)

SELECT * FROM metadata.[CTL_JOB_CONFIG_VARIABLES] WHERE JOB_CODE IN (6002)