DECLARE					@eventId int = 0

-- Find Leave Tracker matches and update area
UPDATE					d
SET						d.AreaId = ltr.AreaId
FROM					eda.EXT_DEP_FULL d
INNER JOIN				eda.LKP_DEP_LeaveRosterTracker ltr ON d.LeaveLineId = ltr.LeaveLineId
WHERE					d.LeaveRuleId is not null
AND						d.AreaId is null
AND						d.MDEventId = @eventId

-- Match as many remaining as possible using leave roster history
UPDATE					d
SET						d.AreaId = lrh.AreaId
FROM					eda.EXT_DEP_FULL d
INNER JOIN				(

SELECT					lrh.EmployeeId, lrh.AreaId, lrh.wkDay,
						ROW_NUMBER() OVER (PARTITION BY lrh.EmployeeId, lrh.wkDay ORDER BY lrh.EmployeeId, lrh.wkDay, lrh.rosterCount DESC) rowNum
FROM					eda.LKP_LeaveRosterHistory lrh

						) lrh ON d.EmployeeId = lrh.EmployeeId AND DATENAME(dw,d.timesheetStart) = lrh.wkDay AND lrh.rowNum = 1
WHERE					d.LeaveRuleId is not null
AND						d.AreaId is null
AND						d.MDEventId = @eventId

-- Add leave Cost Centre
UPDATE					d
SET						d.CostCentre = CAST(CASE 
							WHEN CHARINDEX('|',a.PayrollExportName) != 0 THEN REVERSE(PARSENAME(REPLACE(REVERSE(a.PayrollExportName), '|', '.'), 1))
							ELSE a.PayrollExportName
						END as varchar(50))
FROM					eda.EXT_DEP_FULL d
LEFT JOIN				eda.STG_DEP_AREA a ON d.AreaId = a.Id
WHERE					d.sourceType = 'Leave'
AND						d.AreaId is not null
AND						d.MDEventId = @eventId

-- Add Rate Card data from area lookup
UPDATE					d
SET						d.SiteRate = isnull(ar.PayAmount,0),
						d.AreaRateName =  isnull(ar.RateName,'No Rate Card'),
						d.TierRate = isnull(tr.PayAmount,0),
						d.TierRateName =  tr.RateName
FROM					eda.EXT_DEP_FULL d
LEFT JOIN				eda.LKP_DEP_WorkArea lwa ON d.AreaId = lwa.PK_WorkAreaID
LEFT JOIN				eda.LKP_DEP_RateCard ar ON lwa.FK_RateCard = ar.RateCode AND d.timesheetStart >= ar.EffectiveFrom AND d.timesheetStart <= isnull(ar.EffectiveTo, d.timesheetStart)
LEFT JOIN				eda.LKP_DEP_ClientTier lct ON d.payrollId = Cast(lct.FK_SecurityGuard as varchar(20)) AND lwa.FK_RateCard = lct.FK_SiteCard 
						AND d.timesheetStart >= lct.EffectiveFrom AND d.timesheetStart <= isnull(lct.EffectiveTo, d.timesheetStart)
LEFT JOIN				eda.LKP_DEP_RateCard tr ON lct.FK_TierCard = tr.RateCode AND d.timesheetStart >= tr.EffectiveFrom AND d.timesheetStart <= isnull(tr.EffectiveTo, d.timesheetStart)
WHERE					d.sourceType = 'Leave'
AND						d.AreaId is not null
AND						d.MDEventId = @eventId

-- Fix negative line hours on 01 lines
UPDATE					d
SET						d.timesheetHours = d.emsHours + d.ncrHours,
						d.lineHours = 0
FROM					eda.EXT_DEP_FULL d
WHERE					d.lineHours < 0
AND						d.payActivityCode = '01'
AND						d.MDEventId = @eventId

-- Fix hours allocation on OD lines with EMS/NCR splits
UPDATE					d
SET						d.lineHours = CASE
							WHEN d.lineHours < (d.emsHours + d.ncrHours) THEN 0
							ELSE d.lineHours - d.emsHours - d.ncrHours
						END,
						d.emsHours = CASE
							WHEN d.lineHours < d.emsHours THEN d.lineHours
							ELSE d.emsHours
						END,
						d.ncrHours = CASE
							WHEN d.lineHours - (CASE WHEN d.lineHours < d.emsHours THEN d.lineHours ELSE d.emsHours END) < d.ncrHours THEN
								d.lineHours - (CASE WHEN d.lineHours < d.emsHours THEN d.lineHours ELSE d.emsHours END)
							ELSE d.ncrHours
						END
FROM					eda.EXT_DEP_FULL d
WHERE					d.payActivityCode = 'OD'
AND (					d.emsHours > 0 OR d.ncrHours > 0)
AND						d.MDEventId = @eventId

