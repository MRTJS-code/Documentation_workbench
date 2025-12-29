








CREATE VIEW [eda].[LKP_IT_LOCREGFULL]
AS
SELECT				r.*,
					Cast(RIGHT(r.LOC_REFERENCE,6) as int) locId,
					Cast(CASE WHEN e1.LOC_REFERENCE is null THEN 0 ELSE 1 END as bit)itRefMissing,
					Cast(CASE WHEN e2.LOC_REFERENCE is null THEN 0 ELSE 1 END as bit)itNameChange,
					Cast(CASE WHEN e3.LOC_REFERENCE is null THEN 0 ELSE 1 END as bit) itJobCodeChange,
					Cast(CASE WHEN e4.LOC_REFERENCE is null THEN 0 ELSE 1 END as bit) itJobCodeInvalid,
					Cast(CASE WHEN e5.LOC_REFERENCE is null THEN 0 ELSE 1 END as bit) itJobCodeClosed,
					Cast(CASE WHEN e6.LOC_REFERENCE is null THEN 0 ELSE 1 END as bit) gtJobCodeReview,
					Cast(CASE WHEN e7.LOC_REFERENCE is null THEN 0 ELSE 1 END as bit) itNewLocation,
					Cast(CASE WHEN e8.LOC_REFERENCE is null THEN 0 ELSE 1 END as bit) itBadActivity
FROM				eda.LKP_IT_LOCREGISTER r 
LEFT JOIN (		
SELECT				DISTINCT e.LOC_REFERENCE
FROM				eda.LKP_IT_LOCREGERROR e
WHERE				e.COMMENT = 'Location in InTime is missing reference'
					) e1 ON r.LOC_REFERENCE = e1.LOC_REFERENCE
LEFT JOIN (		
SELECT				DISTINCT e.LOC_REFERENCE
FROM				eda.LKP_IT_LOCREGERROR e
WHERE				e.COMMENT like 'Location Name changed%'
					) e2 ON r.LOC_REFERENCE = e2.LOC_REFERENCE
LEFT JOIN (		
SELECT				DISTINCT e.LOC_REFERENCE
FROM				eda.LKP_IT_LOCREGERROR e
WHERE				e.COMMENT like 'Location Job Code changed%'
					) e3 ON r.LOC_REFERENCE = e3.LOC_REFERENCE
LEFT JOIN (		
SELECT				DISTINCT e.LOC_REFERENCE
FROM				eda.LKP_IT_LOCREGERROR e
WHERE				e.COMMENT = 'Job Code invalid'
					) e4 ON r.LOC_REFERENCE = e4.LOC_REFERENCE
LEFT JOIN (		
SELECT				DISTINCT e.LOC_REFERENCE
FROM				eda.LKP_IT_LOCREGERROR e
WHERE				e.COMMENT = 'Greentree Job Code is closed'
					) e5 ON r.LOC_REFERENCE = e5.LOC_REFERENCE
LEFT JOIN (		
SELECT				DISTINCT e.LOC_REFERENCE
FROM				eda.LKP_IT_LOCREGERROR e
WHERE				e.COMMENT like 'Greentree Job Status is%'
					) e6 ON r.LOC_REFERENCE = e6.LOC_REFERENCE
LEFT JOIN (		
SELECT				DISTINCT e.LOC_REFERENCE
FROM				eda.LKP_IT_LOCREGERROR e
WHERE				e.COMMENT = 'New InTime Location'
					) e7 ON r.LOC_REFERENCE = e7.LOC_REFERENCE
LEFT JOIN (		
SELECT				DISTINCT e.LOC_REFERENCE
FROM				eda.LKP_IT_LOCREGERROR e
WHERE				e.COMMENT like '%assignments with invalid activity'
					) e8 ON r.LOC_REFERENCE = e8.LOC_REFERENCE

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "LKP_IT_LOCREGISTER"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 245
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LKP_IT_LOCREGERROR"
            Begin Extent = 
               Top = 20
               Left = 425
               Bottom = 198
               Right = 684
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'eda', @level1type = N'VIEW', @level1name = N'LKP_IT_LOCREGFULL';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'eda', @level1type = N'VIEW', @level1name = N'LKP_IT_LOCREGFULL';

