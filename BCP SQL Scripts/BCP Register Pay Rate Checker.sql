-- Updated to work using DataIntegration DB

/** Site Rate Review Code **/
SELECT			l.name locaionName,
				ar.AreaName areaName,
				a.SKWorkArea,
				a.PK_WorkAreaID,
				ar.Id depWorkAreaID,
				l.CompanyNumber D365Debtor,
				ar.PayrollExportName CostCentreProduct,
				a.PrecedaPayCode,
				a.PayRate,
				a.FK_ProductCode ProductCode,
				a.FK_CostCentre CostCentre,
				a.EffectiveFrom,
				a.EffectiveTo,
				l.id LocationCode,
				c.RateCode,
				c.RateName,
				c.PayAmount,
				c.FK_ProductCode
FROM			eda.LKP_DEP_WorkArea a
FULL OUTER JOIN	eda.STG_DEP_Area ar ON a.PK_WorkAreaID = ar.Id
LEFT JOIN		eda.STG_DEP_LOCATION l ON ar.LocationId = l.Id
LEFT JOIN		eda.LKP_DEP_RateCard c ON a.FK_RateCard = c.RateCode AND c.EffectiveTo is NULL
--WHERE			l.Name like '%NCR%' OR l.name like '%FLM%' OR ar.AreaName like '%NCR%' OR ar.AreaName like '%FLM%'
--WHERE			l.Name like '%AKL56%'
--WHERE			l.CompanyNumber = 'N003-C012101'
--WHERE			a.FK_CostCentre like '%10004'
--WHERE			c.RateName like '%Patrol%'
--WHERE			ar.Id = 7271
WHERE				a.FK_RateCard IN (196,197,198,199,200,201)
--WHERE			a.PK_WorkAreaID IN  (6721)
--WHERE			a.SKWorkArea is NULL
--,3049
--,3373
--,3372
--,3071)
--AND				c.PayAmount = 31.61

--SELECT * FROM eda.STG_DEP_LOCATION WHERE Name like '%SPARK%Cent%'



/** Rate Card Review Code */
SELECT			*
FROM			eda.LKP_DEP_RateCard r
WHERE			r.RateName like '%Northp%'
----WHERE			PayAmount = 27
----WHERE			FK_ProductCode = 'SGPDH'
--WHERE			r.RateCode IN (55,61,63)
----OR				PayAmount = 31.61

/** Client Tier Review Code **/
--SELECT			*
--FROM			eda.LKP_DEP_ClientTier ct 
--WHERE			ct.FK_SecurityGuard IN (500190,500788,512708)
----OR				ct.FK_WorkAreaID = 3385
----AND				ct.FK_TierCard IN (61,63)
--AND				ct.FK_SiteCard IN (55)
----AND				ct.FK_SecurityGuard = 501368

--SELECT Max(PK_ClientTierId) FROM eda.LKP_DEP_ClientTier

/** Update Templates **/
/* lookup.DEP_WorkAreas Update */
--UPDATE			a
--SET				PayRate = c.PayAmount
--FROM			lookup.DEP_WorkAreas a
--INNER JOIN		staging.DEP_Area ar ON a.PK_WorkAreaID = ar.Id
--INNER JOIN		staging.DEP_Location l ON ar.LocationId = l.Id
--LEFT JOIN		lookup.DEP_RateCard c ON a.FK_RateCard = c.RateCode AND c.EffectiveTo is NULL
--WHERE			a.PK_WorkAreaID IN  (9501)

