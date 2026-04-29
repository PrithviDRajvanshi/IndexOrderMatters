# Document your index fixes here

- Original index: `idx_salary_department ON employees(salary, department)`
- Issue observed: The query filters by `department = ...` first and then `salary > ...`. The existing composite index starts with `salary`, so PostgreSQL cannot use the index efficiently for this filter pattern.
- Fixed index: `idx_department_salary ON employees(department, salary)`
- Performance improvement: The corrected index matches the query's filtering order. PostgreSQL can now use the index for the left-most `department` equality filter and then apply the range scan on `salary`, avoiding a full table scan.

## Why this fix works

The Left-Most Prefix Rule means a composite index is most useful when the query filters starting from the first indexed column. A query on `department` and `salary` will only use the full index when `department` is the first key in the index definition.

With the broken index order, PostgreSQL could not efficiently use the index for `WHERE department = 'Sales' AND salary > 50000`, so the query still performed a sequential scan.

With the corrected index order, the index can be used properly, improving query performance.