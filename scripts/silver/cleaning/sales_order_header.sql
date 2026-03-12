-- DATA CLEANING FILE FOR THE FIRST TABLE bronze.brz_sales_order_header
SELECT
*
FROM bronze.brz_sales_order_header;



-- CHECKING FOR NULL OR DUPLICATE PRIMARY KEY.

SELECT
SalesOrderID,
COUNT(*) AS GRP
FROM bronze.brz_sales_order_header
GROUP BY SalesOrderID
HAVING COUNT(*)>1 OR COUNT(*) IS NULL;


-- CHECKING FOR INCONSISTENT DATES
SELECT
*
FROM
bronze.brz_sales_order_header
WHERE OrderDate > DueDate OR OrderDate > ShipDate;

-- STANDARDIZING THE STATUS COLUMN
SELECT
CASE 
	WHEN STATUS = 1 THEN 'In Process'
	WHEN STATUS = 2 THEN 'Approved'
	WHEN STATUS = 3 THEN 'Backordered'
	WHEN STATUS = 4 THEN 'Rejected'
	WHEN STATUS = 5 THEN 'Shipped'
	WHEN STATUS = 6 THEN 'Cancelled'
END AS Status
FROM bronze.brz_sales_order_header;


-- STANDARDIZING THE OnlineOrderFlag COLUMN

SELECT
CASE 
	WHEN OnlineOrderFlag = 1 THEN 'Online order'
	WHEN OnlineOrderFlag = 0 THEN 'Sales rep order'
END AS OnlineOrderFlag
FROM bronze.brz_sales_order_header;

--  CHECKING FOR WHITE SPACES
SELECT
SalesOrderNumber 
FROM bronze.brz_sales_order_header
WHERE TRIM(SalesOrderNumber) != SalesOrderNumber

-- CHECKING FOR THE FORMAT
SELECT
SalesOrderNumber 
FROM bronze.brz_sales_order_header
WHERE SalesOrderNumber NOT LIKE 'SO%'

-- CHECKING FOR NULLS
SELECT
SalesOrderNumber 
FROM bronze.brz_sales_order_header
WHERE SalesOrderNumber IS NULL;


-- CHECKING FOR THE DUPLICATES 
SELECT
SalesOrderNumber,
COUNT(*)
FROM bronze.brz_sales_order_header
GROUP BY SalesOrderNumber
HAVING COUNT(*) > 1;


-- CHECKING FOR NULLS

SELECT
CustomerID
FROM 
bronze.brz_sales_order_header
WHERE CustomerID IS NULL

-- CHECKING FOR CustomerID THAT ARE NOT PRESENT IN THE Customer TABLE
SELECT
CustomerID
FROM bronze.brz_sales_order_header
WHERE CustomerID NOT IN (SELECT CustomerID FROM bronze.brz_customer)

-- CHECKING FOR NULLS 

SELECT
SalesPersonID
FROM 
bronze.brz_sales_order_header
WHERE SalesPersonID IS NULL

-- CHECKING FOR SalesPersonID THAT ARE NOT PRESENT IN THE SalesPerson TABLE
SELECT
SalesPersonID
FROM bronze.brz_sales_order_header
WHERE SalesPersonID NOT IN (SELECT BusinessEntityID FROM bronze.brz_employee)

-- CHECKING FOR NULLS AND THE LENGTH OF THE TerritoryID
SELECT
TerritoryID
FROM bronze.brz_sales_order_header
WHERE TerritoryID IS NULL

-- CHECKING FOR TerritoryID THAT IS NOT PRESENT IN THE bronze.brz_state_province
SELECT
TerritoryID
FROM bronze.brz_sales_order_header
WHERE TerritoryID NOT IN (SELECT TerritoryID FROM bronze.brz_state_province)


-- CHECKING FOR NULL AND BillToAddressID NOT PRESENT IN bronze.brz_address
SELECT
BillToAddressID
FROM bronze.brz_sales_order_header 
WHERE BillToAddressID NOT IN (SELECT AddressID FROM bronze.brz_address) OR BillToAddressID IS NULL

-- CHECKING FOR NULL AND ShipToAddressID NOT PRESENT IN bronze.brz_address
SELECT
ShipToAddressID
FROM bronze.brz_sales_order_header 
WHERE ShipToAddressID NOT IN (SELECT AddressID FROM bronze.brz_address) OR ShipToAddressID IS NULL

-- CHECKING FOR NULL AND ShipMethodID NOT PRESENT IN bronze.brz_ship_method
SELECT
ShipMethodID
FROM bronze.brz_sales_order_header 
WHERE ShipMethodID NOT IN (SELECT ShipMethodID FROM bronze.brz_ship_method) AND ShipMethodID IS NULL

-- STANDARIZING THE NAMES IN ShipMethodID COLUMN
SELECT
CASE 
	WHEN ShipMethodID = 1 THEN 'XRQ - TRUCK GROUND'
	WHEN ShipMethodID = 2 THEN 'ZY - EXPRESS'
	WHEN ShipMethodID = 3 THEN 'OVERSEAS - DELUXE'
	WHEN ShipMethodID = 4 THEN 'OVERNIGHT J-FAST'
	WHEN ShipMethodID = 5 THEN 'CARGO TRANSPORT 5'
END AS ShipMethodID
FROM bronze.brz_sales_order_header

-- CHECKING FOR NULLS AND IF THE CurrencyRateID IS NOT PRESENT IN THE bronze.brz_currency_rate
SELECT 
CurrencyRateID
FROM 
bronze.brz_sales_order_header
WHERE CurrencyRateID NOT IN (SELECT CurrencyRateID FROM bronze.brz_currency_rate)



-- CHECKING FOR NULLS IN THE 4 BILLING COLUMNS
SELECT
*
FROM 
bronze.brz_sales_order_header
WHERE SubTotal IS NULL OR TaxAmt IS NULL OR Freight IS NULL OR TotalDue IS NULL;

-- CHECKING FOR -VE VALUES IN ALL THESE COLUMNS
SELECT
*
FROM 
bronze.brz_sales_order_header
WHERE SubTotal < 0 OR TaxAmt < 0 OR Freight < 0 OR TotalDue < 0 ;

-- VALIDATING THE TOTAL CALCULATION TotalDue = SubTotal + TaxAmt + Freight
SELECT
*
FROM
bronze.brz_sales_order_header
WHERE TotalDue != SubTotal+TaxAmt+Freight


-- REPLACING THE NULL COMMENTS WITH 'N/A'
SELECT
ISNULL(Comment,'N/A') AS Comment
FROM bronze.brz_sales_order_header;
