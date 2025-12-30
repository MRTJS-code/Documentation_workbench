## Purpose and Scope
- SSIS project **Deputy EDA** (solution `SSIS Deputy EDA.sln`, project `Deputy EDA.dtproj`) implements an event-driven integration between Deputy data and downstream targets (Deputy APIs, billing, payroll, subcontractor extracts).
- Orchestration is centered on **eda.ETL_EVENT** records (ETL_REF = 6002) stored in the **DataIntegration** database; each event drives staged extraction, transformation, and outbound actions.

## Prerequisites
- SQL Server with OLE DB connectivity to:
  - `DataIntegration` (project connection `0 DI DB`).
  - `ETLFramework` (project connection `1 ETL Framework`) for scheduling metadata.
  - `ODS_NZ_SEC` (project connection `0 DW FSGS`) for DW lookups used in extract logic.
- SSIS runtime (SQL Server 2017 project level) with permissions to deploy and run packages.
- SMTP relay reachable for optional error notifications (connection manager `0 SMTP Server`).
- Deputy API access (URL/token configured via project parameters) and local file system path for CSVs (`ENV_CONNECTION_1_CSV_DIR`).

## Deploying the SSIS Project
- Build `Deputy EDA.dtproj` and deploy the resulting `.ispac` (e.g., `bin/Development/Deputy EDA.ispac`) to the SSIS catalog.
- Register environment variables/parameters:
  - Database endpoints and credentials (`ENV_CONNECTION_0_*` for DI/ETL/ODS).
  - Deputy API URL/token (`ENV_CONNECTION_1_DEP_URL`, `ENV_CONNECTION_1_DEP_TOKEN`) and CSV directory.
  - Scheduling variables used by the ETL framework (`ETL_VAR_*`, `ETL_CUS_WEEKS`, `ETL_CUS_MIN_DAYS`).
- Ensure SQL objects in `SQL_SCHEMA/DataIntegration/eda` are deployed to the `DataIntegration` database (tables, views, and proc listed below).
- Optional: apply ETLFramework metadata from `ETL Deploy Script/ETL EDA Deputy Processor.sql` to register job code **6002**.

## Connection / Configuration Strategy
- Connection managers use expressions bound to project parameters:
  - `0 DI DB` → `DataIntegration` (system.DataIntegration).
  - `1 ETL Framework` → `ETLFramework` (system.ETLFramework).
  - `0 DW FSGS` → `ODS_NZ_SEC` (user.ods_nz_sec).
  - `0 SMTP Server` → `SMTP.wilson.com` (non-SSL, no Windows auth).
- Project parameters hold runtime context (execution/run codes, date ranges, framework flag), Deputy API details, and CSV settings. Package parameters are primarily CSV metadata for extract packages.

## Database Dependencies (DataIntegration unless noted)
| Object | Purpose / Usage |
| --- | --- |
| `eda.ETL_EVENT` | Event control table; rows created externally or by extract packages; status, timing, user email, execution id tracked. |
| `eda.ETL_EVENT_VARIABLES` | Per-event parameters (e.g., `EXTRACT_FROM`, `EXTRACT_TO`, `EXTRACT_STAGETYPE`, `EXTRACT_TYPE`); loaded into package variables by `0 Job Plan`. |
| `eda.ETL_EVENT_RECENT` (view) | Convenience view joining recent events to key variables. |
| `eda.UPDATE_EVENT_STATUS` (proc) | Central status updater; writes status, execution id, start/end dates based on current state. |
| `eda.EXT_DEP_FULL` | Full extract fact table built in `4 Full Extract Build`; source for billing/payroll/subcontractor outputs. |
| `eda.IMP_DEPRESOURCE` | Deputy API payload queue; populated by billing/payroll/general-resource packages; processed by `9 Deputy Resource Post` / `9 Timesheet Paid`. |
| `eda.IMP_DEPEMPEECUSTOM`, `eda.IMP_DEPEMPAGMIGRATE`, `eda.IMP_DEPTIMESHEETFIX`, `eda.IMP_DEPLEAVE` | Payload tables for specific Deputy actions (custom fields, agreement migration, timesheet fixes, leave import). |
| `eda.STG_UNAPPROVEDTS` | Filter list used by `9 Timesheet Paid` to remove unapproved timesheets before posting. |
| Staging tables `eda.STG_DEP_*`, `STG_DEPTIMESHEET*`, `STG_ASSIGN*`, etc. | Populated by `2 Stage Deputy` with raw Deputy data; inputs to the full extract and downstream transformations. |
| Lookup tables `eda.LKP_DEP_*`, `eda.LKP_WorkingDay`, `eda.LKP_PHTRACKER` | Built/refreshed during staging and full-extract steps to support rate, area, and PH logic. |
| DW lookups (schema `dw`, `lookup` in `ODS_NZ_SEC`) | Referenced by `4 Full Extract Build` for working-day calculations and public holiday mapping. |

