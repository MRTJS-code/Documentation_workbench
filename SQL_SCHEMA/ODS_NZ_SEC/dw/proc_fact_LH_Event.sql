



-- ====================================================
-- Author:		Crispin Nicodemus 
-- Create date: 2023-04-18 
-- Description:	stored proc for building dim_LH_Event
-- ====================================================
CREATE PROCEDURE [dw].[proc_fact_LH_Event]
	-- Add the parameters for the stored procedure here
	@p_job int,  
	@p_run int,	
	@p_pack varchar(70)	
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;

If(OBJECT_ID('tempdb..#tempLHEvent') Is Not Null)
Begin
 DROP TABLE #tempLHEvent
End
	
BEGIN
SELECT DISTINCT 
       [Event_id]
      ,[Area_ids]
      ,[CreatedAt]
      ,[ExpiresAt]
      ,[GeocodeCity]
      ,[GeocodeCountryCode]
      ,[GeocodeLabel]
      ,[GeocodePostcode]
      ,[GeocodeRoad]
      ,[GeocodeState]
      ,[Latitude]
      ,[Longitude]
      ,[timestamp]
      ,[Type]
      ,[Updatedate]
      ,[Signal_major]
      ,[Signal_minor]
      ,[Signal_uuid]
      ,[Zone_id]
      ,[GeocodeSuburb]
      ,[GpsTimestamp]
      ,[Application_id]
      ,isnull(b.SK_DIM_LH_LOCATION,0) as  [dim_LH_Location_key]
      ,isnull(c.SK_DIM_LH_AREA,0)     as [dim_LH_Area_key]
      ,isnull(d.SK_DIM_LH_User,0)     as [dim_LH_User_key]

INTO #tempLHEvent
FROM staging.LH_EVENT
LEFT JOIN dw.DIM_LH_LOCATION b on staging.LH_EVENT.Location_id = b.P_Location_id
LEFT JOIN dw.DIM_LH_AREA     c on staging.LH_EVENT.[Area_id]   = c.P_Area_id
LEFT JOIN dw.DIM_LH_USER     d on staging.LH_EVENT.[User_id]   = d.P_User_id 

MERGE INTO dw.FACT_LH_event a
USING #tempLHevent b
ON a.event_id = b.event_id 

