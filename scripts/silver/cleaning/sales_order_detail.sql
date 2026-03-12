SELECT * FROM bronze.brz_sales_order_detail;
-- DATA CLEANING FILE FOR THE bronze.brz_sales_order_detail

-- CHECKING IF THE SalesOrderID NOT PRESENT IN bronze.brz_sales_order_header
SELECT
SalesOrderID
FROM 
bronze.brz_sales_order_detail
WHERE SalesOrderID NOT IN (SELECT SalesOrderID FROM bronze.brz_sales_order_header);


-- CHECKING FOR NULLS
SELECT
*
FROM 
bronze.brz_sales_order_detail
WHERE SalesOrderID IS NULL;


-- CHECKING FOR DUPLICATES IN THE PRIMARY KEY SalesOrderDetailID
SELECT
SalesOrderDetailID,
COUNT(*)
FROM bronze.brz_sales_order_detail
GROUP BY SalesOrderDetailID
HAVING COUNT(*) > 1;

-- CHECKING FOR NULLS IN THE PRIMARY KEY SalesOrderDetailID
SELECT
SalesOrderDetailID
FROM bronze.brz_sales_order_detail
WHERE SalesOrderDetailID IS NULL;

-- CHECKING FOR WHITE SPACES AND NULLS IN CarrierTrackingNumber
SELECT
CarrierTrackingNumber
FROM bronze.brz_sales_order_detail
WHERE CarrierTrackingNumber IS NULL OR TRIM(CarrierTrackingNumber) != CarrierTrackingNumber;

-- CHECKING FOR INVALID VALUES IN THE OrderQty COLUMN
SELECT
OrderQty
FROM
bronze.brz_sales_order_detail
WHERE OrderQty <= 0;

-- CHECKING IF THE ProductID IS NULL
SELECT
ProductID
FROM 
bronze.brz_sales_order_detail
WHERE ProductID IS NULL;

-- CHECKING IF ID IS NOT PRESENT IN THE bronze.brz_special_offer
SELECT
SpecialOfferID
FROM bronze.brz_sales_order_detail
WHERE SpecialOfferID NOT IN (SELECT SpecialOfferID FROM bronze.brz_special_offer)



-- CHECKING FOR NULLS IN THE SpecialOfferID 
SELECT
SpecialOfferID
FROM bronze.brz_sales_order_detail
WHERE SpecialOfferID IS NULL

-- CHECKING FOR INVALID VALUES IN THE UnitPrice COLUMN
SELECT
UnitPrice
FROM
bronze.brz_sales_order_detail
WHERE UnitPrice IS NULL OR UnitPrice <=0;

-- CHECKING FOR NULLS IN UnitPriceDiscount
SELECT
UnitPriceDiscount
FROM bronze.brz_sales_order_detail
WHERE UnitPriceDiscount IS NULL;

-- CHECKING FOR INVALID VALUES IN UnitPriceDsicount
SELECT DISTINCT
CASE
	WHEN UnitPriceDiscount < 0 THEN 'ERROR'
	WHEN UnitPriceDiscount > 1 THEN 'ERROR'
	ELSE 'ALL GOOD'
END AS UnitPriceDiscount
FROM bronze.brz_sales_order_detail;


-- CHECKING FOR NULLS AND -VE VALUES IN THE LineTotal COLUMN
SELECT
LineTotal
FROM bronze.brz_sales_order_detail
WHERE LineTotal <=0 OR LineTotal IS NULL;

-- CHECKING FOR THE FORMULA VALIDATION IN THE LineTotal COLUMN
SELECT
LineTotal,
ROUND(OrderQty * UnitPrice * (1 - UnitPriceDiscount), 2) AS CalculatedTotal,
ROUND(LineTotal, 2) - ROUND(OrderQty * UnitPrice * (1 - UnitPriceDiscount), 2) AS Difference
FROM bronze.brz_sales_order_detail
WHERE ROUND(LineTotal, 4) != ROUND(OrderQty * UnitPrice * (1 - UnitPriceDiscount), 4);

