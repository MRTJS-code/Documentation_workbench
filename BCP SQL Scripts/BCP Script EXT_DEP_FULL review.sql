SELECT					t.MDEventId, min(t.timesheetStart), max(t.timesheetStart)
FROM					eda.EXT_DEP_FULL t
GROUP BY				t.MDEventId

--DELETE FROM eda.EXT_DEP_FULL WHERE MDEventId = 2 AND timesheetStart >= '2025-06-16'