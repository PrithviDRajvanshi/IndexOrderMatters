-- Create employees table
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary NUMERIC,
    hire_date DATE
);

-- Composite index with corrected column order for the query filter pattern
CREATE INDEX idx_department_salary ON employees(department, salary);