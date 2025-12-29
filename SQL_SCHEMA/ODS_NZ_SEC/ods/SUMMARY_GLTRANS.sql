





CREATE view [ods].[SUMMARY_GLTRANS]
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
		axcoa.axGLAcc as axAccDesc,
		axcoa.glType as glType,
		axcoa.glSubtype as glSubtype,
		br.id as branchId,
		br.[Branch Name] as branchName,
		br.[Branch Reporting Name] as repBranchName,
		br.[Branch Group] as branchGroup,
		bs.id as businessId,
		bs.[Business Type Summary] as busSummary,
		bs.[Business Type Description] as busDescription,
		act.code as actCode,
		act.description as actDesc,
		-1 * sum(trn.tranNetAmount) AS amt
FROM ods.FCT_GLTRANS trn
INNER JOIN ods.DIM_GT_PERIOD per ON trn.period = per.oid
LEFT JOIN ods.DIM_JOB job ON trn.job = job.oid
LEFT JOIN ods.DIM_ORGANISATION org ON trn.organisation = org.oid
INNER JOIN ods.DIM_GT_GL gtgl ON trn.glAccount = gtgl.oid
INNER JOIN ods.DIM_GT_COA gtcoa ON gtgl.coaID = gtcoa.id
INNER JOIN ods.DIM_AX_COA axcoa ON gtcoa.axGLAcc = axcoa.axGLAcc
INNER JOIN ods.DIM_BRANCH br ON gtgl.branchID = br.id
INNER JOIN ods.DIM_BUSINESS bs ON gtgl.businessID = bs.id
LEFT JOIN ods.DIM_GT_ACTIVITY act ON trn.activity = act.oid
WHERE axcoa.glReport = 'PNL'
AND per.stDate < '2020-05-01'
GROUP BY
		per.stDate,
		job.code,
		job.GroupContract,
		job.name,
		job.AXCC,
		org.code,
		org.type,
		org.orgGroup,
		gtgl.accountNo,
		gtgl.description,
		axcoa.axGLAcc,
		axcoa.axGLAcc,
		axcoa.glType,
		axcoa.glSubtype,
		br.id,
		br.[Branch Name],
		br.[Branch Reporting Name],
		br.[Branch Group],
		bs.id,
		bs.[Business Type Summary],
		bs.[Business Type Description],
		act.code,
		act.description
