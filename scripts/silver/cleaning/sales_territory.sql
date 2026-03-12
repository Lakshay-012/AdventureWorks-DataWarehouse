-- DATA CLEANING OF bronze.brz_sales_territory
SELECT * FROM bronze.brz_sales_territory;

-- CHECKING FOR DUPLICATES IN PRIMARY KEY
SELECT TerritoryID, COUNT(*)
FROM bronze.brz_sales_territory
GROUP BY TerritoryID
HAVING COUNT(*) > 1;

-- CHECKING FOR NULLS IN PRIMARY KEY
SELECT TerritoryID
FROM bronze.brz_sales_territory
WHERE TerritoryID IS NULL;

-- CHECKING FOR NULLS AND WHITESPACES IN Name
SELECT Name
FROM bronze.brz_sales_territory
WHERE Name IS NULL OR Name != TRIM(Name);

-- CHECKING FK CountryRegionCode
SELECT CountryRegionCode
FROM bronze.brz_sales_territory
WHERE CountryRegionCode NOT IN (
    SELECT CountryRegionCode FROM bronze.brz_country_region
)
AND CountryRegionCode IS NOT NULL;

-- CHECKING FOR NEGATIVE VALUES
SELECT COUNT(*) AS NegativeCount
FROM bronze.brz_sales_territory
WHERE SalesYTD < 0 OR SalesLastYear < 0
OR CostYTD < 0 OR CostLastYear < 0;