-- Updated to work using DataIntegration DB

DECLARE		@newRateCode int;
DECLARE		@newRateName varchar(100) = 'Kmart Queenstown'
DECLARE		@updateRateCard int = 671
DECLARE		@payrollId int = 517511
DECLARE		@payRate float = 27
DECLARE		@siteRateCode int = 588 
DECLARE		@clientTierExisting int = 111;
DECLARE		@effectiveDate date = '2025-07-01';
DECLARE		@approver varchar(100) = 'Chris Stewart';
DECLARE		@ritm varchar(50) = 'Email re Kmart rates 27/8/25'
DECLARE		@workAreaID int = 9923
DECLARE		@workAreaSK int = 3098


/** Create New Rate Card **/
--SELECT		@newRateCode =  Max(RateCode) + 1
--FROM		eda.LKP_DEP_RateCard

--INSERT INTO eda.LKP_DEP_RateCard
--           ([RateCode]
--           ,[RateName]
--           ,[PayAmount]
--           ,[ChangeApprover]
--           ,[ChangeRef]
--           ,[EffectiveFrom]
--           ,[MD_CreateDate]
--           ,[MD_ModifiedDate])
--     VALUES
--           (@newRateCode
--           ,@newRateName
--           ,@payRate
--           ,@approver
--           ,@ritm
--           ,@effectiveDate
--           ,SYSDATETIME()
--           ,SYSDATETIME())

/** New Rate Card Update **/
UPDATE		eda.LKP_DEP_RateCard
SET			--EffectiveTo = @effectiveDate,
			PayAmount = 27.8,
			EffectiveTo = NULL,
			MD_ModifiedDate = SYSDATETIME()
--WHERE		RateCode = @updateRateCard
--AND			EffectiveFrom = '2025-07-01'
WHERE		SKRateCard IN (411)

--INSERT INTO eda.LKP_DEP_RateCard
--           ([RateCode]
--           ,[PayAmount]
--           ,[FK_ProductCode]
--           ,[ChangeApprover]
--           ,[ChangeRef]
--           ,[EffectiveFrom]
--           ,[EffectiveTo]
--           ,[MD_CreateDate]
--           ,[MD_ModifiedDate])
--     VALUES
--           (@updateRateCard
--           ,@payRate
--           ,NULL
--           ,@approver
--           ,@ritm
--           ,@effectiveDate
--           ,NULL
--           ,SYSDATETIME()
--           ,SYSDATETIME())


--UPDATE		eda.LKP_DEP_WorkArea 
--SET			FK_RateCard = @newRateCode,
--			MD_ModifiedDate = SYSDATETIME()
--WHERE		SKWorkArea IN (1794,2246,2542)  --= @workAreaSK;


--INSERT INTO eda.LKP_DEP_WorkArea
--           ([PK_WorkAreaID]
--           ,[WorkAreaName]
--           ,[FK_LocationCode]
--           ,[FK_RateCard]
--           ,[ChangeApprover]
--           ,[ChangeRef]
--           ,[PayRate]
--           ,[EffectiveFrom]
--           ,[MD_CreateDate]
--           ,[MD_ModifiedDate])
--SELECT		@workAreaID,
--			a.AreaName,
--			a.LocationId,
--			@siteRateCode, --@newRateCard for new cards, @siteRateCard for existing cards
--			@approver,
--			@ritm,
--			@payRate,
--			@effectiveDate,
--			SYSDATETIME(),
--			SYSDATETIME()
--FROM		eda.STG_DEP_Area a
--WHERE		a.Id = @workAreaID




--UPDATE		lookup.DEP_ClientTier
--SET			EffectiveTo = @effectiveDate,
--			MD_ModifiedDate = SYSDATETIME()
--WHERE		PK_ClientTierId = @clientTierExisting;


--INSERT INTO [lookup].[DEP_ClientTier]
--           ([FK_SecurityGuard]
--           ,[FK_SiteCard]
--           ,[FK_TierCard]
--           ,[ChangeApprover]
--           ,[ChangeRef]
--           ,[EffectiveFrom]
--           ,[MD_CreateDate]
--           ,[MD_ModifiedDate])
--VALUES (	@payrollId,
--			@siteRateCode,
--			@updateRateCard,  --@newRateCard for new cards, @updateRateCard for existing cards
--			@approver,
--			@ritm,
--			@effectiveDate,
--			SYSDATETIME(),
--			SYSDATETIME());


