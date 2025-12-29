

-- =============================================
-- Author:		Crispin Nicodemus 
-- Create date: 2023-04-28 
-- Description:	stored proc for building dim_job_price
-- =============================================
CREATE PROCEDURE [dw].[proc_dim_Job_Price]
	-- Add the parameters for the stored procedure here
	@p_job int,  
	@p_run int,	
	@p_pack varchar(70)	
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;

If(OBJECT_ID('tempdb..#tempPrice') Is Not Null)
Begin
 DROP TABLE #tempPrice
End
	
BEGIN
SELECT 
     [Oid_clsno]
	,[Oid_instid]
	,[PriceCode]
	,[PriceName]
	,[ordRate]
	,[T15Rate]
INTO #tempPrice
FROM staging.STG_JOB_PRICE

MERGE INTO dw.DIM_JOB_PRICE a
USING #tempPrice b
ON (a.[P_Oid_clsno] = b.[Oid_clsno] and a.[P_Oid_instid] = b.[Oid_instid])

WHEN NOT MATCHED THEN
	INSERT (
     [P_Oid_clsno]
	,[P_Oid_instid]
	,[P_PriceCode]
	,[P_PriceName]
	,[P_ordRate]
	,[P_T15Rate],
	MD_DATE_CREATED,
	MD_DATE_MODIFIED,
	MD_JOB_CODE, 
	MD_RUN_CODE,
	MD_PACK_NAME
	)
	VALUES
	(
     b.[Oid_clsno]
	,b.[Oid_instid]
	,b.[PriceCode]
	,b.[PriceName]
	,isnull(b.[ordRate],0)
	,isnull(b.[T15Rate],0),
	getdate(),
	getdate(),
	@p_job, 
	@p_run,
	@p_pack)

WHEN MATCHED AND 
	(
	 isnull([P_PriceCode], '') <> isnull([PriceCode], '') OR
	 isnull([P_PriceName], '') <> isnull([PriceName], '') OR
	 isnull([P_ordRate],0) <> isnull([ordRate], 0) OR
	 isnull([P_T15Rate],0) <> isnull([T15Rate],0) 
	)

THEN UPDATE SET
	 [P_PriceCode] = b.[PriceCode],
	 [P_PriceName] = b.[PriceName],
	 [P_ordRate] = isnull(b.[ordRate],0),
	 [P_T15Rate] = isnull(b.[T15Rate],0)
    ,[MD_DATE_CREATED] = getdate()
    ,[MD_DATE_MODIFIED] = getdate()
    ,[MD_JOB_CODE] = @p_job
    ,[MD_RUN_CODE] = @p_run
	,[MD_PACK_NAME] = @p_pack
;
END
;
