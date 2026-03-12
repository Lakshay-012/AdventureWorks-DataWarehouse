-- DATA CLEANING OF bronze.brz_emp_department_history
SELECT * FROM bronze.brz_emp_department_history;

-- CHECKING FOR DUPLICATES IN PRIMARY KEY
SELECT BusinessEntityID, DepartmentID, ShiftID, StartDate, COUNT(*)
FROM bronze.brz_emp_department_history
GROUP BY BusinessEntityID, DepartmentID, ShiftID, StartDate
HAVING COUNT(*) > 1;

-- CHECKING FOR NULLS IN PRIMARY KEY
SELECT BusinessEntityID, DepartmentID, ShiftID, StartDate
FROM bronze.brz_emp_department_history
WHERE BusinessEntityID IS NULL
OR DepartmentID IS NULL
OR ShiftID IS NULL
OR StartDate IS NULL;

-- CHECKING FK BusinessEntityID
SELECT BusinessEntityID
FROM bronze.brz_emp_department_history
WHERE BusinessEntityID NOT IN (
    SELECT BusinessEntityID FROM bronze.brz_employee
)
AND BusinessEntityID IS NOT NULL;

-- CHECKING FK DepartmentID
SELECT DepartmentID
FROM bronze.brz_emp_department_history
WHERE DepartmentID NOT IN (
    SELECT DepartmentID FROM bronze.brz_department
)
AND DepartmentID IS NOT NULL;

-- CHECKING FOR INCONSISTENT DATES
SELECT *
FROM bronze.brz_emp_department_history
WHERE StartDate > EndDate;

-- CHECKING FOR NULLS IN EndDate
-- NULL EndDate means employee is still in this department
SELECT COUNT(*) AS NullCount
FROM bronze.brz_emp_department_history
WHERE EndDate IS NULL;