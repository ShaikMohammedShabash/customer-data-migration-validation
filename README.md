# Customer Data Migration & Validation System

> A practical data-quality and ETL validation project demonstrating source-to-target reconciliation, SQL validation, defect identification, Root Cause Analysis (RCA), and Excel reporting.

---

## 📌 Project Overview

This project simulates a real-world **customer data migration** from a source system to a target system.

The objective is to validate whether customer records migrated from the source dataset to the target dataset are:

- Complete
- Accurate
- Unique
- Consistent
- Correctly formatted
- Properly reconciled

### Project Flow

```text
Source CSV
    ↓
ETL / Data Transformation
    ↓
Target CSV
    ↓
SQL Data Validation
    ↓
Source vs Target Reconciliation
    ↓
Data Quality Checks
    ↓
Defect Identification
    ↓
Root Cause Analysis
    ↓
Excel Data Quality Report
```

---

## 🎯 Business Objective

During a data migration, incorrect or incomplete customer records can affect reporting, customer communication, and downstream business processes.

The objective of this project is to validate migrated customer data and identify defects before the target data is approved for business use.

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| SQL / SQLite | Data validation and source-to-target reconciliation |
| Excel | Data quality reporting and analysis |
| CSV | Source and target datasets |
| Python | Practice dataset generation and verification |
| Git / GitHub | Version control and project documentation |

---

## 📂 Repository Structure

```text
customer-data-migration-validation/
│
├── data/
│   ├── customers_source.csv
│   └── customers_target.csv
│
├── sql/
│   └── validation_queries.sql
│
├── data_quality/
│   ├── data_quality_checks.csv
│   ├── duplicate_records.csv
│   ├── null_records.csv
│   ├── invalid_phone_records.csv
│   └── whitespace_issues.csv
│
├── reconciliation/
│   ├── reconciliation_summary.csv
│   └── field_level_mismatches.csv
│
├── rca/
│   └── RCA_document.md
│
├── excel_report/
│   └── customer_migration_validation_report.xlsx
│
├── docs/
│   └── data_dictionary.csv
│
├── screenshots/
│
├── README.md
├── LICENSE
└── .gitignore
```

---

## 🔍 Data Validation Performed

The following validation checks were performed to assess the quality and accuracy of the migrated customer data.

### 1. Row Count Reconciliation

Compared source and target record counts to identify unexpected additions or missing records.

**Result:**

```text
Source Records : 15
Target Records : 16

Status: FAIL
```

---

### 2. Duplicate Customer ID Validation

Checked whether `customer_id` was unique in the target dataset.

**Result:**

```text
Duplicate Customer ID: 1005

Status: FAIL
```

---

### 3. NULL / Completeness Validation

Validated mandatory fields including:

- Customer ID
- Customer Name
- Email
- Phone
- City
- Signup Date
- Status
- Annual Income

**Result:**

```text
Customer ID 1006 → Email is NULL

Status: FAIL
```

---

### 4. Phone Format Validation

Validated that customer phone numbers contain exactly 10 digits.

**Result:**

```text
Customer ID 1008
Target Phone: 909090909

Status: FAIL
```

---

### 5. Status / Domain Validation

Validated customer status against the expected business domain:

```text
ACTIVE
INACTIVE
```

Status values were also reviewed for formatting consistency.

---

### 6. Missing Record Detection

Used source-to-target reconciliation to identify customers that exist in the source but are missing from the target.

```text
Missing Source Records: 0

Status: PASS
```

---

### 7. Extra Record Detection

Checked for customer IDs that exist in the target but not in the source.

```text
Unknown Customer IDs: 0

Status: PASS
```

---

### 8. Field-Level Reconciliation

Compared important customer attributes between source and target.

**Fields validated:**

- Customer Name
- Email
- Phone
- City
- Status
- Annual Income

**Examples of identified issues:**

```text
Customer 1004 → City mismatch
Customer 1006 → Email missing
Customer 1008 → Phone mismatch
Customer 1010 → Name whitespace issue
Customer 1012 → Annual income mismatch
```

---

### 9. Whitespace Validation

Checked text fields for leading and trailing spaces.

```text
Customer ID 1010
Field: customer_name

Status: FAIL
```

---

## 📊 Data Quality Results

| Validation Check | Result |
|---|---:|
| Source Records | 15 |
| Target Records | 16 |
| Duplicate Target IDs | 1 |
| NULL Issues | 1 |
| Invalid Phone Records | 1 |
| Field-Level Mismatch Records | 5 |
| Whitespace Issues | 1 |
| Missing Source IDs in Target | 0 |
| Extra Customer IDs | 0 |
| Overall Migration Status | ❌ FAIL |

### Overall Conclusion

The migration should **not be approved without remediation** because multiple target-side data-quality issues were identified.

---

## 🚨 Key Defects Identified

