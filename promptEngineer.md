## Approach (“Recipe”)
- Locate SSIS metadata first (`Deputy EDA.dtproj`, `Project.params`, connection managers) to anchor environment/configuration.
- Identify the orchestrator (`0 Job Plan.dtsx`) and trace variables, result-set loader, ForEach mappings, precedence constraints, status updates, and event handlers.
- For each routed package, sample `SqlStatementSource` tasks to capture table/proc touchpoints; rely on `/SQL_SCHEMA` definitions for authoritative schemas.
- Map the lifecycle: event creation → polling/filtering → staging → transform → outbound (CSV/API) → completion/error handling, noting statuses and data stores.
- Summarize tables from `/SQL_SCHEMA/DataIntegration/eda` and relate them to package actions; explicitly mark anything inferred as assumptions/gaps.
- Incorporate ETL Framework context (see `/ETL_Documentation`): job metadata in `metadata.CTL_*`, run cadence, dependency handling, how `ETL_VAR_*`/`ETL_CUS_*` parameters are injected at runtime, and how `ERR_MAX_FAIL`/`ERR_PRIOR_FAIL_COUNT` drive OnError retry vs error.

## What Worked Well
- `rg` + targeted `Select-String` around `SqlStatementSource` and `ObjectName` quickly exposed routing and status updates.
- `/SQL_SCHEMA/DataIntegration/eda` files provided definitive table definitions and views (no guessing on columns).
- `/BCP SQL Scripts/BCP EDA Event Loader.sql` clarified expected `ETL_EVENT_VARIABLES` codes without digging through script components.
- New `/ETL_Documentation` Word docs summarize the Wilson Group ETL Framework run lifecycle, metadata tables, and deployment guidance (SQL Agent cadence, CTL_RUN, CTL_JOB_CONFIG/VARIABLES/DEPENDENCIES, ERR_MAX_FAIL/ERR_PRIOR_FAIL_COUNT behavior).

## Gotchas in This Repo
- Packages like `2 Stage Deputy.dtsx` and the Deputy API posting packages embed logic not visible in SQL (HTTP calls, script components); behavior still inferred from payload tables which is usually a safe assumption.  Where needed, additional prompting will be requested to review underlying C# code in script tasks.
- OnError handler variables (`ERR_FAIL_STATUS`, etc.) lack documented values; final status on failure is uncertain.  This was resolved by providing ETL Framework documentation and explicitly stating how the Prior Failure and Max Failure variables were calculated from the underlying ETL Job Config.
- `Resource Check` future enhancement is planned to decouple large Deputy import batches; current flow completes without that gate.
- Connection strings include server/user defaults; which are parametised securely within run enviornments

## How to Improve Future Runs
- Ask for desired OnError status policy (Retry vs Error) and retry counts to document failure paths accurately.
- Request an explicit package-to-table map and any API endpoint specs to avoid spelunking script tasks.
- Confirm ETL Framework job code settings (CTL_JOB_CONFIG) and runtime parameter values (`ETL_VAR_*`, `ETL_CUS_*`) for the target environment.
- Capture SQL Agent schedule and exclusion windows from ETL metadata to describe operational cadence precisely.

## Checklist for Next Iteration
- [ ] Confirm environment parameter overrides (servers, catalogs, Deputy URL/token) for target deployment.
- [ ] Validate current `ETL_EVENT` statuses and kickoff dates before describing trigger logic.
- [ ] Re-scan orchestrator precedence constraints after any package changes.
- [ ] Cross-check `IMP_*` and staging table schemas after schema migrations.
- [ ] Note any new status values introduced in `eda.UPDATE_EVENT_STATUS` or OnError handler.
- [ ] Review `/ETL_Documentation` for updates to the ETL Framework lifecycle or deployment standards.
- [ ] Check for any wider EDA changes, such as planned enhancements for event decoupling, introduction of an event handler run and any other event processors added to the wider architecture
