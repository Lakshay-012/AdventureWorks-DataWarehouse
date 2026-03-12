-- DATA CLEANING OF bronze.brz_product
SELECT * FROM bronze.brz_product;

-- CHECKING FOR DUPLICATES IN PRIMARY KEY
SELECT ProductID, COUNT(*)
FROM bronze.brz_product
GROUP BY ProductID
HAVING COUNT(*) > 1;

-- CHECKING FOR NULLS IN PRIMARY KEY
SELECT ProductID
FROM bronze.brz_product
WHERE ProductID IS NULL;

-- CHECKING FOR NULLS AND WHITESPACES IN Name
SELECT Name
FROM bronze.brz_product
WHERE Name IS NULL OR Name != TRIM(Name);

-- CHECKING FOR NULLS AND WHITESPACES IN ProductNumber
SELECT ProductNumber
FROM bronze.brz_product
WHERE ProductNumber IS NULL OR ProductNumber != TRIM(ProductNumber);

-- STANDARDIZING MakeFlag
SELECT
CASE
    WHEN MakeFlag = 1 THEN 'Manufactured In-House'
    WHEN MakeFlag = 0 THEN 'Purchased'
    ELSE 'N/A'
END AS MakeFlag
FROM bronze.brz_product;

-- STANDARDIZING FinishedGoodsFlag
SELECT
CASE
    WHEN FinishedGoodsFlag = 1 THEN 'Finished Product'
    WHEN FinishedGoodsFlag = 0 THEN 'Not For Sale'
    ELSE 'N/A'
END AS FinishedGoodsFlag
FROM bronze.brz_product;

-- HANDLING NULLS IN Color
SELECT
ISNULL(Color, 'N/A') AS Color
FROM bronze.brz_product;

-- CHECKING FOR NEGATIVE VALUES
SELECT COUNT(*) AS NegativeCount
FROM bronze.brz_product
WHERE SafetyStockLevel < 0
OR ReorderPoint < 0
OR StandardCost < 0
OR ListPrice < 0
OR DaysToManufacture < 0;

-- HANDLING NULLS IN Size
SELECT
ISNULL(Size, 'N/A') AS Size
FROM bronze.brz_product;

-- CHECKING FOR NEGATIVE Weight
SELECT COUNT(*) AS NegativeCount
FROM bronze.brz_product
WHERE Weight < 0;

-- STANDARDIZING ProductLine
SELECT
CASE
    WHEN ProductLine = 'R' THEN 'Road'
    WHEN ProductLine = 'M' THEN 'Mountain'
    WHEN ProductLine = 'T' THEN 'Touring'
    WHEN ProductLine = 'S' THEN 'Standard'
    ELSE 'N/A'
END AS ProductLine
FROM bronze.brz_product;

-- STANDARDIZING Class
SELECT
CASE
    WHEN Class = 'H' THEN 'High'
    WHEN Class = 'M' THEN 'Medium'
    WHEN Class = 'L' THEN 'Low'
    ELSE 'N/A'
END AS Class
FROM bronze.brz_product;

-- STANDARDIZING Style
SELECT
CASE
    WHEN Style = 'W' THEN 'Womens'
    WHEN Style = 'M' THEN 'Mens'
    WHEN Style = 'U' THEN 'Universal'
    ELSE 'N/A'
END AS Style
FROM bronze.brz_product;

-- CHECKING FK ProductSubcategoryID
SELECT ProductSubcategoryID
FROM bronze.brz_product
WHERE ProductSubcategoryID NOT IN (
    SELECT ProductSubcategoryID
    FROM bronze.brz_product_subcategory
)
AND ProductSubcategoryID IS NOT NULL;

-- CHECKING FOR INCONSISTENT DATES
SELECT *
FROM bronze.brz_product
WHERE SellStartDate > SellEndDate;