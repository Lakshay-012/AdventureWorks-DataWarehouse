-- DATA CLEANING OF bronze.brz_ship_method
SELECT * FROM bronze.brz_ship_method;

-- CHECKING FOR DUPLICATES IN PRIMARY KEY
SELECT ShipMethodID, COUNT(*)
FROM bronze.brz_ship_method
GROUP BY ShipMethodID
HAVING COUNT(*) > 1;

-- CHECKING FOR NULLS IN PRIMARY KEY
SELECT ShipMethodID
FROM bronze.brz_ship_method
WHERE ShipMethodID IS NULL;

-- CHECKING FOR NULLS AND WHITESPACES IN Name
SELECT Name
FROM bronze.brz_ship_method
WHERE Name IS NULL OR Name != TRIM(Name);

-- CHECKING FOR NEGATIVE VALUES
SELECT COUNT(*) AS NegativeCount
FROM bronze.brz_ship_method
WHERE ShipBase < 0 OR ShipRate < 0;