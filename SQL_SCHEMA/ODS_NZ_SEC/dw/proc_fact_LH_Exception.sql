
-- ======================================================
-- Author:		Crispin Nicodemus 
-- Create date: 2023-04-18 
-- Description:	stored proc for building dim_LH_Exception
-- ======================================================
CREATE PROCEDURE [dw].[proc_fact_LH_Exception]
	-- Add the parameters for the stored procedure here
	@p_job int,  
	@p_run int,	
	@p_pack varchar(70)	
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;

If(OBJECT_ID('tempdb..#tempLHException') Is Not Null)
Begin
 DROP TABLE #tempLHException
End
	
BEGIN
SELECT DISTINCT 
	   [Exception_id]
      ,[Application_id]
      ,[Schedule_id]
      ,[Schedule_name]
      ,[Schedule_type]
      ,[Exception_duration]
      ,[Exception_location]
      ,[Exception_opened]
      ,[Exception_closed]
      ,[Exception_area_id]
INTO #tempLHException
FROM staging.LH_Exception

MERGE INTO dw.FACT_LH_Exception a
USING #tempLHException b
ON a.[Exception_id] = b.[Exception_id] 

WHEN MATCHED AND
	(
		isnull(a.[Application_id],'') <> isnull(b.[Application_id],'') or
		isnull(a.[Schedule_id],'') <> isnull(b.[Schedule_id],'') or
		isnull(a.[Schedule_name],'') <> isnull(b.[Schedule_name],'') or
		isnull(a.[Schedule_type],'') <> isnull(b.[Schedule_type],'') or
		isnull(a.[Exception_duration],'') <> isnull(b.[Exception_duration],'') or
		isnull(a.[Exception_location],'') <> isnull(b.[Exception_location],'') or
		isnull(a.[Exception_opened],'') <> isnull(b.[Exception_opened],'') or
		isnull(a.[Exception_closed],'') <> isnull(b.[Exception_closed],'') or
		isnull(a.[Exception_area_id],'') <> isnull(b.[Exception_area_id],'') 
 	)
 THEN UPDATE SET
		a.[Application_id] = b.[Application_id],
		a.[Schedule_id] = b.[Schedule_id],
		a.[Schedule_name] = b.[Schedule_name],
		a.[Schedule_type] = b.[Schedule_type],
		a.[Exception_duration] = b.[Exception_duration],
		a.[Exception_location] = b.[Exception_location],
		a.[Exception_opened] = b.[Exception_opened],
		a.[Exception_closed] = b.[Exception_closed],
		a.[Exception_area_id] = b.[Exception_area_id]
		,[MD_DATE_CREATED] = getdate()
		,[MD_DATE_MODIFIED] = getdate()
		,[MD_JOB_CODE] = @p_job
		,[MD_RUN_CODE] = @p_run
		,[MD_PACK_NAME] = @p_pack

WHEN NOT MATCHED THEN
	INSERT 
	(
  		 [Exception_id]
		,[Application_id]
		,[Schedule_id]
		,[Schedule_name]
		,[Schedule_type]
		,[Exception_duration]
		,[Exception_location]
		,[Exception_opened]
		,[Exception_closed]
		,[Exception_area_id]
		,MD_DATE_CREATED
		,MD_DATE_MODIFIED
		,MD_JOB_CODE
		,MD_RUN_CODE
		,MD_PACK_NAME
	)

	VALUES
	(
 		 b.[Exception_id]
		,b.[Application_id]
		,b.[Schedule_id]
		,b.[Schedule_name]
		,b.[Schedule_type]
		,b.[Exception_duration]
		,b.[Exception_location]
		,b.[Exception_opened]
		,b.[Exception_closed]
		,b.[Exception_area_id]
		,getdate()
		,getdate()
		,@p_job 
		,@p_run
		,@p_pack
	)

;

END
;