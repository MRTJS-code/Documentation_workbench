# DPDISSIS Technical README

## Purpose

DPDISSIS is an SSIS project for Deputy data loading into ODS/DW and DataIntegration schemas. The local SSIS project file is `Job ODS NZ Deputy.dtproj`; the ETL Framework setup script names the deployed project `Job ODS NZ SEC Deputy`. Inferred: these are the same load family, based on both referencing `0 Job Plan.dtsx` and Deputy job codes `8005` and `8006`.

## Evidence Sources

- SSIS packages and project files in repo root.
- SQL schema definitions under `SQL_SCHEMA`.
- ETL Framework documents in `ETL_Documentation`.
- ETL setup script `ETL SQL/ETL UAT Setup Script.sql`.

## Prerequisites

- SSIS project deployment model.
- SSIS catalog folder from framework config: `Operational Data Store`.
- Entry package: `0 Job Plan.dtsx`.
- Project parameters must be mapped to SSIS environment variables for `ENV_CONNECTION_*` values.
- Deputy API access through `ENV_CONNECTION_1_DEP_URL` and sensitive `ENV_CONNECTION_1_DEP_TOKEN`.
- CSV directory from project parameter `ENV_CONNECTION_1_CSV_DIR`.

## Connections

| Connection manager | Type | Default target | Parameterized by |
|---|---|---|---|
| `0 DW FSGS.conmgr` | OLE DB | `PER1CORPUATSQL1`, `ODS_NZ_SEC`, `user.ods_nz_sec` | `ENV_CONNECTION_0_ODS_NZ_SEC_*` |
| `0 DI DB.conmgr` | OLE DB | `PER1CORPUATSQL1`, `DataIntegration`, `system.DataIntegration` | `ENV_CONNECTION_0_DI_*` |
| `0 AKL ODS.conmgr` | OLE DB | `AKL1SECSQL2`, `ODS_SEC`, `system.OperationalDataStore` | `ENV_CONNECTION_0_AKL_ODS_SEC_*` |
| `1 ETL Framework.conmgr` | OLE DB | `PER1CORPDEVSQL1`, `ETLFramework`, `system.ETLFramework` | `ENV_CONNECTION_0_ETL_*` |
| `0 SMTP Server.conmgr` | SMTP | `SMTP.wilson.com` | connection string in conmgr |

Sensitive parameters include database passwords and the Deputy token.

## Framework Configuration

`ETL SQL/ETL UAT Setup Script.sql` configures:

| Job code | Job name | Mode | Cadence | Package | Notes |
|---|---|---|---|---|---|
| `8005` | `Job DW NZ Deputy Delta` | `DELTA` | hourly | `0 Job Plan.dtsx` | Paused in script; excludes `00:00` for 2 hours daily. |
| `8006` | `Job DW NZ Deputy Fixed` | `FIXED` | daily | `0 Job Plan.dtsx` | Paused in script; has custom rebuild date variable. |

`metadata.CTL_JOB_CONFIG_VARIABLES` sets `ETL_CUS_REBUILD_DATE` for job `8006`. The setup script value is `2025-11-24`; `Project.params` default is `2026-01-12`. Treat the framework table as runtime override when enabled.

`metadata.CTL_JOB_CONFIG_DEPENDENCIES` adds `8005` depends on `8006` with dependency type `SUCCESSIVE`, meaning they must not run at the same time. The framework docs state successive dependencies do not define execution order; order is controlled by framework load ordering.

## Runtime Parameters

Key framework parameters used by packages:

- `ETL_VAR_DATA_RANGE_MODE`: gates DELTA versus FIXED tasks.
- `ETL_VAR_RUN_DATE`: passed to roster maintenance and QA checks.
- `ETL_VAR_JOB_CODE`, `ETL_VAR_RUN_CODE`, `ETL_VAR_EXECUTION_ID`: stamped into dimension/fact loads.
- `ETL_CUS_REBUILD_DATE`: used for FIXED rebuilds and some API extracts.
- `ETL_VAR_IS_FRAMEWORK_FLAG`: controls framework-only pre-task behavior.

## Package Inventory

