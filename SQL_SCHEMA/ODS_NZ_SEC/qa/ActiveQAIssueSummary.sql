
-- =============================================
-- Author:		Tony Smith
-- Create date: April 2026
-- Description:	Returns a summary of open QA issues for transactions within the specified tables
-- =============================================
CREATE PROCEDURE [qa].[ActiveQAIssueSummary]
	-- Add the parameters for the stored procedure here
	@tableList nvarchar(MAX), -- List of source tables surrounded with single quotes and separated with commas - no white spaces as an exact match is expected
	@qaIssueIds nvarchar(MAX) = null -- Optional list of qaCode id numbers.  If not supplied all qa types are checked
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--DECLARE					@tableList varchar(50) = '''dw.FACT_TIMESHEET'', ''dw.FACT_ROSTER''';
	--DECLARE					@qaIssueIds nvarchar(MAX) ='2,3,5';
	DECLARE					@columns NVARCHAR(MAX),@sql NVARCHAR(MAX), @colSum NVARCHAR(MAX), @colSearch NVARCHAR(MAX);

	-- create dynamic pivot lists
	SELECT					@columns = STRING_AGG(QUOTENAME(qaName), ',')
	FROM (					SELECT * FROM qa.QualityType WHERE Id IN (SELECT value FROM string_split(@qaIssueIds,',')) OR @qaIssueIds is null) AS types;

	SELECT					@colSearch = STRING_AGG(Id, ',')
	FROM (					SELECT * FROM qa.QualityType WHERE Id IN (SELECT value FROM string_split(@qaIssueIds,',')) OR @qaIssueIds is null) AS types;

	SELECT					@colSum = '(' + STRING_AGG(QUOTENAME(qaName), '+') + ')'
	FROM (					SELECT * FROM qa.QualityType WHERE Id IN (SELECT value FROM string_split(@qaIssueIds,',')) OR @qaIssueIds is null) AS types;

	SET @sql = ';WITH subQry AS (
	    SELECT		qh.Id        AS qaTrackingId,
					qh.objectId  AS sourceTransId,
					qh.objectTable AS sourceTable,
					qt.qaName
		FROM		qa.QualityHeader  AS qh
		INNER JOIN	qa.QualityDetail AS qd ON qh.Id = qd.FK_Header AND qd.dateResolved IS NULL
		INNER JOIN	qa.QualityType AS qt ON qd.qaCode = qt.Id
		WHERE		qh.objectTable IN ('+ @tableList +')
		AND			qt.Id IN ('+ @colSearch +')
	),
	qryPivot AS (
	SELECT			p.qaTrackingId,
					p.sourceTransId,
					p.sourceTable,
					'+ @columns +'
	FROM			subQry
	PIVOT (			COUNT(qaName)
	FOR				qaName IN ('+ @columns +')) AS p
	)
	SELECT			*,
					'+ @colSum +' AS totalIssues
	FROM			qryPivot
	;';

	EXEC sp_executesql @sql;
	
END