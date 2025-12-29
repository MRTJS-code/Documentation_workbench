

-- =============================================
-- Author:		<Cha Sy>
-- Create date: <23 Aug 2023>
-- Description:	<Truncate DRAFT BUDGET table in preparation for loading new data>
-- =============================================
CREATE PROCEDURE [dw].[TRUNCATE_FCT_DRAFTBUDGET]
AS
BEGIN
	TRUNCATE TABLE ods.FCT_DRAFTBUDGET;
END
