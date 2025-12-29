

-- ========================================================
-- Author:		Tony Smith 
-- Create date: 2023-08-10 
-- Description:	stored proc for building dim_ax_coa
-- =========================================================
CREATE PROCEDURE [dw].[proc_dim_ax_coa]
	-- Add the parameters for the stored procedure here
	@p_job int,  
	@p_run bigint,	
	@p_etl int	
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;

BEGIN

MERGE INTO			dw.DIM_AX_COA t
USING				staging.AX_COA s
ON					t.SK_DIM_AX_COA = s.SK_DIM_AX_COA

WHEN MATCHED AND isnull(t.MD_DATE_MODIFIED,'1900-01-01') != isnull(s.MD_DATE_MODIFIED,'1900-01-01') THEN
UPDATE SET			t.SK_DIM_AX_COA = s.SK_DIM_AX_COA,
					t.PK_Main_Account_RECID_DAX = s.PK_Main_Account_RECID_DAX,
					t.P_Main_Account_Code = s.P_Main_Account_Code,
					t.P_Main_Account = s.P_Main_Account,
					t.P_WG_Account_Category = s.P_WG_Account_Category,
					t.P_WG_Account_Category_Code = s.P_WG_Account_Category_Code,
					t.P_WG_Account_Type_Code = s.P_WG_Account_Type_Code,
					t.P_WG_Account_Type = s.P_WG_Account_Type,
					t.P_FS_GL_Report = s.P_FS_GL_Report,
					t.P_FS_Account_Type = s.P_FS_Account_Type,
					t.P_FS_Account_SubType = s.P_FS_Account_SubType,
					t.P_FS_NOS = s.P_FS_NOS,
					t.MD_DATE_MODIFIED = s.MD_DATE_MODIFIED,
					t.MD_MODIFIED_USER = s.MD_MODIFIED_USER,
					t.MD_JOB_CODE = @p_job,
					t.MD_RUN_CODE = @p_run,
					t.MD_ETL_RUN = @p_etl,
					t.MD_LOGICAL_DELETE = 0

WHEN NOT MATCHED THEN
INSERT (			SK_DIM_AX_COA,
					PK_Main_Account_RECID_DAX,
					P_Main_Account_Code,
					P_Main_Account,
					P_WG_Account_Category,
					P_WG_Account_Category_Code,
					P_WG_Account_Type_Code,
					P_WG_Account_Type,
					P_FS_GL_Report,
					P_FS_Account_Type,
					P_FS_Account_SubType,
					P_FS_NOS,
					MD_DATE_MODIFIED,
					MD_MODIFIED_USER,
					MD_JOB_CODE,
					MD_RUN_CODE,
					MD_ETL_RUN,
					MD_LOGICAL_DELETE)
VALUES (			s.SK_DIM_AX_COA,
					s.PK_Main_Account_RECID_DAX,
					s.P_Main_Account_Code,
					s.P_Main_Account,
					s.P_WG_Account_Category,
					s.P_WG_Account_Category_Code,
					s.P_WG_Account_Type_Code,
					s.P_WG_Account_Type,
					s.P_FS_GL_Report,
					s.P_FS_Account_Type,
					s.P_FS_Account_SubType,
					s.P_FS_NOS,
					s.MD_DATE_MODIFIED,
					s.MD_MODIFIED_USER,
					@p_job,
					@p_run,
					@p_etl,
					0)

WHEN NOT MATCHED BY SOURCE THEN
UPDATE SET			t.MD_DATE_MODIFIED = getDate(),
					t.MD_JOB_CODE = @p_job,
					t.MD_RUN_CODE = @p_run,
					t.MD_ETL_RUN = @p_etl,
					t.MD_LOGICAL_DELETE = 1
;
END
;