WHEN MATCHED AND
	(
		isnull(a.[Area_ids],'') <> isnull(b.[Area_ids],'') or
		isnull(a.[CreatedAt],'') <> isnull(b.[CreatedAt],'') or
		isnull(a.[ExpiresAt],'') <> isnull(b.[ExpiresAt],'') or
		isnull(a.[GeocodeCity],'') <> isnull(b.[GeocodeCity],'') or
		isnull(a.[GeocodeCountryCode],'') <> isnull(b.[GeocodeCountryCode],'') or
		isnull(a.[GeocodeLabel],'')  <> isnull(b.[GeocodeLabel],'') or
		isnull(a.[GeocodePostcode],'') <> isnull(b.[GeocodePostcode],'') or
		isnull(a.[GeocodeRoad],'') <> isnull(b.[GeocodeRoad],'') or
		isnull(a.[GeocodeState],'') <> isnull(b.[GeocodeState],'') or
		isnull(a.[Latitude],'') <> isnull(b.[Latitude],'') or
		isnull(a.[Longitude],'') <> isnull(b.[Longitude],'') or
		isnull(a.[timestamp],'') <> isnull(b.[timestamp],'') or
		isnull(a.[Type],'') <> isnull(b.[Type],'') or
		isnull(a.[Updatedate],'') <> isnull(b.[Updatedate],'') or
		isnull(a.[dim_LH_User_key],0) <> isnull(b.[dim_LH_User_key],0) or
		isnull(a.[dim_LH_Location_key],0) <> isnull(b.[dim_LH_Location_key],0) or
		isnull(a.[Signal_major],'') <> isnull(b.[Signal_major],'') or
		isnull(a.[Signal_minor],'') <> isnull(b.[Signal_minor],'') or
		isnull(a.[Signal_uuid],'') <> isnull(b.[Signal_uuid],'') or
		isnull(a.[Zone_id],'') <> isnull(b.[Zone_id],'') or
		isnull(a.[GeocodeSuburb],'') <> isnull(b.[GeocodeSuburb],'') or
		isnull(a.[GpsTimestamp],'') <> isnull(b.[GpsTimestamp],'') or
		isnull(a.[dim_LH_Area_key],0) <> isnull(b.[dim_LH_Area_key],0) or
		isnull(a.[Application_id],'') <> isnull(b.[Application_id],'') 
 	)
 THEN UPDATE SET
		a.[Area_ids] = b.Area_ids,
		a.[CreatedAt] = b.CreatedAt,
		a.[ExpiresAt] = b.ExpiresAt,
		a.[GeocodeCity] = b.GeocodeCity,
		a.[GeocodeCountryCode] = b.GeocodeCountryCode,
		a.[GeocodeLabel] = b.GeocodeLabel,
		a.[GeocodePostcode] = b.GeocodePostcode,
		a.[GeocodeRoad] = b.GeocodeRoad,
		a.[GeocodeState] = b.GeocodeState,
		a.[Latitude] = b.Latitude,
		a.[Longitude] = b.Longitude,
		a.[timestamp] = b.[timestamp],
		a.[Type] = b.[Type],
		a.[Updatedate] = b.Updatedate,
		a.[dim_LH_User_key] = b.dim_LH_User_key,
		a.[dim_LH_Location_key] = b.dim_LH_Location_key,
		a.[Signal_major] = b.Signal_major,
		a.[Signal_minor] = b.Signal_minor,
		a.[Signal_uuid] = b.Signal_uuid,
		a.[Zone_id] = b.Zone_id,
		a.[GeocodeSuburb] = b.GeocodeSuburb,
		a.[GpsTimestamp] = b.GpsTimestamp,
		a.[dim_LH_Area_key] = b.dim_LH_Area_key,
		a.[Application_id] = b.Application_id
		,[MD_DATE_CREATED] = getdate()
		,[MD_DATE_MODIFIED] = getdate()
		,[MD_JOB_CODE] = @p_job
		,[MD_RUN_CODE] = @p_run
		,[MD_PACK_NAME] = @p_pack

WHEN NOT MATCHED THEN
	INSERT 
	(
       [Event_id]
      ,[Area_ids]
      ,[CreatedAt]
      ,[ExpiresAt]
      ,[GeocodeCity]
      ,[GeocodeCountryCode]
      ,[GeocodeLabel]
      ,[GeocodePostcode]
      ,[GeocodeRoad]
      ,[GeocodeState]
      ,[Latitude]
      ,[Longitude]
      ,[timestamp]
      ,[Type]
      ,[Updatedate]
      ,[dim_LH_User_key]
      ,[dim_LH_Location_key]
      ,[Signal_major]
      ,[Signal_minor]
      ,[Signal_uuid]
      ,[Zone_id]
      ,[GeocodeSuburb]
      ,[GpsTimestamp]
      ,[dim_LH_Area_key]
      ,[Application_id]

	  ,MD_DATE_CREATED
	  ,MD_DATE_MODIFIED
	  ,MD_JOB_CODE
	  ,MD_RUN_CODE
	  ,MD_PACK_NAME
	)

	VALUES
	(
		 b.[Event_id]
		,b.[Area_ids]
		,b.[CreatedAt]
		,b.[ExpiresAt]
		,b.[GeocodeCity]
		,b.[GeocodeCountryCode]
		,b.[GeocodeLabel]
		,b.[GeocodePostcode]
		,b.[GeocodeRoad]
		,b.[GeocodeState]
		,b.[Latitude]
		,b.[Longitude]
		,b.[timestamp]
		,b.[Type]
		,b.[Updatedate]
		,b.[dim_LH_User_key]
		,b.[dim_LH_Location_key]
		,b.[Signal_major]
		,b.[Signal_minor]
		,b.[Signal_uuid]
		,b.[Zone_id]
		,b.[GeocodeSuburb]
		,b.[GpsTimestamp]
		,b.[dim_LH_Area_key]
		,b.[Application_id] 
		,getdate()
		,getdate()
		,@p_job 
		,@p_run
		,@p_pack
	)

;

END
;