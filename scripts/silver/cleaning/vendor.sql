-- DATA CLEANING OF bronze.brz_vendor
SELECT * FROM bronze.brz_vendor;

-- CHECKING FOR DUPLICATES IN PRIMARY KEY
SELECT BusinessEntityID, COUNT(*)
FROM bronze.brz_vendor
GROUP BY BusinessEntityID
HAVING COUNT(*) > 1;

-- CHECKING FOR NULLS IN PRIMARY KEY
SELECT BusinessEntityID
FROM bronze.brz_vendor
WHERE BusinessEntityID IS NULL;

-- CHECKING FOR NULLS AND WHITESPACES IN AccountNumber
SELECT AccountNumber
FROM bronze.brz_vendor
WHERE AccountNumber IS NULL
OR AccountNumber != TRIM(AccountNumber);

-- CHECKING FOR NULLS AND WHITESPACES IN Name
SELECT Name
FROM bronze.brz_vendor
WHERE Name IS NULL OR Name != TRIM(Name);

-- CHECKING DISTINCT CreditRating VALUES
SELECT DISTINCT CreditRating
FROM bronze.brz_vendor;

-- STANDARDIZING CreditRating
SELECT
CASE
    WHEN CreditRating = 1 THEN 'Superior'
    WHEN CreditRating = 2 THEN 'Excellent'
    WHEN CreditRating = 3 THEN 'Above Average'
    WHEN CreditRating = 4 THEN 'Average'
    WHEN CreditRating = 5 THEN 'Below Average'
    ELSE 'N/A'
END AS CreditRating
FROM bronze.brz_vendor;

-- STANDARDIZING PreferredVendorStatus
SELECT
CASE
    WHEN PreferredVendorStatus = 1 THEN 'Preferred Vendor'
    WHEN PreferredVendorStatus = 0 THEN 'Not Preferred'
    ELSE 'N/A'
END AS PreferredVendorStatus
FROM bronze.brz_vendor;

-- STANDARDIZING ActiveFlag
SELECT
CASE
    WHEN ActiveFlag = 1 THEN 'Active'
    WHEN ActiveFlag = 0 THEN 'Inactive'
    ELSE 'N/A'
END AS ActiveFlag
FROM bronze.brz_vendor;

-- HANDLING NULLS IN PurchasingWebServiceURL
SELECT
ISNULL(PurchasingWebServiceURL, 'N/A') AS PurchasingWebServiceURL
FROM bronze.brz_vendor;