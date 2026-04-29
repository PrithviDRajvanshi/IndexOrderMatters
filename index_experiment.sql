-- index_experiment.sql
-- Use this file to reproduce the composite index investigation.

-- Step 1: Analyze the query plan for the slow query
EXPLAIN ANALYZE
SELECT *
FROM employees
WHERE department = 'Sales'
  AND salary > 50000;

-- Step 2: Recreate the incorrect composite index order (if needed)
DROP INDEX IF EXISTS idx_salary_department;
CREATE INDEX idx_salary_department ON employees(salary, department);

-- Step 3: Re-run the query to observe if the incorrect index helps
EXPLAIN ANALYZE
SELECT *
FROM employees
WHERE department = 'Sales'
  AND salary > 50000;

-- Step 4: Fix the composite index order
DROP INDEX IF EXISTS idx_salary_department;
CREATE INDEX idx_department_salary ON employees(department, salary);

-- Step 5: Re-run the query and compare the improved plan
EXPLAIN ANALYZE
SELECT *
FROM employees
WHERE department = 'Sales'
  AND salary > 50000;