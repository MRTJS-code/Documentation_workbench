



-- ====================================================
-- Author:		Crispin Nicodemus 
-- Create date: 2023-04-18 
-- Description:	stored proc for building dim_LH_Shift
-- ====================================================
CREATE PROCEDURE [dw].[proc_fact_LH_Shift]
	-- Add the parameters for the stored procedure here
	@p_job int,  
	@p_run int,	
	@p_pack varchar(70)	
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;

If(OBJECT_ID('tempdb..#tempLHShift') Is Not Null)
Begin
 DROP TABLE #tempLHShift
End
	
BEGIN
SELECT DISTINCT 
     User_email
      ,[Firstname]
      ,[Lastname]
      ,[User_id]
      ,[Shift_id]
      ,[Application_id]
      ,[Shift_duration]
      ,[End_area_name]
      ,[End_gps_coordinate]
      ,[End_road]
      ,[End_suburb]
      ,[End_city]
      ,[End_state]
      ,[End_county]
      ,[End_postcode]
      ,[End_countrycode]
      ,[End_time]
      ,[Start_area_name]
      ,[Start_gps_coordinate]
      ,[Start_road]
      ,[Start_suburb]
      ,[Start_city]
      ,[Start_state]
      ,[Start_county]
      ,[Start_postcode]
      ,[Start_countrycode]
      ,[Start_time]
 --      no location id, assemble based on road, suburb, city, country?
 --     ,b.SK_DIM_LH_LOCATION as  [dim_LH_start_Location_key]
 --     ,c.SK_DIM_LH_LOCATION as  [dim_LH_end_Location_key]
      ,isnull(d.SK_DIM_LH_AREA,0) as [dim_LH_start_Area_key]
      ,isnull(e.SK_DIM_LH_AREA,0) as [dim_LH_end_Area_key]
      ,isnull(f.SK_DIM_LH_User,0) as [dim_LH_User_key]

INTO #tempLHShift
FROM staging.LH_SHIFT
--LEFT JOIN dw.DIM_LH_LOCATION b on staging.LH_SHIFT.Location_id = b.P_Location_id
--LEFT JOIN dw.DIM_LH_LOCATION c on staging.LH_SHIFT.Location_id = b.P_Location_id
LEFT JOIN dw.DIM_LH_AREA d on staging.LH_SHIFT.[Start_Area_name] = d.P_Area_name
LEFT JOIN dw.DIM_LH_AREA e on staging.LH_SHIFT.[End_Area_name] = e.P_Area_name
LEFT JOIN dw.DIM_LH_USER f on staging.LH_SHIFT.[Firstname] = f.P_Firstname and staging.LH_SHIFT.[Lastname] = f.P_Lastname


MERGE INTO dw.FACT_LH_shift a
USING #tempLHshift b
ON a.P_shift_id = b.shift_id and 
isnull(a.[P_End_time], '') = isnull(b.End_time, '') and
isnull(a.[P_Start_time], '') = isnull(b.Start_time, '')