| Package | Role | Key tasks | SQL touchpoints |
|---|---|---|---|
| `0 Job Plan.dtsx` | Orchestrator | Executes lookup, staging, dimension, fact, QA, EDA copy, table copy packages. | No direct SQL statements found. |
| `1 Lookup Updates.dtsx` | Lookup refresh from CSV/API/EDA sources | `LKP Branch PH (maps Deputy and Preceda branch names to a regional public holiday record)`, `LKP Depot Branch (maps Deputy branch locations to D365 Regions)`, `LKP Rate Cards`, `Truncate LKP` | `lookup.DEP_BRANCHPH`, `lookup.DEP_DEPOTBRANCH`, `lookup.DEP_WorkAreas`, `eda.LKP_DEP_RateCard`, `eda.LKP_DEP_WorkArea` |
| `2 Stage Deputy Employee.dtsx` | Employee-related Deputy staging and temp dimension/fact staging | API/script pipelines for employee, agreement, workplace, training, paycycle; merge tasks | `staging.DEP_Employee`, `staging.DEP_EmployeeAgreement`, `staging.DEP_EmployeeBranchLocation`, `staging.DEP_EmployeeWorkplace`, `staging.DEP_EmployeeTraining`, `staging.DEP_EmployeePaycycle`, `staging.DEP_AGREEHISTORY`, `staging.DEP_Payrules`, `staging.DIM_DEPEMPLOYEEWORKPLACE`, `staging.FCT_DEP_EmployeePaycycle` |
| `2 Stage Deputy Leave.dtsx` | Leave staging and temp fact staging | `Leave`, `FCT Merge`, `Rebuild SQL`, modified-date lookups | `staging.DEP_Leave`, `staging.DEP_LeaveLine`, `staging.FCT_DEP_LEAVE`, `staging.FCT_DEP_LEAVELINE` |
| `2 Stage Deputy Loc Area.dtsx` | Location, area, company period, leave rule, training staging | `STG DEP Area`, `STG DEP CompanyPeriod`, `STG DEP LeaveRules`, `STG DEP Location`, `STG DEP Training` | `staging.DEP_Area`, `staging.DEP_AreaTraining`, `staging.DEP_CompanyPeriod`, `staging.DEP_LeaveRules`, `staging.DEP_Location`, `staging.DEP_TrainingModule` |
| `2 Stage Deputy Roster.dtsx` | Roster staging, temp fact staging, leave/roster tracker | `Roster`, `Maintain leave roster tracker`, `Temp FCT Merge`, `Temp FCT Rebuild` | `staging.DEP_Roster`, `staging.FCT_DEP_ROSTER`, `staging.DEP_LeaveLine`, `staging.DEP_EmployeeAgreement`, `lookup.DEP_LeaveRosterTracker` |
| `2 Stage Deputy Timesheet.dtsx` | Timesheet staging and temp fact staging | `Timesheets`, `FCT MERGE`, `FCT Rebuild`, modified-date lookup | `staging.DEP_Timesheet`, `staging.FCT_DEP_TIMESHEET` |
| `3 Deputy Dimensions.dtsx` | Builds Deputy dimensions | `DIM_AREA`, `DIM_CLIENTLOCATION`, `DIM_DEPOT`, `DIM_GUARDAGREEHISTORY`, `DIM_GUARDAGREEMENT`, `DIM_LEAVETYPE`, `DIM_SECURITYGUARD` | `dw.DIM_AREA`, `dw.DIM_CLIENTLOCATION`, `dw.DIM_DEPOT`, `dw.DIM_GUARDAGREEHIST`, `dw.DIM_GUARDAGREEMENT`, `dw.DIM_LEAVETYPE`, `dw.DIM_SECURITYGUARD`, plus staging/lookup inputs |
| `4 Deputy Facts.dtsx` | Builds Deputy facts | `FACT Roster`, `FACT Timesheet` | `dw.FACT_ROSTER`, `dw.FACT_TIMESHEET`, `dw.DIM_DATE`, `dw.DIM_SECURITYGUARD`, `dw.DIM_AREA`, `dw.DIM_GUARDAGREEMENT`, `dw.DIM_JOB`, `dw.DIM_JOB_PRICE`, `dw.DIM_LEAVETYPE`, `lookup.DEP_WorkAreas`, `lookup.DEP_ClientTier` |
| `5 Quality Assurance Builds.dtsx` | Builds QA issue checks | 11 Execute SQL tasks for location, timesheet, roster, area, guard checks | `qa.QualityIssueCapture`, `qa.QualityDetail`, `qa.QualityDwhError`, `qa.ProcessQualityIssues`, `dw.*` dimensions/facts |
| `9 BCP Data Copies.dtsx` | Copies leave/roster tracker between ODS and DataIntegration | `AKL Truncate`, `DIDB Truncate`, data flow copies | `lookup.DEP_LeaveRosterTracker`, `eda.LKP_DEP_LeaveRosterTracker` |
| `9 EDA Data Copies.dtsx` | Copies location/work area reference data to DataIntegration EDA | `EDA Locations`, `EDA WorkAreas` | `dw.DIM_CLIENTLOCATION`, `dw.DIM_AREA`, `eda.LKP_DEP_Location`, `eda.LKP_DEP_WorkArea` |

