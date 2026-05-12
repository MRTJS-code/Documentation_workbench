-- =============================================
-- Author:		Tony Smith
-- Create date: September 2022 - March 2023
-- Description:	Update Event Control table with data from Job Run
-- =============================================
CREATE PROCEDURE [eda].[UPDATE_EVENT_STATUS] 
	-- Add the parameters for the stored procedure here
	@executionId bigint,
	@eventStart datetime,
	@eventId int,
	@runCode int,
	@statusTxt varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

DECLARE				@currentStatus varchar(50)
DECLARE				@startDate datetime

SELECT				@currentStatus = EVENT_STATUS, @startDate = EVENT_DATE_START
FROM				eda.ETL_EVENT
WHERE				EVENT_ID = @eventId;

UPDATE				eda.ETL_EVENT
SET					EVENT_STATUS = @statusTxt,
					DATE_LAST_MODIFIED = SYSDATETIME(),
					EVENT_EXECUTION_ID = @executionID,
					EVENT_DATE_START = CASE @currentStatus WHEN 'NEW' THEN @eventStart ELSE @startDate END ,
					EVENT_DATE_END = CASE WHEN @statusTxt = 'Completed' THEN SYSDATETIME() ELSE NULL END,
					ETL_RUN_CODE = @runCode
WHERE				EVENT_ID = @eventId


END
