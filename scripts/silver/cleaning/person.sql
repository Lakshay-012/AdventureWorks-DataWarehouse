-- DATA CLEANING OF bronze.brz_person
SELECT * FROM bronze.brz_person;

-- CHECKING FOR DUPLICATES IN PRIMARY KEY
SELECT BusinessEntityID, COUNT(*)
FROM bronze.brz_person
GROUP BY BusinessEntityID
HAVING COUNT(*) > 1;

-- CHECKING FOR NULLS IN PRIMARY KEY
SELECT BusinessEntityID
FROM bronze.brz_person
WHERE BusinessEntityID IS NULL;

-- STANDARDIZING PersonType
SELECT
CASE
    WHEN PersonType = 'EM' THEN 'Employee'
    WHEN PersonType = 'SP' THEN 'Sales Person'
    WHEN PersonType = 'SC' THEN 'Store Contact'
    WHEN PersonType = 'VC' THEN 'Vendor Contact'
    WHEN PersonType = 'IN' THEN 'Individual Customer'
    WHEN PersonType = 'GC' THEN 'General Contact'
    ELSE 'N/A'
END AS PersonType
FROM bronze.brz_person;

-- CHECKING FOR NULLS AND WHITESPACES IN FirstName
SELECT FirstName
FROM bronze.brz_person
WHERE FirstName IS NULL OR FirstName != TRIM(FirstName);

-- CHECKING FOR NULLS AND WHITESPACES IN LastName
SELECT LastName
FROM bronze.brz_person
WHERE LastName IS NULL OR LastName != TRIM(LastName);

-- HANDLING NULLS IN Title
SELECT
ISNULL(Title, 'N/A') AS Title
FROM bronze.brz_person;

-- HANDLING NULLS IN MiddleName
SELECT
ISNULL(MiddleName, 'N/A') AS MiddleName
FROM bronze.brz_person;

-- HANDLING NULLS IN Suffix
SELECT
ISNULL(Suffix, 'N/A') AS Suffix
FROM bronze.brz_person;

-- STANDARDIZING NameStyle
SELECT
CASE
    WHEN NameStyle = 0 THEN 'Western'
    WHEN NameStyle = 1 THEN 'Eastern'
    ELSE 'N/A'
END AS NameStyle
FROM bronze.brz_person;

-- CHECKING DISTINCT EmailPromotion VALUES
SELECT DISTINCT EmailPromotion
FROM bronze.brz_person;

-- STANDARDIZING EmailPromotion
SELECT
CASE
    WHEN EmailPromotion = 0 THEN 'No Promotion'
    WHEN EmailPromotion = 1 THEN 'Anthropic Promotions Only'
    WHEN EmailPromotion = 2 THEN 'All Promotions'
    ELSE 'N/A'
END AS EmailPromotion
FROM bronze.brz_person;