-- DATA CLEANING OF bronze.brz_country_region
SELECT * FROM bronze.brz_country_region;

-- CHECKING FOR DUPLICATES IN PRIMARY KEY
SELECT CountryRegionCode, COUNT(*)
FROM bronze.brz_country_region
GROUP BY CountryRegionCode
HAVING COUNT(*) > 1;

-- CHECKING FOR NULLS IN PRIMARY KEY
SELECT CountryRegionCode
FROM bronze.brz_country_region
WHERE CountryRegionCode IS NULL;

-- CHECKING FOR NULLS AND WHITESPACES IN Name
SELECT Name
FROM bronze.brz_country_region
WHERE Name IS NULL OR Name != TRIM(Name);

-- CHECKING FOR WHITESPACES IN CountryRegionCode
SELECT CountryRegionCode
FROM bronze.brz_country_region
WHERE CountryRegionCode != TRIM(CountryRegionCode);