-- DATA CLEANING OF bronze.brz_department
SELECT * FROM bronze.brz_department;

-- CHECKING FOR DUPLICATES IN PRIMARY KEY
SELECT DepartmentID, COUNT(*)
FROM bronze.brz_department
GROUP BY DepartmentID
HAVING COUNT(*) > 1;

-- CHECKING FOR NULLS IN PRIMARY KEY
SELECT DepartmentID
FROM bronze.brz_department
WHERE DepartmentID IS NULL;

-- CHECKING FOR NULLS AND WHITESPACES IN Name
SELECT Name
FROM bronze.brz_department
WHERE Name IS NULL OR Name != TRIM(Name);

-- CHECKING FOR NULLS AND WHITESPACES IN GroupName
SELECT GroupName
FROM bronze.brz_department
WHERE GroupName IS NULL OR GroupName != TRIM(GroupName);