## Package Inventory
- **0 Job Plan.dtsx (master/orchestrator)**: Polls `eda.ETL_EVENT` (ETL_REF=6002) for `NEW/RETRY/WAIT` events with kickoff time ≤ now; loads `ETL_EVENT_VARIABLES`; routes per event type/output; updates statuses via `eda.UPDATE_EVENT_STATUS`; handles errors with custom script + ETL_EVENT update.
- **2 Stage Deputy.dtsx**: Extracts Deputy source data into staging tables `eda.STG_DEP_*`, `STG_ASSIGN*`, etc.
- **1 Lookup Greentree.dtsx**: Builds Greentree lookups referenced by later transformations.
- **4 Full Extract Build.dtsx**: Transforms staging into `eda.EXT_DEP_FULL`, `eda.LKP_WorkingDay`, PH tracking; heavy SQL using DW (`ODS_NZ_SEC`) and project params `ETL_CUS_WEEKS`/`ETL_CUS_MIN_DAYS`.
- **5 Billing Extract.dtsx**: Creates a new `eda.ETL_EVENT` targeting Deputy (output DEPUTY, input GENERAL RESOURCE) and inserts invoice JSON batches into `eda.IMP_DEPRESOURCE` from `eda.EXT_DEP_FULL` (filters PayApproved, product codes `SG%`/`RBSG%`).
- **5 Payroll Extract.dtsx**: Two SQL tasks—(a) mark exported timesheets via `IMP_DEPRESOURCE` (output DEPUTY, input GENERAL RESOURCE); (b) queue paid events per pay period (input TIMESHEET PAID) with grouped `TimesheetIdArray` payloads.
- **5 Subcontractor Extract.dtsx**: Disabled unless EVENT_OUTPUT=`SUBCONTRACTOR`; produces subcontractor CSV/payloads (details in package).
- **9 Deputy Resource Post.dtsx**: Posts `eda.IMP_DEPRESOURCE` batches to Deputy; cleans staging rows (e.g., delete eventId = -100, update staged eventId).
- **9 Agreement Migration.dtsx**, **9 Employee Custom.dtsx**, **9 Leave Import.dtsx**, **9 Timesheet Paid.dtsx**, **9 Timesheet Process.dtsx**: Execute Deputy API operations using respective IMP_* tables; `9 Timesheet Paid` adjusts `IMP_DEPRESOURCE` payloads excluding `eda.STG_UNAPPROVEDTS`.
- **3 Register Updates.dtsx**, **9 Employee Workplace.dtsx**, **9 Deputy Resource Post.dtsx**, etc.: Ancillary packages referenced by the orchestrator for specific event inputs.

## Operational Notes
- Trigger: External process (or scripts in `/BCP SQL Scripts`) inserts into `eda.ETL_EVENT`; `0 Job Plan` polls minutely per ETLFramework config (job code 6002).
- Looping/filtering: `0 Job Plan` updates future-dated `NEW` events to `WAIT`, then selects ETL_REF=6002 where status in (`NEW`,`RETRY`,`WAIT`) and `EVENT_KICKOFF_DATE` ≤ current run time.
- Routing: `EVENT_INPUT` drives staging/extract vs. upload package selection; `EVENT_OUTPUT` controls whether CSV extracts or Deputy API uploads run.
- Status progression (per `eda.UPDATE_EVENT_STATUS` calls): `NEW/RETRY/WAIT` → `Extracting from Deputy` → `Processing Deputy Data` → (optional) Deputy upload status `Importing to Deputy` → `Completed` (or retry/error via handler). `EVENT_EXECUTION_ID`, `EVENT_DATE_START/END`, `EVENT_COMMENT` are set by the proc and OnError handler.
- Idempotency/locking: Status flags gate processing; no explicit row-level locks beyond status checks—coordinate concurrent runners carefully.
- Concurrency/backoff: Not defined in packages; retries rely on resetting `EVENT_STATUS` to `RETRY`.
- Logging: Primary logging via `eda.ETL_EVENT` fields; `eda.IMP_DEPRESOURCE.responseMsg` captures Deputy responses; `event_comment` appended on errors.
- Typical run cadence: Configured for minutely polling; run times depend on Deputy API and extract sizes (not specified in repo).

## Troubleshooting Tips
- No events picked up: Confirm `eda.ETL_EVENT` has ETL_REF=6002 with status `NEW/RETRY/WAIT` and kickoff ≤ current time; ensure `ENV_CONNECTION_*` parameters point to correct DB.
- Stuck in `WAIT`: Kickoff date in future; adjust `EVENT_KICKOFF_DATE` or wait for scheduled time.
- Failed Deputy uploads: Check `eda.IMP_DEPRESOURCE.responseMsg`, `eda.IMP_DEPEMPEECUSTOM.processOutcome`, and Deputy API logs; `Resource Check` is currently disabled by expression for non-resource events.
- CSV extracts disabled unexpectedly: Package disable expressions compare `EVENT_OUTPUT` to `BILLING`/`PAYROLL`/`SUBCONTRACTOR`; ensure event values match exactly.
- Public holiday/working-day issues: Validate `eda.LKP_WorkingDay`, `eda.LKP_PHTRACKER`, and DW lookups in `ODS_NZ_SEC`.

## Assumptions / Gaps / Questions to Confirm
- Deputy upload packages (API calls, retry policies, and response handling) are inferred from payload tables; exact HTTP behavior is inside the DTSX components and not explicit in SQL.
- `2 Stage Deputy.dtsx` internals are not fully documented here; assumed to populate all `eda.STG_*` tables from Deputy APIs.
- OnError handler relies on variables such as `ERR_FAIL_STATUS`, `ERR_MAX_FAIL`; expected values/usage are not documented—confirm desired failure status (`Retry` vs `Error`) and rollback SQL in `Data Roll Back`.
- No explicit dead-letter or max-attempt logic is present; determine operational policy for repeated failures.
- Run-time scheduling parameters (ETL_VAR_EXECUTION_ID, ETL_VAR_RUN_CODE/DATE) need to be set by the calling framework; defaults in `Project.params` may require override per environment.
