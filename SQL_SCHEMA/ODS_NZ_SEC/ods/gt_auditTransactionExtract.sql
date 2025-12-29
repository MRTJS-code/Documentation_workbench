




CREATE procedure [ods].[gt_auditTransactionExtract] (@fromDate varchar(10), @toDate varchar(10)) as
begin
SELECT concat(gld.mnthNo ,' ' , gld.yearNo) as glPeriod,
	glt.documentDate, 
	axc.glType,
	glt.sourceTranType,
	glt.reference,
	glt.modifiedUser,
	gla.code as activity,
	glt.subcode,
	glj.name as jobName,
	glt.detail,
	glo.name as orgName,
	gl.accountNo,
	glt.standardText,
	sum(glt.quantity) as qty,
	sum(glt.tranNetAmount) as netAmount
FROM ods.FCT_GLTRANS glt
INNER JOIN ods.DIM_GT_PERIOD gld ON glt.period = gld.oid
INNER JOIN ods.DIM_GT_GL gl ON gl.oid = glt.glAccount
FULL OUTER JOIN ods.DIM_JOB glj ON glt.job = glj.oid
FULL OUTER JOIN ods.DIM_ORGANISATION glo on glt.organisation = glo.oid
FULL OUTER JOIN ods.DIM_GT_ACTIVITY gla ON glt.activity = gla.oid
INNER JOIN ods.DIM_GT_COA glc ON gl.coaID = glc.id
INNER JOIN ods.DIM_AX_COA axc ON glc.axGLAcc = axc.axGLAcc
WHERE gld.stDate >= @fromDate AND gld.stDate <= @toDate
GROUP BY concat(gld.mnthNo ,' ' , gld.yearNo),
	glt.documentDate, 
	axc.glType,
	glt.sourceTranType,
	glt.reference,
	glt.modifiedUser,
	gla.code,
	glt.subCode,
	glj.name,
	glt.detail,
	glo.name,
	gl.accountNo,
	glt.standardText
end
