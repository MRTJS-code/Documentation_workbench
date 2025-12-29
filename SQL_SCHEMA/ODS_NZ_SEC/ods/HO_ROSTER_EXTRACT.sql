





CREATE procedure [ods].[HO_ROSTER_EXTRACT] (@fromDate varchar(10)) as
begin
SELECT      assignmentId,
       itStaffId,
       dateFrom,
       dateTo,
       itCustomer,
       itLocation,
       br.branchID,
       br.IT_Branch,
       br.Description
FROM      ods.FCT_ROSTER ro
INNER JOIN     (
SELECT      IT_Branch,
       branchID,
       Description
FROM      ods.LKP_IT_BRANCH br1
UNION SELECT    IT_Branch,
       branchID,
       Description
FROM      ods.LKP_IT_BRANCH2 br2) br On ro.branchID = br.branchID
WHERE      ro.assignmentDate >= @fromDate
end