| Defect | Customer | Impact |
|---|---:|---|
| Duplicate record | 1005 | Inflated target record count |
| NULL email | 1006 | Incomplete customer contact data |
| Invalid phone | 1008 | Invalid customer contact information |
| City mismatch | 1004 | Incorrect customer location |
| Whitespace issue | 1010 | Data inconsistency |
| Income mismatch | 1012 | Incorrect customer financial information |
| Status formatting | 1014 | Inconsistent reporting format |

---

## 🧠 Root Cause Analysis

Detailed Root Cause Analysis is available in:

`rca/RCA_document.md`

### Primary Root Causes

The identified issues indicate insufficient migration controls around:

- Duplicate prevention
- Mandatory-field validation
- Data transformation
- Format validation
- Reference/master-data validation
- Source-to-target reconciliation
- Post-load data-quality checks

---

## 🔧 Recommended Corrective Actions

### Before Migration

- Validate source data quality
- Define mandatory fields
- Define accepted domain values
- Validate phone and email formats
- Establish unique-key rules

### During ETL

- Apply `TRIM()` to text fields
- Standardize status values
- Validate data types
- Prevent duplicate inserts
- Apply transformation rules consistently

### After Migration

- Compare source and target record counts
- Perform duplicate checks
- Perform NULL checks
- Perform format validation
- Perform source-to-target reconciliation
- Generate exception reports
- Obtain business sign-off only after failed records are resolved

---

## 💻 SQL Skills Demonstrated

The project includes practical SQL validation using:

- `SELECT`
- `WHERE`
- `GROUP BY`
- `HAVING`
- `JOIN`
- `LEFT JOIN`
- `UNION ALL`
- `COUNT()`
- `COUNT(DISTINCT)`
- `TRIM()`
- `LOWER()`
- `UPPER()`
- `LENGTH()`
- `COALESCE()`
- `CASE`

### Example: Duplicate Validation

```sql
SELECT customer_id, COUNT(*) AS occurrence_count
FROM customers_target
GROUP BY customer_id
HAVING COUNT(*) > 1;
```

### Example: Missing Record Validation

```sql
SELECT s.customer_id
FROM customers_source s
LEFT JOIN customers_target t
    ON s.customer_id = t.customer_id
WHERE t.customer_id IS NULL;
```

---

## 📈 Excel Report

The Excel report is available here:

[`customer_migration_validation_report.xlsx`](excel_report/customer_migration_validation_report.xlsx)

The report contains:

- Dashboard
- Data Quality Checks
- Row Reconciliation
- Field Mismatches
- Duplicate Records
- NULL Records
- Invalid Phone Records
- Whitespace Issues
- Source Data
- Target Data

---

## 📖 Data Dictionary

The data dictionary is available here:

[`data_dictionary.csv`](docs/data_dictionary.csv)

| Field | Description |
|---|---|
| `customer_id` | Unique customer identifier |
| `customer_name` | Customer full name |
| `email` | Customer email address |
| `phone` | Customer phone number |
| `city` | Customer city |
| `signup_date` | Customer registration date |
| `status` | Customer account status |
| `annual_income` | Customer annual income |

---

## 📁 Project Deliverables

| Deliverable | Location |
|---|---|
| Source Dataset | `data/customers_source.csv` |
| Target Dataset | `data/customers_target.csv` |
| SQL Validation | `sql/validation_queries.sql` |
| Data Quality Checks | `data_quality/` |
| Reconciliation | `reconciliation/` |
| RCA | `rca/RCA_document.md` |
| Excel Report | `excel_report/` |
| Data Dictionary | `docs/data_dictionary.csv` |

---

## 📌 Key Findings

The migration validation identified multiple data-quality issues in the target dataset, including:

- Duplicate customer records
- Missing mandatory customer information
- Invalid phone number format
- Source-to-target field mismatches
- Whitespace inconsistencies
- Status formatting inconsistency
- Incorrect annual income value

These issues demonstrate why **post-migration validation and reconciliation are critical before approving migrated data for business use**.

---

## 🎯 Interview Explanation

> "I worked on a customer data migration and validation project where I used SQL and Excel to validate source and target datasets, identify data quality issues, perform source-to-target reconciliation, and document root causes. I created validation queries for duplicates, NULL values, invalid formats, missing records, and field-level mismatches. I then summarized the results in an Excel data-quality report and documented corrective actions through RCA."

---

## 🚀 Future Enhancements

Potential future improvements include:

- Automating the validation framework using Python
- Adding automated email alerts for failed validations
- Creating a Power BI dashboard
- Adding configurable validation rules
- Connecting the framework to a relational database
- Implementing automated ETL pipelines
- Adding CI/CD-based data-quality checks

---

## ⭐ Key Takeaway

This project demonstrates practical experience with:

**SQL + Data Validation + ETL/Data Transformation Validation + Data Quality + Reconciliation + RCA + Excel Reporting + GitHub**
