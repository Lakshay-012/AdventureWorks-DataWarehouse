-- DATA CLEANING OF bronze.brz_address
SELECT * FROM bronze.brz_address;

-- CHECKING FOR DUPLICATES IN PRIMARY KEY
SELECT AddressID, COUNT(*)
FROM bronze.brz_address
GROUP BY AddressID
HAVING COUNT(*) > 1;

-- CHECKING FOR NULLS IN PRIMARY KEY
SELECT AddressID
FROM bronze.brz_address
WHERE AddressID IS NULL;

-- CHECKING FOR NULLS AND WHITESPACES IN AddressLine1
SELECT AddressLine1
FROM bronze.brz_address
WHERE AddressLine1 IS NULL
OR AddressLine1 != TRIM(AddressLine1);

-- HANDLING NULLS IN AddressLine2
SELECT
ISNULL(AddressLine2, 'N/A') AS AddressLine2
FROM bronze.brz_address;

-- CHECKING FOR NULLS AND WHITESPACES IN City
SELECT City
FROM bronze.brz_address
WHERE City IS NULL OR City != TRIM(City);

-- CHECKING FK StateProvinceID
SELECT StateProvinceID
FROM bronze.brz_address
WHERE StateProvinceID NOT IN (
    SELECT StateProvinceID FROM bronze.brz_state_province
)
AND StateProvinceID IS NOT NULL;

-- CHECKING FOR NULLS AND WHITESPACES IN PostalCode
SELECT PostalCode
FROM bronze.brz_address
WHERE PostalCode IS NULL
OR PostalCode != TRIM(PostalCode);