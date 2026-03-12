-- DATA CLEANING OF bronze.brz_product_subcategory
SELECT * FROM bronze.brz_product_subcategory;

-- CHECKING FOR DUPLICATES IN PRIMARY KEY
SELECT ProductSubcategoryID, COUNT(*)
FROM bronze.brz_product_subcategory
GROUP BY ProductSubcategoryID
HAVING COUNT(*) > 1;

-- CHECKING FOR NULLS IN PRIMARY KEY
SELECT ProductSubcategoryID
FROM bronze.brz_product_subcategory
WHERE ProductSubcategoryID IS NULL;

-- CHECKING FK ProductCategoryID
SELECT ProductCategoryID
FROM bronze.brz_product_subcategory
WHERE ProductCategoryID NOT IN (
    SELECT ProductCategoryID FROM bronze.brz_product_category
)
AND ProductCategoryID IS NOT NULL;

-- CHECKING FOR NULLS AND WHITESPACES IN Name
SELECT Name
FROM bronze.brz_product_subcategory
WHERE Name IS NULL OR Name != TRIM(Name);