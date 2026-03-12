-- DATA CLEANING OF bronze.brz_purchase_order_header
SELECT * FROM bronze.brz_purchase_order_header;

-- CHECKING FOR DUPLICATES IN PRIMARY KEY
SELECT PurchaseOrderID, COUNT(*)
FROM bronze.brz_purchase_order_header
GROUP BY PurchaseOrderID
HAVING COUNT(*) > 1;

-- CHECKING FOR NULLS IN PRIMARY KEY
SELECT PurchaseOrderID
FROM bronze.brz_purchase_order_header
WHERE PurchaseOrderID IS NULL;

-- STANDARDIZING Status
SELECT
CASE
    WHEN Status = 1 THEN 'Pending'
    WHEN Status = 2 THEN 'Approved'
    WHEN Status = 3 THEN 'Rejected'
    WHEN Status = 4 THEN 'Complete'
    ELSE 'N/A'
END AS Status
FROM bronze.brz_purchase_order_header;

-- CHECKING FK EmployeeID
SELECT EmployeeID
FROM bronze.brz_purchase_order_header
WHERE EmployeeID NOT IN (
    SELECT BusinessEntityID FROM bronze.brz_employee
)
AND EmployeeID IS NOT NULL;

-- CHECKING FK VendorID
SELECT VendorID
FROM bronze.brz_purchase_order_header
WHERE VendorID NOT IN (
    SELECT BusinessEntityID FROM bronze.brz_vendor
)
AND VendorID IS NOT NULL;

-- CHECKING FK ShipMethodID
SELECT ShipMethodID
FROM bronze.brz_purchase_order_header
WHERE ShipMethodID NOT IN (
    SELECT ShipMethodID FROM bronze.brz_ship_method
)
AND ShipMethodID IS NOT NULL;

-- CHECKING FOR INCONSISTENT DATES
SELECT *
FROM bronze.brz_purchase_order_header
WHERE OrderDate > ShipDate;

-- CHECKING FOR NEGATIVE VALUES
SELECT COUNT(*) AS NegativeCount
FROM bronze.brz_purchase_order_header
WHERE SubTotal < 0 OR TaxAmt < 0
OR Freight < 0 OR TotalDue < 0;

-- VALIDATING TotalDue CALCULATION
SELECT *
FROM bronze.brz_purchase_order_header
WHERE TotalDue != SubTotal + TaxAmt + Freight;