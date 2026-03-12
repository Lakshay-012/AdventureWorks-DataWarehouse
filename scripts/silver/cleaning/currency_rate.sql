-- DATA CLEANING OF bronze.brz_currency_rate
SELECT * FROM bronze.brz_currency_rate;

-- CHECKING FOR DUPLICATES IN PRIMARY KEY
SELECT CurrencyRateID, COUNT(*)
FROM bronze.brz_currency_rate
GROUP BY CurrencyRateID
HAVING COUNT(*) > 1;

-- CHECKING FOR NULLS IN PRIMARY KEY
SELECT CurrencyRateID
FROM bronze.brz_currency_rate
WHERE CurrencyRateID IS NULL;

-- CHECKING FOR NULLS IN ALL COLUMNS
SELECT COUNT(*) AS NullCount
FROM bronze.brz_currency_rate
WHERE CurrencyRateDate IS NULL
OR FromCurrencyCode IS NULL
OR ToCurrencyCode IS NULL
OR AverageRate IS NULL
OR EndOfDayRate IS NULL;

-- CHECKING FOR NEGATIVE RATES
SELECT COUNT(*) AS NegativeCount
FROM bronze.brz_currency_rate
WHERE AverageRate < 0 OR EndOfDayRate < 0;

-- CHECKING FOR WHITESPACES IN Currency Codes
SELECT FromCurrencyCode, ToCurrencyCode
FROM bronze.brz_currency_rate
WHERE FromCurrencyCode != TRIM(FromCurrencyCode)
OR ToCurrencyCode != TRIM(ToCurrencyCode);