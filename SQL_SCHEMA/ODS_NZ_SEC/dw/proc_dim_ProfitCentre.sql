
-- ========================================================
-- Author:		Crispin Nicodemus 
-- Create date: 2023-01-31 
-- Description:	stored proc for building dim_Profit Center
-- =========================================================
CREATE PROCEDURE [dw].[proc_dim_ProfitCentre]
	-- Add the parameters for the stored procedure here
	@p_job int,  
	@p_run int,	
	@p_pack varchar(70)	
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;

BEGIN

MERGE INTO dw.DIM_PROFITCENTRE a
USING staging.STG_GT_ProfitCentre b
ON (a.P_oid_clsno = b.oid_clsno and a.P_oid_instid = b.oid_instid)
WHEN NOT MATCHED THEN
	INSERT (
	P_oid_clsno, 
	P_oid_instid, 
	P_code,
	P_glAccount,
	P_name,
	P_bRCode,
	P_bsCode,
	P_brId,
	P_bsid,
	MD_DATE_CREATED,
	MD_DATE_MODIFIED,
	MD_JOB_CODE, 
	MD_RUN_CODE,
	MD_PACK_NAME
	)
	VALUES
	(
	oid_clsno,
	oid_instid, 
    b.[code],
    b.[glAccount],
    b.[name],
    b.[brCode],
    b.[bsCode],
    isnull(b.[brId],0),
    isnull(b.[bsId],0),
	getdate(),
	getdate(),
	@p_job, 
	@p_run,
	@p_pack)

WHEN MATCHED AND 
	(isnull(P_glAccount,'') <> isnull(b.glAccount,'') or 
	 isnull(P_name,'')      <> isnull(b.name,'') or
	 isnull(P_bRCode,'')    <> isnull(b.bRCode,'') or
	 isnull(P_bsCode,'')    <> isnull(bsCode,'')
	)
 THEN UPDATE SET
 	P_glAccount = b.glAccount,
	P_name      = b.name,
	P_bRCode    = b.bRCode,
	P_bsCode    = bsCode
    ,[MD_DATE_CREATED] = getdate()
    ,[MD_DATE_MODIFIED] = getdate()
    ,[MD_JOB_CODE] = @p_job
    ,[MD_RUN_CODE] = @p_run
	,[MD_PACK_NAME] = @p_pack
;

-- Update brId based on branch and business
UPDATE			pc
SET				pc.P_brId = br.SK_DIM_BRANCH
FROM			dw.DIM_BRANCH br
INNER JOIN		dw.DIM_PROFITCENTRE pc
ON				br.P_Branch = pc.P_brCode 
AND				br.[P_Business Code] = pc.P_bsCode 
;
-- Update remaining null brId based on branch
UPDATE			pc
SET				pc.P_brId = br.SK_DIM_BRANCH
FROM			dw.DIM_BRANCH br
INNER JOIN		dw.DIM_PROFITCENTRE pc
ON				br.P_Branch = pc.P_brCode AND br.[P_Business Code] is NULL
WHERE			isnull(pc.P_brId,0) = 0
;
-- Update bsId based on branch and business
UPDATE			pc
SET				pc.P_bsId = bs.SK_DIM_BUSINESS
FROM			dw.DIM_BUSINESS bs
INNER JOIN		dw.DIM_PROFITCENTRE pc
ON				bs.P_Branch = pc.P_brCode
AND				bs.[P_Business Code] = pc.P_bsCode
;
-- Update remaining null bsId based on business
UPDATE			pc
SET				pc.P_bsId = bs.SK_DIM_BUSINESS
FROM			dw.DIM_BUSINESS bs
INNER JOIN		dw.DIM_PROFITCENTRE pc
ON				bs.[P_Business Code] = pc.P_bsCode AND bs.P_Branch is NULL
WHERE			isnull(pc.P_bsId,0) = 0
;

END
;