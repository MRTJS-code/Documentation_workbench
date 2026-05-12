# DPDISSIS Repo README

## Summary

This repo contains the DPSSIS Deputy SSIS project and supporting SQL schema exports. The SSIS entry package is `0 Job Plan.dtsx`; it orchestrates lookup refreshes, Deputy staging extracts, dimension and fact builds, QA checks, and fixed-mode EDA/table copies.

## Structure

| Path | Contents |
|---|---|
| `*.dtsx` | SSIS packages. |
| `*.conmgr` | Project connection managers. |
| `Job ODS NZ Deputy.dtproj` | SSIS project file. |
| `Project.params` | Project parameters and local defaults. |
| `ETL SQL/ETL UAT Setup Script.sql` | ETL Framework setup/update script for job codes `8005` and `8006`. |
| `SQL_SCHEMA/DataIntegration` | DataIntegration schema definitions, including EDA objects. |
| `SQL_SCHEMA/ODS_NZ_SEC` | ODS/DW/staging/lookup/QA schema definitions. |
| `ETL_Documentation` | Framework docs and generated DPDISSIS documentation. |

## Generated Documentation

- `ETL_Documentation/DPSSIS_Technical_README.md`
- `ETL_Documentation/DPSSIS_Process_Draft.md`
- `ETL_Documentation/DPSSIS_Enhancements.md`
- `ETL_Documentation/DPSSIS_Repo_README.md`

## How To Rerun Documentation

Use the prompt in `promptEngineer.md` with:

- `{ProjectName}` = `DPSSIS`
- `{RepoPath}` = repo root
- `{SqlSchemaPath}` = `SQL_SCHEMA`
- `{EtfDocsPath}` = `ETL_Documentation`

Required evidence checks:

1. Scan `*.dtsx`, `*.dtproj`, `Project.params`, and `*.conmgr`.
2. Extract `DTS:ObjectName`, `DTS:ExecutableType`, `SQLTask:SqlStatementSource`, `OpenRowset`, and `SqlCommand` values.
3. Cross-check referenced DB objects against `SQL_SCHEMA`.
4. Read `ETL SQL/ETL UAT Setup Script.sql` for framework job config.
5. Read ETL Framework docs for status, dependency, parameter, run, retry, and timeout behavior.
6. Mark gaps where package or schema evidence is missing.

## Known Gaps

- No folder or project file named `DPSSIS` exists; the Deputy SSIS project is at repo root.  Copy the subdiretory in as is from the ODS_NZ_SEC repository for future documentation builds
- Framework table DDL for `metadata.CTL_*` objects is not included in `SQL_SCHEMA`.
- EDA event control tables exist, but the SSIS packages do not reference them because they're not relevant to this project.
- Requested retry variable names `ERR_MAX_FAIL` and `ERR_PRIOR_FAIL_COUNT` were not found in repo text - also not relevant to this repo.