WHEN MATCHED AND
	(
    isnull(a.[dim_LH_start_Area_key],0) <>  isnull(b.[dim_LH_start_Area_key],0) or
    isnull(a.[dim_LH_end_Area_key],0) <> isnull(b.[dim_LH_end_Area_key],0) or
    isnull(a.[dim_LH_User_key],0) <> isnull(b.[dim_LH_User_key],0) or
	isnull(a.P_Application_id, '') <> isnull(b.Application_id, '') or
    isnull(a.[P_Shift_duration], '') <> isnull(b.[Shift_duration], '') or 
    isnull(a.[P_End_gps_coordinate], '') <> isnull(b.End_gps_coordinate, '') or
    isnull(a.[P_End_road], '') <> isnull(b.End_road, '') or
    isnull(a.[P_End_suburb], '') <> isnull(b.End_suburb, '') or
    isnull(a.[P_End_city], '') <> isnull(b.End_city, '') or
    isnull(a.[P_End_state], '') <> isnull(b.End_state, '') or
    isnull(a.[P_End_county], '') <> isnull(b.End_county, '') or
    isnull(a.[P_End_postcode], '') <> isnull(b.End_postcode, '') or
    isnull(a.[P_End_countrycode], '') <> isnull(b.End_countrycode, '') or
    isnull(a.[P_Start_gps_coordinate], '') <> isnull(b.Start_gps_coordinate, '') or
    isnull(a.[P_Start_road], '') <> isnull(b.Start_road, '') or
    isnull(a.[P_Start_suburb], '') <> isnull(b.Start_suburb, '') or
    isnull(a.[P_Start_city], '') <> isnull(b.Start_city, '') or
    isnull(a.[P_Start_state], '') <> isnull(b.Start_state, '') or
    isnull(a.[P_Start_county], '') <> isnull(b.Start_county, '') or
    isnull(a.[P_Start_postcode], '') <> isnull(b.Start_postcode, '') or
    isnull(a.[P_Start_countrycode], '') <> isnull(b.Start_countrycode, '') 
	)
 THEN UPDATE SET
	a.P_Application_id = b.Application_id,
    a.[P_Shift_duration] = b.[Shift_duration],
	a.[dim_LH_start_Area_key] = isnull(b.[dim_LH_start_Area_key],0),
	a.[dim_LH_end_Area_key] = isnull(b.[dim_LH_end_Area_key],0),
	a.[dim_LH_User_key] = isnull(b.[dim_LH_User_key],0),

    a.[P_End_gps_coordinate] = b.End_gps_coordinate,
    a.[P_End_road] = b.End_road,
    a.[P_End_suburb] = b.End_suburb,
    a.[P_End_city] = b.End_city,
    a.[P_End_state] = b.End_state,
    a.[P_End_county] = b.End_county,
    a.[P_End_postcode] = b.End_postcode,
    a.[P_End_countrycode] = b.End_countrycode,
    a.[P_End_time] = b.End_time,
    a.[P_Start_gps_coordinate] = b.Start_gps_coordinate,
    a.[P_Start_road] = b.Start_road,
    a.[P_Start_suburb] = b.Start_suburb,
    a.[P_Start_city] = b.Start_city,
    a.[P_Start_state] = b.Start_state,
    a.[P_Start_county] = b.Start_county,
    a.[P_Start_postcode] = b.Start_postcode,
    a.[P_Start_countrycode] = b.Start_countrycode,
    a.[P_Start_time] = b.Start_time   

	,[MD_DATE_CREATED] = getdate()
    ,[MD_DATE_MODIFIED] = getdate()
    ,[MD_JOB_CODE] = @p_job
    ,[MD_RUN_CODE] = @p_run
	,[MD_PACK_NAME] = @p_pack

WHEN NOT MATCHED THEN
	INSERT 
	(
--	[dim_LH_start_location_key] [bigint] NULL,
--	[dim_LH_end_location_key] [bigint] NULL,
 	   [dim_LH_start_Area_key]
	  ,[dim_LH_end_Area_key]
	  ,[dim_LH_User_key]
      ,[P_Shift_id]
      ,[P_Application_id]
      ,[P_Shift_duration]
      ,[P_End_gps_coordinate]
      ,[P_End_road]
      ,[P_End_suburb]
      ,[P_End_city]
      ,[P_End_state]
      ,[P_End_county]
      ,[P_End_postcode]
      ,[P_End_countrycode]
      ,[P_End_time]
      ,[P_Start_gps_coordinate]
      ,[P_Start_road]
      ,[P_Start_suburb]
      ,[P_Start_city]
      ,[P_Start_state]
      ,[P_Start_county]
      ,[P_Start_postcode]
      ,[P_Start_countrycode]
      ,[P_Start_time]

	  ,MD_DATE_CREATED
	  ,MD_DATE_MODIFIED
	  ,MD_JOB_CODE
	  ,MD_RUN_CODE
	  ,MD_PACK_NAME
	)

	VALUES
	(
  	   isnull(b.[dim_LH_start_Area_key], 0)
	  ,isnull(b.[dim_LH_end_Area_key], 0)
	  ,isnull(b.[dim_LH_User_key], 0)
      ,b.[Shift_id]
      ,b.[Application_id]
      ,b.[Shift_duration]
      ,b.[End_gps_coordinate]
      ,b.[End_road]
      ,b.[End_suburb]
      ,b.[End_city]
      ,b.[End_state]
      ,b.[End_county]
      ,b.[End_postcode]
      ,b.[End_countrycode]
      ,b.[End_time]
      ,b.[Start_gps_coordinate]
      ,b.[Start_road]
      ,b.[Start_suburb]
      ,b.[Start_city]
      ,b.[Start_state]
      ,b.[Start_county]
      ,b.[Start_postcode]
      ,b.[Start_countrycode]
      ,b.[Start_time]
	  ,getdate()
	  ,getdate()
  	  ,@p_job 
	  ,@p_run
	  ,@p_pack
	)

;

END
;