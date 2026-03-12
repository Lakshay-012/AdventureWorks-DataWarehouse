-- DATA CLEANING OF THE bronze.brz_employee
SELECT * FROM bronze.brz_employee;

-- CHECKING FOR DUPLICATES IN THE PRIMARY KEY
SELECT
BusinessEntityID,
COUNT(*)
FROM bronze.brz_employee
GROUP BY BusinessEntityID
HAVING COUNT(*) > 1;

-- CHECKING FOR NULLS IN THE PRIMARY KEY
SELECT
BusinessEntityID
FROM bronze.brz_employee
WHERE BusinessEntityID IS NULL;

-- CHECKING THE NULLS FOR NationalIDNumber 
SELECT
NationalIDNumber
FROM bronze.brz_employee
WHERE NationalIDNumber IS NULL;


-- CHECKING FOR DUPLICATES IN NationalIDNumber
SELECT
NationalIDNumber,
COUNT(*)
FROM bronze.brz_employee
GROUP BY NationalIDNumber
HAVING COUNT(*) > 1;

-- CHECKING FOR WHITE SPACES IN THE NationalIDNumber
SELECT
NationalIDNumber
FROM bronze.brz_employee
WHERE NationalIDNumber != TRIM(NationalIDNumber)


-- CHECKEING FRO NULLS IN THE LoginID COLUMN
SELECT
LoginID 
FROM
bronze.brz_employee
WHERE LoginID IS NULL;


-- CHECKING FOR DUPLICATES IN NationalIDNumber
SELECT
LoginID,
COUNT(*)
FROM bronze.brz_employee
GROUP BY LoginID
HAVING COUNT(*) > 1;

-- CHECKING FOR WHITE SPACES IN THE LoginID
SELECT
LoginID
FROM bronze.brz_employee
WHERE LoginID != TRIM(LoginID)

-- CHECKING FOR THE FORMAT OF THE LoginID
SELECT
LoginID
FROM bronze.brz_employee
WHERE LoginID NOT LIKE 'adventure-works\%';


-- CHECKING FRO NULLS IN THE Job Title
SELECT
[JobTitle]
FROM bronze.brz_employee
WHERE JobTitle IS NULL;

-- CHECKING FOR WHITE SPACES IN THE Job Title
SELECT
[JobTitle]
FROM bronze.brz_employee
WHERE JobTitle != TRIM(JobTitle)

-- CHECKING FOR NULL BirthDates
SELECT
BirthDate
FROM bronze.brz_employee
WHERE BirthDate IS NULL

-- CHECKING FOR NULL HireDates
SELECT
HireDate
FROM bronze.brz_employee
WHERE HireDate IS NULL

-- CHECKING FOR INCONSISTENT DATA
SELECT
HireDate,
BirthDate
FROM bronze.brz_employee
WHERE BirthDate > HireDate

-- CHECKING FOR NULLS IN MaritalStatus AND Gender
SELECT
MaritalStatus,
Gender
FROM bronze.brz_employee
WHERE MaritalStatus IS NULL OR Gender IS NULL

-- STANDARIZING THE MartialStatus
SELECT 
CASE 
	WHEN MaritalStatus = 'S' THEN 'Single'
	WHEN MaritalStatus = 'M' THEN 'Married'
	ELSE 'N/A'
END AS MaritalStatus
FROM bronze.brz_employee


-- STANDARIZING THE Gender
SELECT 
CASE 
	WHEN Gender = 'M' THEN 'Male'
	WHEN Gender = 'F' THEN 'Female'
	ELSE 'N/A'
END AS Gender
FROM bronze.brz_employee


-- CHECKING FOR NULLS IN THE SalariedFLag
SELECT
SalariedFLag
FROM bronze.brz_employee
WHERE SalariedFlag IS NULL


-- STANDARIZING THE SalariedFlag
SELECT 
CASE 
	WHEN SalariedFlag = 0 THEN 'Salaried'
	WHEN SalariedFlag = 1 THEN 'Hourly'
	ELSE 'N/A'
END AS SalariedFlag
FROM bronze.brz_employee

-- CHECKING FOR NULLS IN VacationHours , SickLeaveHours 
SELECT
VacationHours,
SickLeaveHours
FROM bronze.brz_employee
WHERE VacationHours IS NULL OR SickLeaveHours IS NULL

-- CHECKING FOR NULLS IN THE CurrentFlag 
SELECT
CurrentFlag
FROM bronze.brz_employee
WHERE CurrentFlag IS NULL

-- STANDARIZING THE CurrentFlag
SELECT 
CASE 
	WHEN CurrentFlag = 1 THEN 'Currently Active'
	WHEN CurrentFlag = 0 THEN 'Resigned / Fired'
	ELSE 'N/A'
END AS CurrentFlag
FROM bronze.brz_employee