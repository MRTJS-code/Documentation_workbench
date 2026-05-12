

-- =============================================
-- Author:		<Tony Smith>
-- Create date: <9 October 2020>
-- Description:	<Extract combination of actual and budget for Reforecast build>
-- =============================================
CREATE PROCEDURE [dw].[BUILD_BASE_DRAFTBUDGET]
	-- Add the parameters for the stored procedure here
	(@forecastYear int, @actualQtrEnd int, @forSource varchar(1))
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	TRUNCATE TABLE dw.FCT_DRAFTBUDGET;
	
	INSERT INTO dw.FACT_DRAFTBUDGET
	SELECT *
	FROM (SELECT
		glt.FK_DIM_GT_PERIOD,
		glt.FK_DIM_JOB,
		glt.FK_DIM_GT_GL,
		NULL as FK_DIM_ORGANISATION,
		-sum(glt.P_Amount_Net) as Amount,
		('Base Build') as [source]
	FROM dw.FACT_GLTRANS glt
	INNER JOIN dw.DIM_GT_PERIOD pr ON glt.FK_DIM_GT_PERIOD = pr.SK_DIM_GT_PERIOD
	INNER JOIN dw.DIM_GT_GL gl on glt.FK_DIM_GT_GL = gl.SK_DIM_GT_GL
	INNER JOIN dw.DIM_GT_COA gtCoa on gl.FK_DIM_GT_COA = gtCoa.SK_DIM_GT_COA
	INNER JOIN dw.DIM_AX_COA axCOA on gtCoa.FK_DIM_AX_COA = axCOA.SK_DIM_AX_COA
	WHERE pr.P_Year_No = @forecastYear
	AND pr.P_Month_No <= @actualQtrEnd
	AND axCOA.P_FS_GL_Report = 'PNL'
	GROUP BY glt.FK_DIM_GT_PERIOD,
		glt.FK_DIM_JOB,
		glt.FK_DIM_GT_GL) glExt
	WHERE glExt.Amount !=0

IF @forSource = 'B'
	INSERT INTO dw.FACT_DRAFTBUDGET
	SELECT *
	FROM (SELECT
		glt.FK_DIM_GT_PERIOD,
		glt.FK_DIM_JOB,
		glt.FK_DIM_GT_GL,
		NULL as FK_DIM_ORGANISATION,
		sum(glt.total) as Amount,
		('Base Build') as [source]
	FROM dw.FACT_BUDGET glt
	INNER JOIN dw.DIM_GT_PERIOD pr ON glt.FK_DIM_GT_PERIOD = pr.SK_DIM_GT_PERIOD
	INNER JOIN dw.DIM_GT_GL gl on glt.FK_DIM_GT_GL = gl.SK_DIM_GT_GL
	INNER JOIN dw.DIM_GT_COA gtCoa on gl.FK_DIM_GT_COA = gtCoa.SK_DIM_GT_COA
	INNER JOIN dw.DIM_AX_COA axCOA on gtCoa.FK_DIM_AX_COA = axCOA.SK_DIM_AX_COA
	WHERE pr.P_Year_No = @forecastYear
	AND pr.P_Month_No <= @actualQtrEnd
	AND axCOA.P_FS_GL_Report = 'PNL'
	GROUP BY glt.FK_DIM_GT_PERIOD,
		glt.FK_DIM_JOB,
		glt.FK_DIM_GT_GL) glExt
	WHERE glExt.Amount !=0;
ELSE -- User will enter 'F'
	INSERT INTO dw.FACT_DRAFTBUDGET
	SELECT *
	FROM (SELECT
		glt.FK_DIM_GT_PERIOD,
		glt.FK_DIM_JOB,
		glt.FK_DIM_GT_GL,
		NULL as FK_DIM_ORGANISATION,
		sum(glt.total) as Amount,
		('Base Build') as [source]
	FROM dw.FACT_FORECAST glt
	INNER JOIN dw.DIM_GT_PERIOD pr ON glt.FK_DIM_GT_PERIOD = pr.SK_DIM_GT_PERIOD
	INNER JOIN dw.DIM_GT_GL gl on glt.FK_DIM_GT_GL = gl.SK_DIM_GT_GL
	INNER JOIN dw.DIM_GT_COA gtCoa on gl.FK_DIM_GT_COA = gtCoa.SK_DIM_GT_COA
	INNER JOIN dw.DIM_AX_COA axCOA on gtCoa.FK_DIM_AX_COA = axCOA.SK_DIM_AX_COA
	WHERE pr.P_Year_No = @forecastYear
	AND pr.P_Month_No <= @actualQtrEnd
	AND axCOA.P_FS_GL_Report = 'PNL'
	GROUP BY glt.FK_DIM_GT_PERIOD,
		glt.FK_DIM_JOB,
		glt.FK_DIM_GT_GL) glExt
	WHERE glExt.Amount !=0;
	END