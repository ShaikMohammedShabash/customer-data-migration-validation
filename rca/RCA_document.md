# Root Cause Analysis (RCA)

## Executive Summary
The customer migration validation identified several target-side data quality defects. The source contains 15 customer records while the target contains 16 rows. All source customer IDs are present in the target, but customer 1005 is duplicated. Additional attribute-level defects were identified in city, email, phone, customer name, income, and status formatting.

## Defects

| ID | Defect | Customer | Root Cause | Impact | Recommendation |
|---|---|---:|---|---|---|
| D01 | Duplicate record | 1005 | Duplicate insert/retry during load | Inflated target count | Enforce unique key and idempotent load |
| D02 | NULL email | 1006 | Source-to-target mapping/load failure | Incomplete customer contact data | Add NOT NULL/business-rule validation |
| D03 | Invalid phone | 1008 | Transformation/truncation issue | Invalid contact data | Validate 10-digit format before load |
| D04 | City mismatch | 1004 | Transformation/mapping typo | Incorrect customer location | Validate reference/master data |
| D05 | Whitespace | 1010 | Missing TRIM transformation | Inconsistent text values | Apply TRIM during ETL |
| D06 | Income mismatch | 1012 | Incorrect value transformation/load | Financial/customer profile discrepancy | Reconcile numeric fields |
| D07 | Status case mismatch | 1014 | Formatting standard not applied | Inconsistent reporting values | Standardize status to uppercase/lowercase |

## Overall Root Cause
The defects indicate insufficient pre-load transformation controls and post-load validation. The migration process should include schema validation, mandatory-field checks, uniqueness checks, domain validation, format validation, and source-to-target reconciliation before business sign-off.

## Corrective Action Plan
1. Add automated pre-load validation.
2. Enforce target primary/unique key constraints.
3. Standardize text using TRIM and case normalization.
4. Validate phone/email formats.
5. Validate reference values such as city and status.
6. Perform record-count and field-level reconciliation.
7. Generate an exception report for failed records.
8. Re-run validation after remediation.