## Orchestrator Flow

`0 Job Plan.dtsx` runs:

1. `9 DW Pre Tasks`, enabled only when `ETL_VAR_IS_FRAMEWORK_FLAG` is true. No child tasks were found in this container.
2. `0 Job`, the main load.
3. `9 DW Post Tasks`, which runs EDA and table copy packages.

Within `0 Job`:

- `1 Lookup Tables` runs before staging/dim/fact flow; `Deputy Branch Public Holiday` is disabled when `ETL_VAR_DATA_RANGE_MODE == "DELTA"`.
- `2 Staging Tables` includes employee, loc/area, roster, timesheet, and leave packages. Several packages have DELTA-specific merge tasks and FIXED-specific rebuild tasks.
- `3 Dimension Tables` runs after staging.
- `4 Factual Tables` runs after dimensions, then QA runs after facts.
- `5 Aggregate Tables`, `6 Conformed Tables`, and `7 Semantic Layer` containers exist but contain no executable tasks in the package.

## DB Object Roles

| Object group | Role |
|---|---|
| `staging.DEP_*` | Raw/staged Deputy extracts loaded by SSIS data flows. |
| `staging.FCT_DEP_*` and `staging.DIM_DEPEMPLOYEEWORKPLACE` | Intermediate merged staging tables used before DW loads. |
| `lookup.DEP_*` | Manual/derived lookup tables used for branch holidays, depot/branch mapping, work areas, client tiers, and leave/roster tracker. |
| `dw.DIM_*` | Warehouse dimensions built from Deputy staging and lookup objects. |
| `dw.FACT_*` | Warehouse facts for roster and timesheet. |
| `qa.*` | QA issue capture, detail, DWH error tracking, and issue processing. |
| `eda.LKP_DEP_*` | DataIntegration EDA lookup copies sourced from ODS/DW lookup and dimension tables. |
| `eda.ETL_EVENT*` | Event control schema exists, but no package reference was found in this SSIS project. |

All listed objects have matching SQL definitions under `SQL_SCHEMA` except the package text references `lookup.DEP_ClientTiers`; the schema file present is `lookup.DEP_ClientTier.sql`. Inferred: the plural reference may be an alias, typo, or stale package text; verify in SQL Server before deployment.

## Operational Notes

- DELTA mode uses max modified dates from temp fact/staging tables and disables fixed rebuild tasks.
- FIXED mode uses `ETL_CUS_REBUILD_DATE` and rebuild logic for leave, roster, timesheet, facts, and selected lookup/post-copy tasks.
- Data flows use script components that read Deputy URL/token parameters and framework date range parameters.
- QA tasks currently contain commented calls to `qa.ProcessQualityIssues` in the package SQL text. This means the package may build capture sets without applying the central QA procedure unless those comments are intentional design remnants.

## Troubleshooting

- If a job does not start, check `metadata.CTL_JOB_CONFIG.JOB_STATUS`, `JOB_DATE_KICK_OFF`, dependency rows, and whether job codes `8005`/`8006` are paused.
- If Delta returns no data, check `ETL_VAR_DATA_RANGE_MODE`, max modified tables, and Deputy API parameters.
- If Fixed rebuild output is unexpected, compare `ETL_CUS_REBUILD_DATE` in `CTL_JOB_CONFIG_VARIABLES` with `Project.params`.
- If dimensions/facts do not refresh, verify staging tables were populated and package disable expressions were evaluated for the intended mode.
- If EDA copies do not run, confirm post tasks are running only in `FIXED` mode as configured by package disable expressions.

## Assumptions and Gaps

- Inferred: `DPDISSIS` refers to this root SSIS project because no folder or project file named `DPDISSIS` exists, but the root contains a complete Deputy SSIS project.
- Gap: ETL Framework table DDL for `metadata.CTL_JOB_CONFIG`, `metadata.CTL_JOB_CONFIG_VARIABLES`, `metadata.CTL_JOB_CONFIG_DEPENDENCIES`, and `metadata.CTL_RUN` is not present in `SQL_SCHEMA`; behavior is documented from framework docs and setup SQL.
- Gap: `eda.ETL_EVENT`, `eda.ETL_EVENT_VARIABLES`, `eda.ETL_EVENT_RECENT`, and `eda.UPDATE_EVENT_STATUS` exist in SQL schema, but no SSIS package reference to them was found.
- Gap: Framework docs mention retry variables `ERR_MAX_FAIL` and `ERR_PRIOR_FAIL_COUNT`, but no package or schema reference to those exact variable names was found.
- Gap: Several package internal object names are still `Package1`; file names are more descriptive than package object names.
