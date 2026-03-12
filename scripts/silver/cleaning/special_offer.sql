-- DATA CLEANING OF bronze.brz_special_offer
SELECT * FROM bronze.brz_special_offer;

-- CHECKING FOR DUPLICATES IN PRIMARY KEY
SELECT SpecialOfferID, COUNT(*)
FROM bronze.brz_special_offer
GROUP BY SpecialOfferID
HAVING COUNT(*) > 1;

-- CHECKING FOR NULLS IN PRIMARY KEY
SELECT SpecialOfferID
FROM bronze.brz_special_offer
WHERE SpecialOfferID IS NULL;

-- CHECKING FOR NULLS AND WHITESPACES IN Description
SELECT Description
FROM bronze.brz_special_offer
WHERE Description IS NULL OR Description != TRIM(Description);

-- CHECKING FOR NEGATIVE DiscountPct
SELECT COUNT(*) AS NegativeCount
FROM bronze.brz_special_offer
WHERE DiscountPct < 0;

-- CHECKING FOR INCONSISTENT DATES
SELECT *
FROM bronze.brz_special_offer
WHERE StartDate > EndDate;

-- CHECKING FOR NEGATIVE MinQty
SELECT COUNT(*) AS NegativeCount
FROM bronze.brz_special_offer
WHERE MinQty < 0;

-- HANDLING NULLS IN MaxQty
SELECT
ISNULL(MaxQty, 0) AS MaxQty
FROM bronze.brz_special_offer;