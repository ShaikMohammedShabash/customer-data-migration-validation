# Customer Data Migration & Validation System

## Project Overview
A realistic ETL/data validation portfolio project demonstrating how a QA/Data Analyst validates customer data migrated from a source CSV into a target system.

**Flow:** Source CSV → ETL/Transformation → Target CSV → SQL Validation → Reconciliation → Data Quality Report → RCA → Excel Dashboard

## Business Objective
Validate that customer records migrated from the source system to the target system are:
- Complete
- Unique
- Accurate
- Consistent
- Correctly formatted
- Reconciled at record and field level

## Tools
- SQL / SQLite
- Excel
- CSV
- Python (used only to generate/verify the practice dataset)
- Git/GitHub

## Repository Structure
```text
customer-data-migration-validation/
├── data/
│   ├── customers_source.csv
│   └── customers_target.csv
├── sql/
│   └── validation_queries.sql
├── data_quality/
│   ├── data_quality_checks.csv
│   ├── duplicate_records.csv
│   ├── null_records.csv
│   ├── invalid_phone_records.csv
│   └── whitespace_issues.csv
├── reconciliation/
│   ├── reconciliation_summary.csv
│   └── field_level_mismatches.csv
├── rca/
│   └── RCA_document.md
├── excel_report/
│   └── customer_migration_validation_report.xlsx
├── docs/
│   └── data_dictionary.csv
├── screenshots/
└── README.md
```

## Validation Performed
1. Row count reconciliation
2. Duplicate customer ID detection
3. NULL/completeness validation
4. Phone format validation
5. Status/domain validation
6. Missing-record detection
7. Extra-record detection
8. Field-level source-vs-target reconciliation
9. Whitespace validation

## Results
- Source records: **15**
- Target records: **16**
- Duplicate target customer IDs: **1**
- NULL records: **1**
- Invalid phone records: **1**
- Field-level mismatch records: **5**
- Whitespace issues: **1**
- Overall migration status: **FAIL — remediation required**

## Key Findings
The target contains all source customer IDs, but one customer was duplicated. Several migrated attributes also differ from the source or violate data-quality rules.

## RCA
See `rca/RCA_document.md`.

## Interview Explanation
> "I worked on a customer data migration and validation project where I validated source and target datasets using SQL. I performed record-count reconciliation, duplicate and NULL checks, format and domain validations, and field-level source-to-target reconciliation. I documented the defects, performed RCA, and created an Excel dashboard summarizing data quality results."

## SQL Skills Demonstrated
- SELECT
- WHERE
- GROUP BY
- HAVING
- JOIN
- LEFT JOIN
- UNION ALL
- COUNT
- DISTINCT
- CASE-style validation logic
- String functions such as TRIM, LOWER, UPPER, LENGTH

## Future Enhancements
- Automate validation using Python/SQL
- Add email-format validation
- Add city master-data validation
- Add automated Excel refresh
- Add CI validation on GitHub Actions
