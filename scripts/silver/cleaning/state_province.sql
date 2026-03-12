-- DATA CLEANING OF bronze.brz_state_province
SELECT * FROM bronze.brz_state_province;

-- CHECKING FOR DUPLICATES IN PRIMARY KEY
SELECT StateProvinceID, COUNT(*)
FROM bronze.brz_state_province
GROUP BY StateProvinceID
HAVING COUNT(*) > 1;

-- CHECKING FOR NULLS IN PRIMARY KEY
SELECT StateProvinceID
FROM bronze.brz_state_province
WHERE StateProvinceID IS NULL;

-- CHECKING FOR WHITESPACES IN StateProvinceCode
SELECT StateProvinceCode
FROM bronze.brz_state_province
WHERE StateProvinceCode != TRIM(StateProvinceCode);

-- CHECKING FK CountryRegionCode
SELECT CountryRegionCode
FROM bronze.brz_state_province
WHERE CountryRegionCode NOT IN (
    SELECT CountryRegionCode FROM bronze.brz_country_region
)
AND CountryRegionCode IS NOT NULL;

-- CHECKING FOR WHITESPACES IN Name
SELECT Name
FROM bronze.brz_state_province
WHERE Name != TRIM(Name);

-- CHECKING FK TerritoryID
SELECT TerritoryID
FROM bronze.brz_state_province
WHERE TerritoryID NOT IN (
    SELECT TerritoryID FROM bronze.brz_sales_territory
)
AND TerritoryID IS NOT NULL;