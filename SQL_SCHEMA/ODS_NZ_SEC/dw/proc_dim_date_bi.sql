

-- ===================================================
-- Author:		Crispin Nicodemus 
-- Create date: 2023-02-08 
-- Description:	stored proc for building dim_it_staff 
-- ===================================================
CREATE PROCEDURE [dw].[proc_dim_date_bi]
-- Add the parameters for the stored procedure here
AS

-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SET NOCOUNT ON;

DECLARE			@currYear int;

SELECT			@currYear = p.P_Year_No
FROM			lookup.GT_ACTIVE_PERIOD lp
INNER JOIN		dw.DIM_GT_PERIOD p ON lp.active_instid = p.PK_oid_instid
WHERE			lp.moduleCode = 'GL'


SELECT			d.*,
				p.SK_DIM_GT_PERIOD,
				p.P_Month_No P_Fiscal_Month,
				p.P_Year_No P_Fiscal_Year
FROM			dw.DIM_DATE d
INNER JOIN		dw.DIM_GT_PERIOD p ON d.SK_DIM_DATE >= p.FK_DIM_DATE_START AND d.SK_DIM_DATE <= p.FK_DIM_DATE_END
WHERE			p.P_Year_No >= (@currYear - 7) AND p.P_Year_No < (@currYear + 1)
ORDER BY		d.SK_DIM_DATE


