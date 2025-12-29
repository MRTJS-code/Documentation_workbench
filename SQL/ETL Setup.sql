USE [ETLFramework]
GO

/** Inserts
 ** Step 1 create the new ETL Record
 **/

INSERT INTO [metadata].[CTL_JOB_CONFIG]
           ([JOB_CODE]
           ,[JOB_NAME]
           ,[JOB_STATUS]
           ,[JOB_INTERVAL_MODE]
           ,[JOB_INTERVAL_VAL]
           ,[JOB_DATE_KICK_OFF]
           ,[DATA_RANGE_MODE]
           ,[DATA_RANGE_FIXED_INTERVAL_MODE]
           ,[DATA_RANGE_FIXED_INTERVAL_VAL]
           ,[DATA_RANGE_INC_TIME]
           ,[DATA_RANGE_DAYS_DELAY]
           ,[DATA_RANGE_DATE_START]
           ,[NOTIF_AFTER_CONS_FAILURE]
           ,[NOTIF_AFTER_RUNNING_MINS]
           ,[NOTIF_EMAIL_ADDRESS]
           ,[ERROR_AFTER_CONS_FAILURE]
           ,[ETL_INTEGRATED]
           ,[ETL_FOLDER_NAME]
           ,[ETL_PROJECT_NAME]
           ,[ETL_PACKAGE_NAME]
           ,[ETL_EXECUTION_ID]
           ,[DATE_LAST_MODIFIED]
           ,[SKIP_AFTER_CONS_FAILURE]
           ,[FAIL_AFTER_RUNNING_MINS]
           ,[JOB_SUPPORT_LINK]
           ,[AREA_NAME]
           ,[ETL_RUN_32BIT_MODE]
		   ,JOB_EXCLUSION_TIME_START
		   ,JOB_EXCLUSION_DURATION_HRS
		   ,JOB_EXCLUSION_DAYS
		   ,JOB_SUCCESSIVE_GROUPS
		   ,JOB_DELTA_USE_RUN_DATE)
     VALUES
           (6002								--code
           ,'EDA NZ Deputy Integration Processor'--name
           ,'PAUSED'							--status
           ,'MINUTELY'								--interval mode
           ,10									--interval value
           ,'2024-11-13 00:00'					--kick off
           ,'DELTA'								--data range mode
           ,'NA'								--fixed interval mode
           ,0									--fixed interval value
           ,'NO'								--data range includes time?
           ,-1									--data range days delay
           ,'2024-11-13 00:00'					--data range date start
           ,2									--notify after how many failures
           ,10									--notify after running for how many minutes
           ,'tony.smith@firstsecurity.co.nz'	--notify email address
           ,2									--# errors before failure
           ,'YES'								--ETL Integrated
           ,'Data Integration'					--Folder Name
           ,'Job InTime EDA Processor'			--Project Name
           ,'0 Job Plan.dtsx'					--Package Name
           ,0									--execution ID
           ,sysdatetime()						--date last modified
           ,2									--skip after how many failures
           ,30									--fail after running for how long?
           ,NULL								--job support link
           ,'Data Integration NZ Security'		--area name
           ,'NO'								--32 bit more
		   ,null								--Job Exclusion time start
		   ,null								--Job Exclusion hours
		   ,null								--Job Exclusion Days
		   ,null								--Job Successive Groups
		   ,'YES'								--Job Delta Use Run date
		   )								
GO