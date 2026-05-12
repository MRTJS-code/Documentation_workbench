-- =============================================
-- Author:		Tony Smith
-- Create date: December 2025
-- Description:	Procedue for dynamic QA table updates
-- =============================================
CREATE PROCEDURE [qa].[ProcessQualityIssues]
	-- Add the parameters for the stored procedure here
	@qaCode int,
	@sourceSys varchar(50),
	@sourceObject sysname,
	@urlTemplate varchar (500),
	@runDate datetime,
	@SourcePKcolumn sysname,
	@HeaderFKColumn sysname,
	@qaTable qa.QualityIssueCapture READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;

	CREATE TABLE #newQAHead (RecordId int, HeaderId bigint);
	DECLARE		@sql nvarchar(max);
	DECLARE		@sourceSchema sysname;
	DECLARE		@sourceTable sysname;
	DECLARE		@qaTableUpdate qa.QualityIssueCapture;
	DECLARE		@qaDetailIdList TABLE (RecordId int, HeaderId bigint)
    
	-- Parse SourceSchema, SourceTable & writeable qa table
	SET			@sourceSchema = PARSENAME(@sourceObject,2);
	SET			@sourceTable = PARSENAME(@sourceObject,1);
	INSERT INTO @qaTableUpdate SELECT * FROM @qaTable;

	-- Insert new quality header records where they do not exists
	WITH DistinctIssues AS (
		SELECT DISTINCT RecordId, FKQualityHeader
		FROM	@qaTable
	)
	INSERT INTO qa.QualityHeader
	OUTPUT		Inserted.objectId, Inserted.Id
	INTO		#newQAHead
	SELECT		@sourceSys,
				r.RecordId,
				@sourceObject,
				CASE WHEN @urlTemplate is NULL THEN NULL ELSE REPLACE(@urlTemplate, '{0}', CONVERT(VARCHAR(20), r.RecordId)) END
	FROM		DistinctIssues r
	WHERE		r.FKQualityHeader is NULL

	-- Push QA Header inserts back to dw table & qa update table
	SET @sql = 'UPDATE src
				SET     ' + QUOTENAME(@HeaderFkColumn) + ' = m.HeaderId
				FROM    ' + QUOTENAME(@sourceSchema) + '.' + QUOTENAME(@sourceTable) + ' AS src
				INNER JOIN    #newQAHead AS m ON src.' + QUOTENAME(@SourcePkColumn) + ' = m.RecordId
				WHERE   src.' + QUOTENAME(@HeaderFkColumn) + N' IS NULL;';

    EXEC sp_executesql @sql;

	UPDATE t SET FKQualityHeader = s.HeaderId FROM @qaTableUpdate t INNER JOIN #newQAHead s ON t.RecordId = s.RecordId;

	-- Re-open existing QA details that are now active
	UPDATE		t
	SET			t.dateResolved = null, 
				t.dateFound = @runDate,
				t.autoFixEventAt = null,
				t.autoFixEventId = null,
				t.autoFixMessage = null,
				t.autoFixSuccess = null,
				t.qaSummary = s.Summary,
				t.qaDetail = null,
				t.qaSeverity = s.severity,
				t.retryValue = s.RetryValue,
				t.retryMax = s.RetryMax,
				t.hasBillingAdjustment = null,
				t.hasPayrollAdjustment = null,
				t.modifiedBy = 'Dwh ETL',
				t.modifiedDate = @runDate
	FROM		qa.QualityDetail t
	INNER JOIN	@qaTable s ON t.Id = s.FkQualityDetail
	WHERE		s.DateResolved is not null;

	-- Mark Complete where the QA issue has disppeared
	UPDATE		t
	SET			t.dateResolved = @runDate,
				t.modifiedBy = 'Dwh ETL',
				t.modifiedDate = @runDate
	FROM		qa.QualityDetail t
	WHERE		t.qaCode = @qaCode
	AND			t.dateResolved IS NULL
	AND			NOT EXISTS (
		SELECT	1
		FROM	@qaTable s
		WHERE	s.FkQualityDetail = t.Id
	);

	-- Insert new QA details
	WITH		NewIssues AS (
        SELECT	i.*
        FROM	@qaTableUpdate i
        WHERE	i.FkQualityDetail IS NULL
    )
    INSERT INTO qa.QualityDetail
    (
				FK_Header,
				qaSeverity,
				dateFound,
				dateResolved,
				qaCode,
				qaSummary,
				retryValue,
				retryMax,
				createdBy,
		        modifiedBy,
		        createdDate,
				modifiedDate
    )
	OUTPUT		inserted.Id qualityDetailId, inserted.FK_Header 
	INTO		@qaDetailIdList
    SELECT
				n.FKQualityHeader AS FK_Header,
				n.Severity AS qaSeverity,
				@RunDate AS dateFound,
				NULL AS dateResolved,
		        @QaCode AS qaCode,
				n.Summary AS qaSummary,
		        0 AS retryValue,
				0 AS retryMax,
				n.Creator AS createdBy,
				NULL AS modifiedBy,
				@RunDate AS createdDate,
				@RunDate AS modifiedDate
    FROM		NewIssues n;

	-- Add existing qa detail Ids to output table
	INSERT INTO @qaDetailIdList
	SELECT FkQualityDetail, FKQualityHeader FROM @qaTableUpdate WHERE FkQualityDetail is not null;

	-- Return updated Result Set
	SELECT * FROM @qaDetailIdList;
END