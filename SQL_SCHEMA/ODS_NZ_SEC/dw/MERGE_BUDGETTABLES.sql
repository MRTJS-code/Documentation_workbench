


-- =============================================
-- Author:		<Cha Sy>
-- Create date: <23 Aug 2023>
-- Description:	<Merge the uploaded csv data to get the sks from the dim tables>
-- =============================================
CREATE PROCEDURE [dw].[MERGE_BUDGETTABLES]
AS
BEGIN

UPDATE [ODS_NZ_SEC].[ods].[FCT_DRAFTBUDGET] 
SET 
	DATE = D.SK_DIM_DATE
	,JobCode = J.SK_DIM_JOB
	,GTGL = G.SK_DIM_GT_GL
	,GTCUST = iif(GTCUST IS NULL,0,SK_DIM_Organisation)
FROM [ODS_NZ_SEC].[ods].[FCT_DRAFTBUDGET] F
	LEFT JOIN DW.DIM_DATE D ON D.PK_Date = F.Date
	LEFT JOIN dw.DIM_JOB J ON J.P_jobCode = F.JobCode
	LEFT JOIN DW.DIM_GT_GL G ON G.P_Account_No = F.GTGL
	LEFT JOIN DW.DIM_ORGANISATION O ON O.P_Code = F.gtCust AND O.P_Type = 'Customer' ;
END