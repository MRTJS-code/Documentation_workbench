# Deputy EDA Event Processor

This repository contains the exported SSIS solution **Deputy EDA** alongside SQL schema definitions used to run an event-driven integration between Deputy data, billing/payroll/subcontractor extracts, and Deputy API updates.

Generated documentation:
- `TECHNICAL_README.md` – setup/deployment guide with package inventory and dependencies.
- `PROCESS_DRAFT.md` – human-readable flow, lifecycle diagram, and status matrix.
- `TO_REVIEW_ENHANCEMENTS.md` – prioritized improvements grounded in observed behavior.
- `promptEngineer.md` – notes on the documentation approach.

Repo structure highlights:
- SSIS packages and project files in the root (`*.dtsx`, `Deputy EDA.dtproj`, `SSIS Deputy EDA.sln`).
- `/SQL_SCHEMA` contains the `DataIntegration` database project with all `eda` tables/views/procs and DW lookup dependencies; `/ODS_NZ_SEC` holds related DW/staging definitions.
- `/BCP SQL Scripts` includes helper SQL for seeding `eda.ETL_EVENT` and payload tables.
- `/ETL Deploy Script` registers job code 6002 in the ETLFramework metadata.
- `/ETL_Documentation` holds Wilson Group ETL Framework background (run lifecycle, metadata tables, deployment guidance for the on-prem SQL Agent–scheduled framework).

Re-run the documentation process:
1) Scan the repo tree (packages, `Project.params`, connection managers, `/SQL_SCHEMA`).
2) Identify event routing in `0 Job Plan.dtsx` (statuses, variables, precedence) and note SQL touchpoints.
3) Map tables/procs from `/SQL_SCHEMA` back to package usage.
4) Regenerate the Markdown files above with any new findings or changes.
