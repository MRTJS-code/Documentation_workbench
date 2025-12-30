## Approach (“Recipe”)
- Locate SSIS metadata first (`Deputy EDA.dtproj`, `Project.params`, connection managers) to anchor environment/configuration.
- Identify orchestrator package (here `0 Job Plan.dtsx`) and trace: variables, result-set loader, ForEach mappings, precedence constraints, status updates, and event handlers.
- For each routed package, sample SQLTask definitions to capture table/proc touchpoints; rely on schema files in `/SQL_SCHEMA` to confirm object definitions.
- Map the lifecycle: event creation → polling/filtering → staging → transform → outbound (CSV/API) → completion/error handling, calling out statuses and data stores.
- Summarize tables from `/SQL_SCHEMA/DataIntegration/eda` and relate them to package actions; treat missing/opaque pieces as “assumptions/gaps”.
- Generate Markdown deliverables with clear sections (setup, flow, enhancements, summary) and cite exact object names.

## What Worked Well
- Using `rg` + targeted `Select-String` around `SqlStatementSource` and `ObjectName` quickly exposed status updates and routing.
- Schema files in `/SQL_SCHEMA/DataIntegration/eda` provided definitive table definitions to prevent guessing.
- `BCP SQL Scripts/BCP EDA Event Loader.sql` clarified expected `ETL_EVENT_VARIABLES` codes without digging through script components.

## Gotchas in This Repo
- Packages like `2 Stage Deputy.dtsx` and API posting packages embed logic not visible in SQL (HTTP calls, script components); had to infer behavior from payload tables.
- OnError handler variables (`ERR_FAIL_STATUS`, etc.) lack documented values; unclear final status on failure.
- `Resource Check` is disabled by expression for most flows, so completion can happen without verifying `IMP_DEPRESOURCE` responses.
- Connection strings include server/user defaults; must be overridden in secured environments.

## How to Improve Future Runs
- Ask for a short text summary of each package’s intent and key tables to reduce DTSX spelunking.
- Request documented error-handling policy (desired status names, retry counts) to map failure paths accurately.
- Encourage inclusion of a “package-to-table” map in the repo for quick reference.
- Suggest exposing REST call definitions (URLs, verbs) in separate markdown to avoid reverse-engineering script tasks.

## Checklist for Next Iteration
- [ ] Confirm environment parameter overrides (servers, catalogs, Deputy URL/token) for target deployment.
- [ ] Validate current `ETL_EVENT` statuses and kickoff dates before describing trigger logic.
- [ ] Re-scan orchestrator precedence constraints after any package changes.
- [ ] Cross-check `IMP_*` and staging table schemas after schema migrations.
- [ ] Note any new status values introduced in `eda.UPDATE_EVENT_STATUS` or OnError handler.
