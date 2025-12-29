

-- =============================================
-- Author:		<Tony Smith>
-- Create date: <9 October 2020>
-- Description:	<Extract combination of actual and budget for Reforecast build>
-- =============================================
CREATE PROCEDURE [ods].[UPDATE_DRAFT_FORECAST]
	-- Add the parameters for the stored procedure here
	(@forecastYear int, @actualQtrEnd int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

SELECT * INTO #tmpForecast
FROM ods.FCT_DRAFTBUDGET;

TRUNCATE TABLE ods.FCT_DRAFTBUDGET;

INSERT INTO ods.FCT_DRAFTBUDGET
SELECT forGL.*
FROM #tmpForecast forGL
INNER JOIN ods.DIM_GT_PERIOD per ON per.stDate = forGL.Date
WHERE per.yearNo = @forecastYear
AND per.mnthNo > @actualQtrEnd;

INSERT INTO ods.FCT_DRAFTBUDGET
	SELECT *
	FROM (SELECT
		pr.stDate as ['Date'],
		jo.code as Jobcode,
		gl.accountNo as GTGL,
		NULL as gtCust,
		-sum(glt.tranNetAmount) as Amount,
		('Base Build') as [source]
	FROM ods.FCT_GLTRANS glt
	INNER JOIN ods.DIM_GT_PERIOD pr ON glt.period = pr.oid
	INNER JOIN ods.DIM_GT_GL gl on glt.glAccount = gl.oid
	INNER JOIN ods.DIM_GT_COA gtCoa on gl.coaID = gtCoa.id
	INNER JOIN ods.DIM_AX_COA axCOA on gtCoa.axGLAcc = axCOA.axGLAcc
	LEFT JOIN ods.DIM_JOB jo ON glt.job = jo.oid
	--LEFT JOIN ods.DIM_ORGANISATION orn ON glt.organisation = orn.oid
	WHERE pr.yearNo = @forecastYear
	AND pr.mnthNo <= @actualQtrEnd
	AND axCOA.glReport = 'PNL'
	GROUP BY pr.stDate , jo.code, gl.accountNo) glExt
	WHERE glExt.Amount !=0;

DROP TABLE #tmpForecast;
END
