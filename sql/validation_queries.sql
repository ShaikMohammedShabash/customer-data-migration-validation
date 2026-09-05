-- Customer Data Migration & Validation Project
-- Database: SQLite-compatible SQL
-- Purpose: Validate source-to-target customer migration

-- 1. Row count reconciliation
SELECT 'SOURCE' AS dataset, COUNT(*) AS row_count FROM customers_source
UNION ALL
SELECT 'TARGET', COUNT(*) FROM customers_target;

-- 2. Duplicate customer IDs in target
SELECT customer_id, COUNT(*) AS occurrence_count
FROM customers_target
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- 3. NULL checks
SELECT *
FROM customers_target
WHERE customer_id IS NULL
   OR customer_name IS NULL
   OR email IS NULL
   OR phone IS NULL
   OR city IS NULL
   OR signup_date IS NULL
   OR status IS NULL
   OR annual_income IS NULL;

-- 4. Invalid phone format
SELECT *
FROM customers_target
WHERE LENGTH(phone) <> 10
   OR phone NOT GLOB '[0-9]*';

-- 5. Invalid status values
SELECT DISTINCT status
FROM customers_target
WHERE UPPER(status) NOT IN ('ACTIVE', 'INACTIVE');

-- 6. Source-to-target reconciliation: records missing in target
SELECT s.customer_id
FROM customers_source s
LEFT JOIN customers_target t ON s.customer_id = t.customer_id
WHERE t.customer_id IS NULL;

-- 7. Records present only in target
SELECT t.customer_id
FROM customers_target t
LEFT JOIN customers_source s ON s.customer_id = t.customer_id
WHERE s.customer_id IS NULL;

-- 8. Field-level mismatch checks
SELECT
    s.customer_id,
    s.customer_name AS source_name, t.customer_name AS target_name,
    s.email AS source_email, t.email AS target_email,
    s.phone AS source_phone, t.phone AS target_phone,
    s.city AS source_city, t.city AS target_city,
    s.status AS source_status, t.status AS target_status,
    s.annual_income AS source_income, t.annual_income AS target_income
FROM customers_source s
JOIN customers_target t ON s.customer_id = t.customer_id
WHERE TRIM(s.customer_name) <> TRIM(t.customer_name)
   OR LOWER(TRIM(COALESCE(s.email,''))) <> LOWER(TRIM(COALESCE(t.email,'')))
   OR TRIM(COALESCE(s.phone,'')) <> TRIM(COALESCE(t.phone,''))
   OR LOWER(TRIM(COALESCE(s.city,''))) <> LOWER(TRIM(COALESCE(t.city,'')))
   OR UPPER(TRIM(COALESCE(s.status,''))) <> UPPER(TRIM(COALESCE(t.status,'')))
   OR s.annual_income <> t.annual_income;

-- 9. Whitespace detection
SELECT *
FROM customers_target
WHERE customer_name <> TRIM(customer_name)
   OR email <> TRIM(email)
   OR city <> TRIM(city)
   OR status <> TRIM(status);

-- 10. Final duplicate-safe reconciliation
SELECT COUNT(DISTINCT customer_id) AS distinct_target_customers
FROM customers_target;
