
CREATE VIEW			lookup.DEP_APP_AreaLocation AS
SELECT				la.PK_WorkAreaID AreaId,
					ll.PK_LocationCode LocationId,
					la.WorkAreaName,
					ll.LocationName,
					la.FK_RateCard,
					la.FK_CostCentre,
					la.FK_ProductCode,
					ll.FK_DebtorCode,
					la.EffectiveFrom,
					la.EffectiveTo
FROM				lookup.DEP_WorkAreas la
LEFT JOIN			lookup.DEP_Location ll ON la.FK_LocationCode = ll.PK_LocationCode