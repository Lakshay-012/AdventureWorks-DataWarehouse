-- DATA CLEANING OF bronze.brz_product_category
SELECT * FROM bronze.brz_product_category;

-- CHECKING FOR DUPLICATES IN PRIMARY KEY
SELECT ProductCategoryID, COUNT(*)
FROM bronze.brz_product_category
GROUP BY ProductCategoryID
HAVING COUNT(*) > 1;

-- CHECKING FOR NULLS IN PRIMARY KEY
SELECT ProductCategoryID
FROM bronze.brz_product_category
WHERE ProductCategoryID IS NULL;

-- CHECKING FOR NULLS AND WHITESPACES IN Name
SELECT Name
FROM bronze.brz_product_category
WHERE Name IS NULL OR Name != TRIM(Name);