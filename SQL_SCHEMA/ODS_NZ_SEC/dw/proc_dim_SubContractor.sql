

-- =============================================
-- Author:		Crispin Nicodemus 
-- Create date: 2023-04-20 
-- Description:	stored proc for building dim_SubContractor
-- =============================================
CREATE PROCEDURE [dw].[proc_dim_SubContractor]
	-- Add the parameters for the stored procedure here
	@p_job int,  
	@p_run int,	
	@p_pack varchar(70)	
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;

If(OBJECT_ID('tempdb..#tempSubContractor') Is Not Null)
Begin
 DROP TABLE #tempSubContractor
End
	
BEGIN
SELECT	SubContractorName, 
		ORD_RatePerHour,
		PH_RatePerHour,
		Per_Revenue
INTO #tempSubContractor
FROM staging.STG_SubContractor

MERGE INTO dw.DIM_SUBCONTRACTOR a
USING #tempSubContractor b
ON (a.P_SubContractorname = b.SubContractorName)

WHEN NOT MATCHED THEN
	INSERT (
	P_SubContractorName,
    P_ORD_RatePerHour,
	P_PH_RatePerHour,
	P_Per_Revenue,
	MD_DATE_CREATED,
	MD_DATE_MODIFIED,
	MD_JOB_CODE, 
	MD_RUN_CODE,
	MD_PACK_NAME
	)
	VALUES
	(
	b.SubContractorname,
    b.ORD_RatePerHour,
	b.PH_RatePerHour,
	b.Per_Revenue,
	getdate(),
	getdate(),
	@p_job, 
	@p_run,
	@p_pack)

WHEN MATCHED AND (
	isnull(a.P_ORD_RatePerHour,0) != isnull(b.ORD_RatePerHour,0)
OR	isnull(a.P_PH_RatePerHour,0) != isnull(b.PH_RatePerHour,0)
OR	isnull(a.P_Per_Revenue,0) != isnull(b.Per_Revenue,0)) THEN
UPDATE SET
	a.P_ORD_RatePerHour = b.ORD_RatePerHour,
	a.P_PH_RatePerHour = b.PH_RatePerHour,
	a.P_Per_Revenue = b.Per_Revenue,
	a.MD_DATE_MODIFIED = getdate(),
	a.MD_JOB_CODE = @p_job,
	a.MD_RUN_CODE = @p_run,
	a.MD_PACK_NAME = @p_pack

--WHEN NOT MATCHED BY SOURCE THEN
--	UPDATE SET 
--		a.MD_LOGICAL_DELETE = 1, 
--		a.MD_DATE_MODIFIED = getDate(),
--		a.MD_JOB_CODE = @p_job,
--		a.MD_RUN_CODE = @p_run,
--		a.MD_PACK_NAME = @p_pack;
;
END
;
