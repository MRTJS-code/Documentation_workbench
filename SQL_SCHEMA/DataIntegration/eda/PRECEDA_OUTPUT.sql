USE [DataIntegration]
GO

/****** Object:  StoredProcedure [eda].[PRECEDA_OUTPUT]    Script Date: 12/11/2025 14:18:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Tony Smith
-- Create date: September 2022 - October 2025
-- Description:	Output Deputy Run Data in Preceda Format
--				Headers contain column names needed for XML or CSV
--				Will only Output valid payroll timesheets from Deputy
-- =============================================
CREATE PROCEDURE [eda].[PRECEDA_OUTPUT] 
	-- Add the parameters for the stored procedure here
	@eventId int, --metadata for tracing / event debugging
	@extType varchar(20) -- standard = provide all Deputy data, payroll = provide unprocessed Deputy data from a payroll perspective
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

--Build hours split table
SELECT					t.Id,
						isnull(round(t.phHours*4,0)/4,0) phRemain,
						cast(0 as float) phBase,
						cast(0 as float) phNCR,
						cast(0 as float) phEMS,
						isnull(t.lineHours,t.timesheetHours) ordBase,
						isnull(t.ncrHours,0) ordNCR,
						isnull(t.emsHours,0) ordEMS
INTO					#hoursSplit
FROM					eda.EXT_DEP_FULL t
WHERE					t.MDEventId = @eventId
AND						t.TimeApproved = 1
AND						t.payActivityCode != 'OD' -- adjust if other allowance lines are added
AND						CASE WHEN @extType = 'All' THEN 0 ELSE isnull(t.Exported,0) END = 0
AND						ISNULL(t.LeaveRuleId,0) NOT IN (11,27,28,29,30,31)
AND						t.payCentre IN ('Employee Timesheets', 'Agency Timesheets')
AND 					isnull(t.timesheetHours,0) + isnull(t.phHours,0) > 0.12

--Fix scenario where phRemain > allocation hours
UPDATE					s
SET						phRemain = s.ordBase + s.ordNCR + s.ordEMS
FROM					#hoursSplit s
WHERE					s.phRemain > (s.ordBase + s.ordNCR + s.ordEMS);

--Calculate EMS Public Holiday Split
UPDATE					s
SET						phEMS =		CASE
										WHEN s.ordEMS > s.phRemain THEN s.phRemain
										ELSE s.ordEMS
									END,
						phRemain =	CASE 
										WHEN s.ordEMS > s.phRemain THEN 0
										ELSE s.phRemain - s.ordEMS
									END,
						ordEMS =	CASE 
										WHEN s.ordEMS > s.phRemain THEN s.ordEMS - s.phRemain
										ELSE 0
									END
FROM					#hoursSplit s
WHERE					s.phRemain > 0
AND						s.ordEMS > 0;

--Calculate NCR Public Holiday Split
UPDATE					s
SET						phNCR =		CASE
										WHEN s.ordNCR > s.phRemain THEN s.phRemain
										ELSE s.ordNCR
									END,
						ordNCR =	CASE
										WHEN s.ordNCR > s.phRemain THEN s.ordNCR - s.phRemain
										ELSE 0
									END,
						phRemain =	CASE 
										WHEN s.ordNCR > s.phRemain THEN 0
										ELSE s.phRemain - s.ordNCR
									END
FROM					#hoursSplit s
WHERE					s.phRemain > 0
AND						s.ordNCR > 0;

--Calculate Base Public Holiday Split
UPDATE					s
SET						phBase = s.phRemain,
						ordBase = s.ordBase - s.phRemain
FROM					#hoursSplit s
WHERE					s.phRemain > 0;

--Base ORD Extract
SELECT					'H' [Record Type],
						t.payrollId [ID Number],
						CAST(t.timesheetStart as Date) [Costing Date],
						CASE
							WHEN t.AreaProduct = 'EMS' AND isnull(t.TierRate,0) = 0 AND isnull(t.EMSRate,0) > isnull(t.SiteRate,0) THEN 'E1'
							WHEN t.AreaProduct = 'TRAIN' THEN '06'
							WHEN t.AreaProduct = 'NBORD' THEN 'NO'
							ELSE t.payActivityCode 
						END [Hours Code],
						h.ordBase [Hours Amount],
						CASE
							WHEN t.AreaProduct = 'EMS' AND isnull(t.TierRate,0) = 0 AND isnull(t.EMSRate,0) > isnull(t.SiteRate,0) THEN NULL
							WHEN isnull(t.TierRate,0) > 0 THEN t.TierRate
							WHEN t.SiteRate > t.BaseRate THEN t.SiteRate
							ELSE NULL
						END [Hourly Rate],
						CASE t.payActivityCode
							WHEN '01' THEN NULL
							ELSE CAST(t.timesheetStart as Date)
						END [Date From],
						CASE t.payActivityCode
							WHEN '01' THEN NULL
							ELSE CAST(t.timesheetStart as Date)
						END [Date To],
						CASE t.payActivityCode
							WHEN 'AW' THEN 'AL'
							WHEN 'AH' THEN 'AS'
							WHEN '24' THEN 'BV'
							WHEN 'PP' THEN 'PP'
							WHEN '21' THEN 'NM'
							WHEN '20' THEN 'NP'
							WHEN '19' THEN 'NS'
							WHEN 'SP' THEN 'OO'
							WHEN 'TL' THEN 'LL'
							WHEN 'LX' THEN 'NP'
							WHEN 'OL' THEN 'OO'
							WHEN 'ER' THEN 'OS'
							ELSE NULL
						END [Leave Reason],
						CASE
							WHEN t.payActivityCode = '25' OR t.payActivityCode = 'AH' THEN isnull(t.lineHours,t.timesheetHours) / dyLvHrs.totHours
						END [Leave Units],
						NULL [A/D Code],
						NULL [Units],
						NULL [Unit Rate],
						t.CostCentre [Account],
						'D' + CAST(t.Id as varchar(10)) [Labour Costing 3],
						SUBSTRING(t.locationName,5,10) [User Costing 1],
						SUBSTRING(t.areaName,0,10) [User Costing 2],
						NULL [Blank],
						t.BaseRate,
						t.EMSRate,
						t.SiteRate,
						t.TierRate,
						t.branchName,
						t.AreaRateName,
						t.TierRateName,
						t.locationName,
						t.areaName
FROM					eda.EXT_DEP_FULL t
LEFT JOIN	(

SELECT					t.payrollId,
						Cast(t.timesheetStart as Date) timesheetDate,
						sum(t.timesheetHours) totHours
FROM					eda.EXT_DEP_FULL t
WHERE					t.MDEventId = @eventId
AND						t.TimeApproved = 1
AND						isnull(t.Exported,0) = 0
AND						t.payActivityCode != 'OD'
AND						t.payCentre IN ('Employee Timesheets', 'Agency Timesheets')
AND 					isnull(t.lineHours,t.timesheetHours) > 0.12
GROUP BY				t.payrollId, Cast(t.timesheetStart as Date) 

			) dyLvHrs	ON t.payrollId = dyLvHrs.payrollId AND Cast(t.timesheetStart as Date) = dyLvHrs.timesheetDate
INNER JOIN				#hoursSplit h ON t.Id = h.Id AND h.ordBase > 0.12
WHERE					t.MDEventId = @eventId
--AND						t.id = 325454   --- temp code!!!!!
--AND						t.TimeApproved = 1
AND						t.payActivityCode != 'OD'
--AND						ISNULL(t.LeaveRuleId,0) NOT IN (11,27,28,29,30,31)
--AND						t.payCentre IN ('Employee Timesheets', 'Agency Timesheets')
--AND 					isnull(t.lineHours,t.timesheetHours) > 0.12


--Base Public Holiday Split Extract
UNION

SELECT					'H' [Record Type],
						t.payrollId [ID Number],
						CAST(t.timesheetStart as Date) [Costing Date],
						CASE
							WHEN t.AreaProduct = 'EMS' AND isnull(t.TierRate,0) = 0 AND isnull(t.EMSRate,0) > isnull(t.SiteRate,0) THEN 'E2'
							ELSE '38' 
						END [Hours Code],
						h.phBase [Hours Amount],
						CASE
							WHEN t.AreaProduct = 'EMS' AND isnull(t.TierRate,0) = 0 AND isnull(t.EMSRate,0) > isnull(t.SiteRate,0) THEN NULL
							WHEN isnull(t.TierRate,0) > 0 THEN t.TierRate
							WHEN t.SiteRate > t.BaseRate THEN t.SiteRate
							ELSE NULL
						END [Hourly Rate],
						NULL [Date From],
						NULL [Date To],
						NULL [Leave Reason],
						NULL [Leave Units],
						NULL [A/D Code],
						NULL [Units],
						NULL [Unit Rate],
						t.CostCentre [Account],
						'D' + CAST(t.Id as varchar(10)) [Labour Costing 3],
						SUBSTRING(t.locationName,5,10) [User Costing 1],
						SUBSTRING(t.areaName,0,10) [User Costing 2],
						NULL [Blank], 
						t.BaseRate,
						t.EMSRate,
						t.SiteRate,
						t.TierRate,
						t.branchName,
						t.AreaRateName,
						t.TierRateName,
						t.locationName,
						t.areaName
FROM					eda.EXT_DEP_FULL t
INNER JOIN				#hoursSplit h ON t.Id = h.Id AND h.phBase > 0.12
WHERE					t.MDEventId = @eventId
AND						t.payActivityCode != 'OD'


-- EMS Hours
UNION

SELECT					'H' [Record Type],
						t.payrollId [ID Number],
						CAST(t.timesheetStart as Date) [Costing Date],
						CASE
							WHEN isnull(t.TierRate,0) = 0 AND t.EMSRate > 0 AND t.EMSRate > isnull(t.SiteRate,0) THEN 'E1'
							WHEN t.AreaProduct = 'TRAIN' THEN '06'
							ELSE '01'
						END [Hours Code],
						h.ordEMS [Hours Amount],
						CASE
							WHEN isnull(t.TierRate,0) = 0 AND t.EMSRate > isnull(t.SiteRate,0) THEN NULL
							WHEN isnull(t.TierRate,0) > 0 THEN t.TierRate
							WHEN t.SiteRate > t.BaseRate THEN t.SiteRate
							ELSE NULL
						END [Hourly Rate],
						NULL [Date From],
						NULL [Date To],
						NULL [Leave Reason],
						NULL [Leave Units],
						NULL [A/D Code],
						NULL [Units],
						NULL [Unit Rate],
						SUBSTRING(t.CostCentre,1,4) + '50002' [Account],
						'D' + CAST(t.Id as varchar(10)) [Labour Costing 3],
						SUBSTRING(t.locationName,6,10) [User Costing 1],
						'EMS' [User Costing 2],
						NULL [Blank],
						t.BaseRate,
						t.EMSRate,
						t.SiteRate,
						t.TierRate,
						t.branchName,
						t.AreaRateName,
						t.TierRateName,
						t.locationName,
						t.areaName
FROM					eda.EXT_DEP_FULL t
INNER JOIN				#hoursSplit h ON t.Id = h.Id AND h.ordEMS > 0.12
WHERE					t.MDEventId = @eventId
--AND						t.TimeApproved = 1
--AND						isnull(t.Exported,0) = 0
AND						t.payActivityCode != 'OD'
--AND						ISNULL(t.LeaveRuleId,0) NOT IN (11,27,28,29,30,31)
--AND						t.payCentre IN ('Employee Timesheets', 'Agency Timesheets')
--AND						t.emsHours > 0.12


-- EMS Public Holiday Hours
UNION

SELECT					'H' [Record Type],
						t.payrollId [ID Number],
						CAST(t.timesheetStart as Date) [Costing Date],
						CASE
							WHEN isnull(t.TierRate,0) = 0 AND t.EMSRate > 0 AND t.EMSRate > isnull(t.SiteRate,0) THEN 'E2'
							ELSE '38'
						END [Hours Code],
						h.phEMS [Hours Amount],
						CASE
							WHEN isnull(t.TierRate,0) = 0 AND t.EMSRate > isnull(t.SiteRate,0) THEN NULL
							WHEN isnull(t.TierRate,0) > 0 THEN t.TierRate
							WHEN t.SiteRate > t.BaseRate THEN t.SiteRate
							ELSE NULL
						END [Hourly Rate],
						NULL[Date From],
						NULL [Date To],
						NULL [Leave Reason],
						NULL [Leave Units],
						NULL [A/D Code],
						NULL [Units],
						NULL [Unit Rate],
						SUBSTRING(t.CostCentre,1,4) + '50002' [Account],
						'D' + CAST(t.Id as varchar(10)) [Labour Costing 3],
						SUBSTRING(t.locationName,6,10) [User Costing 1],
						'EMS' [User Costing 2],
						NULL [Blank],
						t.BaseRate,
						t.EMSRate,
						t.SiteRate,
						t.TierRate,
						t.branchName,
						t.AreaRateName,
						t.TierRateName,
						t.locationName,
						t.areaName
FROM					eda.EXT_DEP_FULL t
INNER JOIN				#hoursSplit h ON t.Id = h.Id AND h.phEMS > 0.12
WHERE					t.MDEventId = @eventId
AND						t.payActivityCode != 'OD'


-- NCR Hours
UNION

SELECT					'H' [Record Type],
						t.payrollId [ID Number],
						CAST(t.timesheetStart as Date) [Costing Date],
						CASE
							WHEN t.AreaProduct = 'TRAIN' THEN '06'
							ELSE t.payActivityCode 
						END [Hours Code],
						h.ordNCR [Hours Amount],
						CASE
							WHEN isnull(r.PayAmount,0) > isnull(t.SiteRate,0) THEN r.PayAmount
							WHEN t.SiteRate > t.BaseRate THEN t.SiteRate
							ELSE NULL
						END [Hourly Rate],
						NULL [Date From],
						NULL [Date To],
						NULL [Leave Reason],
						NULL [Leave Units],
						NULL [A/D Code],
						NULL [Units],
						NULL [Unit Rate],
						SUBSTRING(t.CostCentre,1,4) + '10004' [Account],
						'D' + CAST(t.Id as varchar(10)) [Labour Costing 3],
						SUBSTRING(t.locationName,6,10) [User Costing 1],
						'NCR' [User Costing 2],
						NULL [Blank],
						t.BaseRate,
						t.EMSRate,
						t.SiteRate,
						isnull(r.PayAmount,0) TierRate,
						t.branchName,
						t.AreaRateName,
						t.TierRateName,
						t.locationName,
						t.areaName
FROM					eda.EXT_DEP_FULL t
INNER JOIN				#hoursSplit h ON t.Id = h.Id AND h.ordNCR > 0.12
LEFT JOIN				eda.LKP_DEP_ClientTier ct ON t.payrollId = ct.FK_SecurityGuard AND ct.FK_TierCard = 723 
							AND t.timesheetStart >= ct.EffectiveFrom AND t.timesheetStart <= isnull(ct.EffectiveTo,t.timesheetStart)
LEFT JOIN				eda.LKP_DEP_RateCard r ON ct.FK_TierCard = r.RateCode AND t.timesheetStart >= r.EffectiveFrom AND t.timesheetStart <= isnull(r.EffectiveTo,t.timesheetStart)
WHERE					t.MDEventId = @eventId
--AND						t.TimeApproved = 1
--AND						isnull(t.Exported,0) = 0
AND						t.payActivityCode != 'OD'
--AND						ISNULL(t.LeaveRuleId,0) NOT IN (11,27,28,29,30,31)
--AND						t.payCentre IN ('Employee Timesheets', 'Agency Timesheets')
--AND						t.ncrHours > 0.12


-- NCR Public Holiday Hours
UNION

SELECT					'H' [Record Type],
						t.payrollId [ID Number],
						CAST(t.timesheetStart as Date) [Costing Date],
						'38' [Hours Code],
						h.phNCR [Hours Amount],
						CASE
							WHEN isnull(r.PayAmount,0) > isnull(t.SiteRate,0) THEN r.PayAmount
							WHEN t.SiteRate > t.BaseRate THEN t.SiteRate
							ELSE NULL
						END [Hourly Rate],
						NULL [Date From],
						NULL [Date To],
						NULL [Leave Reason],
						NULL [Leave Units],
						NULL [A/D Code],
						NULL [Units],
						NULL [Unit Rate],
						SUBSTRING(t.CostCentre,1,4) + '10004' [Account],
						'D' + CAST(t.Id as varchar(10)) [Labour Costing 3],
						SUBSTRING(t.locationName,6,10) [User Costing 1],
						'NCR' [User Costing 2],
						NULL [Blank],
						t.BaseRate,
						t.EMSRate,
						t.SiteRate,
						isnull(r.PayAmount,0) TierRate,
						t.branchName,
						t.AreaRateName,
						t.TierRateName,
						t.locationName,
						t.areaName
FROM					eda.EXT_DEP_FULL t
INNER JOIN				#hoursSplit h ON t.Id = h.Id AND h.phNCR > 0.12
LEFT JOIN				eda.LKP_DEP_ClientTier ct ON t.payrollId = ct.FK_SecurityGuard AND ct.FK_TierCard = 723 
							AND t.timesheetStart >= ct.EffectiveFrom AND t.timesheetStart <= isnull(ct.EffectiveTo,t.timesheetStart)
LEFT JOIN				eda.LKP_DEP_RateCard r ON ct.FK_TierCard = r.RateCode AND t.timesheetStart >= r.EffectiveFrom AND t.timesheetStart <= isnull(r.EffectiveTo,t.timesheetStart)
WHERE					t.MDEventId = @eventId
AND						t.payActivityCode != 'OD'

-- Alt Leave Credits
UNION

SELECT					'H' [Record Type],
						t.payrollId [ID Number],
						CAST(t.timesheetStart as Date) [Costing Date],
						'HC' [Hours Code],
						-1 * isnull(t.lineHours, t.timesheetHours) [Hours Amount],
						NULL [Hourly Rate],
						NULL [Date From],
						NULL [Date To],
						NULL [Leave Reason],
						-1 [Leave Units],
						NULL [A/D Code],
						NULL [Units],
						NULL [Unit Rate],
						t.CostCentre [Account],
						'D' + CAST(t.Id as varchar(10)) [Labour Costing 3],
						SUBSTRING(t.locationName,5,10) [User Costing 1],
						'Alt Credit' [User Costing 2],
						NULL [Blank], 
						NULL BaseRate,
						NULL EMSRate,
						NULL SiteRate,
						NULL TierRate,
						t.branchName,
						NULL AreaRateName,
						NULL TierRateName,
						t.locationName,
						t.areaName
FROM					eda.EXT_DEP_FULL t
WHERE					t.MDEventId = @eventId
AND						t.TimeApproved = 1
AND						CASE WHEN @extType = 'All' THEN 0 ELSE isnull(t.Exported,0) END = 0
AND						isnull(t.altCredit,0) = 1


-- OD Hours
UNION

SELECT					'H' [Record Type],
						t.payrollId [ID Number],
						CAST(t.timesheetStart as Date) [Costing Date],
						t.payActivityCode [Hours Code],
						t.lineHours [Hours Amount],
						CASE
							WHEN t.AreaProduct = 'EMS' AND isnull(t.TierRate,0) = 0 THEN NULL
							WHEN isnull(t.TierRate,0) > 0 THEN t.TierRate
							WHEN t.SiteRate > t.BaseRate THEN t.SiteRate
							ELSE NULL
						END [Hourly Rate],
						NULL [Date From],
						NULL [Date To],
						NULL [Leave Reason],
						NULL [Leave Units],
						NULL [A/D Code],
						NULL [Units],
						NULL [Unit Rate],
						t.CostCentre [Account],
						'D' + CAST(t.Id as varchar(10)) [Labour Costing 3],
						SUBSTRING(t.locationName,6,10) [User Costing 1],
						'ETU Ot' [User Costing 2],
						NULL [Blank],
						t.BaseRate,
						t.EMSRate,
						t.SiteRate,
						t.TierRate,
						t.branchName,
						t.AreaRateName,
						t.TierRateName,
						t.locationName,
						t.areaName
FROM					eda.EXT_DEP_FULL t
WHERE					t.MDEventId = @eventId
AND						t.TimeApproved = 1
AND						CASE WHEN @extType = 'All' THEN 0 ELSE isnull(t.Exported,0) END = 0
AND						t.payActivityCode = 'OD'
AND						ISNULL(t.LeaveRuleId,0) NOT IN (11,27,28,29,30,31)
AND						t.payCentre IN ('Employee Timesheets', 'Agency Timesheets')
AND						t.lineHours > 0.12

-- EMS OD Hours
UNION

SELECT					'H' [Record Type],
						t.payrollId [ID Number],
						CAST(t.timesheetStart as Date) [Costing Date],
						t.payActivityCode [Hours Code],
						t.emsHours [Hours Amount],
						CASE
							WHEN isnull(t.TierRate,0) = 0 AND t.EMSRate > isnull(t.SiteRate,0) THEN NULL
							WHEN isnull(t.TierRate,0) > 0 THEN t.TierRate
							WHEN t.SiteRate > t.BaseRate THEN t.SiteRate
							ELSE NULL
						END [Hourly Rate],
						NULL [Date From],
						NULL [Date To],
						NULL [Leave Reason],
						NULL [Leave Units],
						NULL [A/D Code],
						NULL [Units],
						NULL [Unit Rate],
						SUBSTRING(t.CostCentre,1,4) + '50002' [Account],
						'D' + CAST(t.Id as varchar(10)) [Labour Costing 3],
						SUBSTRING(t.locationName,6,10) [User Costing 1],
						'ETU Ot EMS' [User Costing 2],
						NULL [Blank],
						t.BaseRate,
						t.EMSRate,
						t.SiteRate,
						t.TierRate,
						t.branchName,
						t.AreaRateName,
						t.TierRateName,
						t.locationName,
						t.areaName
FROM					eda.EXT_DEP_FULL t
WHERE					t.MDEventId = @eventId
AND						t.TimeApproved = 1
AND						CASE WHEN @extType = 'All' THEN 0 ELSE isnull(t.Exported,0) END = 0
AND						t.payActivityCode = 'OD'
AND						ISNULL(t.LeaveRuleId,0) NOT IN (11,27,28,29,30,31)
AND						t.payCentre IN ('Employee Timesheets', 'Agency Timesheets')
AND						t.emsHours > 0.12

-- NCR OD Hours
UNION

SELECT					'H' [Record Type],
						t.payrollId [ID Number],
						CAST(t.timesheetStart as Date) [Costing Date],
						t.payActivityCode [Hours Code],
						t.ncrHours [Hours Amount],
						CASE
							WHEN isnull(r.PayAmount,0) > isnull(t.SiteRate,0) THEN r.PayAmount
							WHEN t.SiteRate > t.BaseRate THEN t.SiteRate
							ELSE NULL
						END [Hourly Rate],
						NULL [Date From],
						NULL [Date To],
						NULL [Leave Reason],
						NULL [Leave Units],
						NULL [A/D Code],
						NULL [Units],
						NULL [Unit Rate],
						SUBSTRING(t.CostCentre,1,4) + '10004' [Account],
						'D' + CAST(t.Id as varchar(10)) [Labour Costing 3],
						SUBSTRING(t.locationName,6,10) [User Costing 1],
						'ETU Ot NCR' [User Costing 2],
						NULL [Blank],
						t.BaseRate,
						t.EMSRate,
						t.SiteRate,
						isnull(r.PayAmount,0) TierRate,
						t.branchName,
						t.AreaRateName,
						t.TierRateName,
						t.locationName,
						t.areaName
FROM					eda.EXT_DEP_FULL t
LEFT JOIN				eda.LKP_DEP_ClientTier ct ON t.payrollId = ct.SKClientTier AND ct.FK_TierCard = 723 
							AND t.timesheetStart >= ct.EffectiveFrom AND t.timesheetStart <= isnull(ct.EffectiveTo,t.timesheetStart)
LEFT JOIN				eda.LKP_DEP_RateCard r ON ct.FK_TierCard = r.RateCode AND t.timesheetStart >= r.EffectiveFrom AND t.timesheetStart <= isnull(r.EffectiveTo,t.timesheetStart)
WHERE					t.MDEventId = @eventId
AND						t.TimeApproved = 1
AND						CASE WHEN @extType = 'All' THEN 0 ELSE isnull(t.Exported,0) END = 0
AND						t.payActivityCode = 'OD'
AND						ISNULL(t.LeaveRuleId,0) NOT IN (11,27,28,29,30,31)
AND						t.payCentre IN ('Employee Timesheets', 'Agency Timesheets')
AND						t.ncrHours > 0.12;
END
GO

