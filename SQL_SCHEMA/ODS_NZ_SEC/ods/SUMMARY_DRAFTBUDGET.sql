
CREATE view [ods].[SUMMARY_DRAFTBUDGET]
as
SELECT	per.stDate as periodDate,
		job.code as jobCode,
		job.GroupContract as groupContract,
		job.name as jobName,
		job.AXCC as axCostCentre,
		org.code as cusuCode,
		org.type as cusuype,
		org.orgGroup as cusuGroup,
		gtgl.accountNo as gtAccount,
		gtgl.description as gtAccDesc,
		axcoa.axGLAcc as axAccount,
		axcoa.axGLDesc as axAccDesc,
		axcoa.glType as glType,
		axcoa.glSubtype as glSubtype,
		br.id as branchId,
		br.[Branch Name] as branchName,
		br.[Branch Reporting Name] as repBranchName,
		br.[Branch Group] as branchGroup,
		bs.id as businessId,
		bs.[Business Type Summary] as busSummary,
		bs.[Business Type Description] as busDescription,
		trn.Amount AS amt
FROM ods.FCT_DRAFTBUDGET trn
INNER JOIN ods.DIM_GT_PERIOD per ON trn.Date = per.stDate
LEFT JOIN ods.DIM_JOB job ON trn.JobCode = job.code
LEFT JOIN ods.DIM_ORGANISATION org ON trn.gtCust = org.code
INNER JOIN ods.DIM_GT_GL gtgl ON trn.GTGL = gtgl.accountNo
INNER JOIN ods.DIM_GT_COA gtcoa ON gtgl.coaID = gtcoa.id
INNER JOIN ods.DIM_AX_COA axcoa ON gtcoa.axGLAcc = axcoa.axGLAcc
INNER JOIN ods.DIM_BRANCH br ON gtgl.branchID = br.id
INNER JOIN ods.DIM_BUSINESS bs ON gtgl.businessID = bs.id
