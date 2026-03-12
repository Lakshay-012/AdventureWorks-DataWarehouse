-- DATA CLEANING OF bronze.brz_purchase_order_detail
SELECT * FROM bronze.brz_purchase_order_detail;

-- CHECKING FOR DUPLICATES IN PRIMARY KEY
SELECT PurchaseOrderID, PurchaseOrderDetailID, COUNT(*)
FROM bronze.brz_purchase_order_detail
GROUP BY PurchaseOrderID, PurchaseOrderDetailID
HAVING COUNT(*) > 1;

-- CHECKING FOR NULLS IN PRIMARY KEY
SELECT PurchaseOrderID, PurchaseOrderDetailID
FROM bronze.brz_purchase_order_detail
WHERE PurchaseOrderID IS NULL
OR PurchaseOrderDetailID IS NULL;

-- CHECKING FK PurchaseOrderID
SELECT PurchaseOrderID
FROM bronze.brz_purchase_order_detail
WHERE PurchaseOrderID NOT IN (
    SELECT PurchaseOrderID
    FROM bronze.brz_purchase_order_header
)
AND PurchaseOrderID IS NOT NULL;

-- CHECKING FK ProductID
SELECT ProductID
FROM bronze.brz_purchase_order_detail
WHERE ProductID NOT IN (
    SELECT ProductID FROM bronze.brz_product
)
AND ProductID IS NOT NULL;

-- CHECKING FOR NEGATIVE VALUES
SELECT COUNT(*) AS NegativeCount
FROM bronze.brz_purchase_order_detail
WHERE OrderQty < 0 OR UnitPrice < 0
OR LineTotal < 0 OR ReceivedQty < 0
OR RejectedQty < 0 OR StockedQty < 0;

-- VALIDATING LineTotal CALCULATION
SELECT *
FROM bronze.brz_purchase_order_detail
WHERE ROUND(LineTotal, 2) != ROUND(OrderQty * UnitPrice, 2);