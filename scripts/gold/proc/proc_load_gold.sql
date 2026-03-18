-- ============================================================
-- FILE    : scripts/gold/proc/proc_load_gold.sql
-- PURPOSE : Load all gold dimension and fact tables
-- HOW     : TRUNCATE each table then INSERT cleaned data
-- RUN     : EXEC gold.proc_load_gold
-- NOTE    : Run proc_load_dim_date separately (once only)
-- ============================================================

USE AdventureWorksDW;
GO

CREATE OR ALTER PROCEDURE gold.proc_load_gold
AS
BEGIN
    DECLARE @layer_start    DATETIME;
    DECLARE @layer_end      DATETIME;
    DECLARE @table_start    DATETIME;
    DECLARE @table_end      DATETIME;

    SET @layer_start = GETDATE();

    PRINT '========================================';
    PRINT 'Loading Gold Layer';
    PRINT '========================================';

    -- ─────────────────────────────────────────
    -- 1. Dim_Territory
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : gold.Dim_Territory';
    TRUNCATE TABLE gold.Dim_Territory;
    PRINT '<< INSERTING DATA INTO : gold.Dim_Territory';
    SET @table_start = GETDATE();
    INSERT INTO gold.Dim_Territory (
        Territory_SK,
        TerritoryID,
        TerritoryName,
        TerritoryGroup,
        CountryCode,
        CountryName
    )
    SELECT
        ROW_NUMBER() OVER (ORDER BY t.TerritoryID) AS Territory_SK,
        t.TerritoryID,
        t.Name                  AS TerritoryName,
        t.TerritoryGroup,
        t.CountryRegionCode     AS CountryCode,
        c.Name                  AS CountryName
    FROM silver.slv_sales_territory t
    JOIN silver.slv_country_region c
        ON t.CountryRegionCode = c.CountryRegionCode;
    SET @table_end = GETDATE();
    PRINT 'Done: Dim_Territory | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 2. Dim_Product
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : gold.Dim_Product';
    TRUNCATE TABLE gold.Dim_Product;
    PRINT '<< INSERTING DATA INTO : gold.Dim_Product';
    SET @table_start = GETDATE();
    INSERT INTO gold.Dim_Product (
        Product_SK,
        ProductID,
        ProductNumber,
        ProductName,
        ProductLine,
        Class,
        Color,
        Size,
        ListPrice,
        StandardCost,
        SubcategoryName,
        CategoryName
    )
    SELECT
        ROW_NUMBER() OVER (ORDER BY p.ProductID) AS Product_SK,
        p.ProductID,
        p.ProductNumber,
        p.Name                  AS ProductName,
        p.ProductLine,
        p.Class,
        p.Color,
        p.Size,
        p.ListPrice,
        p.StandardCost,
        ISNULL(ps.Name, 'N/A')  AS SubcategoryName,
        ISNULL(pc.Name, 'N/A')  AS CategoryName
    FROM silver.slv_product p
    LEFT JOIN silver.slv_product_subcategory ps
        ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    LEFT JOIN silver.slv_product_category pc
        ON ps.ProductCategoryID = pc.ProductCategoryID;
    SET @table_end = GETDATE();
    PRINT 'Done: Dim_Product | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 3. Dim_Employee
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : gold.Dim_Employee';
    TRUNCATE TABLE gold.Dim_Employee;
    PRINT '<< INSERTING DATA INTO : gold.Dim_Employee';
    SET @table_start = GETDATE();
    INSERT INTO gold.Dim_Employee (
        Employee_SK,
        EmployeeID,
        FirstName,
        LastName,
        FullName,
        JobTitle,
        Department,
        DepartmentGroup,
        MaritalStatus,
        Gender,
        HireDate,
        BirthDate,
        SalariedFlag,
        CurrentFlag,
        VacationHours,
        SickLeaveHours
    )
    SELECT
        ROW_NUMBER() OVER (ORDER BY e.BusinessEntityID) AS Employee_SK,
        e.BusinessEntityID          AS EmployeeID,
        p.FirstName,
        p.LastName,
        p.FirstName + ' ' + p.LastName  AS FullName,
        e.JobTitle,
        d.Name                      AS Department,
        d.GroupName                 AS DepartmentGroup,
        e.MaritalStatus,
        e.Gender,
        e.HireDate,
        e.BirthDate,
        e.SalariedFlag,
        e.CurrentFlag,
        e.VacationHours,
        e.SickLeaveHours
    FROM silver.slv_employee e
    JOIN silver.slv_person p
        ON e.BusinessEntityID = p.BusinessEntityID
    JOIN silver.slv_emp_department_history h
        ON e.BusinessEntityID = h.BusinessEntityID
        AND h.EndDate IS NULL
    JOIN silver.slv_department d
        ON h.DepartmentID = d.DepartmentID;
    SET @table_end = GETDATE();
    PRINT 'Done: Dim_Employee | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 4. Dim_Vendor
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : gold.Dim_Vendor';
    TRUNCATE TABLE gold.Dim_Vendor;
    PRINT '<< INSERTING DATA INTO : gold.Dim_Vendor';
    SET @table_start = GETDATE();
    INSERT INTO gold.Dim_Vendor (
        Vendor_SK,
        VendorID,
        VendorName,
        AccountNumber,
        CreditRating,
        PreferredVendorStatus,
        ActiveFlag
    )
    SELECT
        ROW_NUMBER() OVER (ORDER BY BusinessEntityID) AS Vendor_SK,
        BusinessEntityID        AS VendorID,
        Name                    AS VendorName,
        AccountNumber,
        CreditRating,
        PreferredVendorStatus,
        ActiveFlag
    FROM silver.slv_vendor;
    SET @table_end = GETDATE();
    PRINT 'Done: Dim_Vendor | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 5. Dim_Customer
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : gold.Dim_Customer';
    TRUNCATE TABLE gold.Dim_Customer;
    PRINT '<< INSERTING DATA INTO : gold.Dim_Customer';
    SET @table_start = GETDATE();
    INSERT INTO gold.Dim_Customer (
        Customer_SK,
        CustomerID,
        FirstName,
        LastName,
        FullName,
        TerritoryName,
        TerritoryGroup,
        CountryCode,
        CountryName
    )
    SELECT
        ROW_NUMBER() OVER (ORDER BY c.CustomerID) AS Customer_SK,
        c.CustomerID,
        ISNULL(p.FirstName, 'N/A')                    AS FirstName,
        ISNULL(p.LastName, 'N/A')                     AS LastName,
        ISNULL(p.FirstName + ' ' + p.LastName, 'N/A') AS FullName,
        ISNULL(t.Name, 'N/A')                         AS TerritoryName,
        ISNULL(t.TerritoryGroup, 'N/A')               AS TerritoryGroup,
        ISNULL(t.CountryRegionCode, 'N/A')            AS CountryCode,
        ISNULL(cr.Name, 'N/A')                        AS CountryName
    FROM silver.slv_customer c
    LEFT JOIN silver.slv_person p
        ON c.PersonID = p.BusinessEntityID
    LEFT JOIN silver.slv_sales_territory t
        ON c.TerritoryID = t.TerritoryID
    LEFT JOIN silver.slv_country_region cr
        ON t.CountryRegionCode = cr.CountryRegionCode;
    SET @table_end = GETDATE();
    PRINT 'Done: Dim_Customer | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 6. Fact_Sales
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : gold.Fact_Sales';
    TRUNCATE TABLE gold.Fact_Sales;
    PRINT '<< INSERTING DATA INTO : gold.Fact_Sales';
    SET @table_start = GETDATE();
    INSERT INTO gold.Fact_Sales (
        Sales_SK,
        SalesOrderID,
        SalesOrderDetailID,
        Customer_SK,
        Product_SK,
        Employee_SK,
        Territory_SK,
        OrderDate,
        DueDate,
        ShipDate,
        OrderQty,
        UnitPrice,
        UnitPriceDiscount,
        LineTotal,
        TaxAmt,
        Freight,
        TotalDue
    )
    SELECT
        ROW_NUMBER() OVER (ORDER BY h.SalesOrderID, d.SalesOrderDetailID) AS Sales_SK,
        h.SalesOrderID,
        d.SalesOrderDetailID,
        c.Customer_SK,
        p.Product_SK,
        e.Employee_SK,
        t.Territory_SK,
        h.OrderDate,
        h.DueDate,
        h.ShipDate,
        d.OrderQty,
        d.UnitPrice,
        d.UnitPriceDiscount,
        d.LineTotal,
        h.TaxAmt,
        h.Freight,
        h.TotalDue
    FROM silver.slv_sales_order_header h
    JOIN silver.slv_sales_order_detail d
        ON h.SalesOrderID = d.SalesOrderID
    LEFT JOIN gold.Dim_Customer c
        ON h.CustomerID = c.CustomerID
    LEFT JOIN gold.Dim_Product p
        ON d.ProductID = p.ProductID
    LEFT JOIN gold.Dim_Employee e
        ON h.SalesPersonID = e.EmployeeID
    LEFT JOIN gold.Dim_Territory t
        ON h.TerritoryID = t.TerritoryID;
    SET @table_end = GETDATE();
    PRINT 'Done: Fact_Sales | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 7. Fact_Purchases
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : gold.Fact_Purchases';
    TRUNCATE TABLE gold.Fact_Purchases;
    PRINT '<< INSERTING DATA INTO : gold.Fact_Purchases';
    SET @table_start = GETDATE();
    INSERT INTO gold.Fact_Purchases (
        Purchase_SK,
        PurchaseOrderID,
        PurchaseOrderDetailID,
        Employee_SK,
        Vendor_SK,
        Product_SK,
        OrderDate,
        ShipDate,
        DueDate,
        OrderQty,
        UnitPrice,
        LineTotal,
        ReceivedQty,
        RejectedQty,
        StockedQty,
        TaxAmt,
        Freight,
        TotalDue
    )
    SELECT
        ROW_NUMBER() OVER (ORDER BY h.PurchaseOrderID, d.PurchaseOrderDetailID) AS Purchase_SK,
        h.PurchaseOrderID,
        d.PurchaseOrderDetailID,
        e.Employee_SK,
        v.Vendor_SK,
        p.Product_SK,
        h.OrderDate,
        h.ShipDate,
        d.DueDate,
        d.OrderQty,
        d.UnitPrice,
        d.LineTotal,
        d.ReceivedQty,
        d.RejectedQty,
        d.StockedQty,
        h.TaxAmt,
        h.Freight,
        h.TotalDue
    FROM silver.slv_purchase_order_header h
    JOIN silver.slv_purchase_order_detail d
        ON h.PurchaseOrderID = d.PurchaseOrderID
    LEFT JOIN gold.Dim_Employee e
        ON h.EmployeeID = e.EmployeeID
    LEFT JOIN gold.Dim_Vendor v
        ON h.VendorID = v.VendorID
    LEFT JOIN gold.Dim_Product p
        ON d.ProductID = p.ProductID;
    SET @table_end = GETDATE();
    PRINT 'Done: Fact_Purchases | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- DONE
    -- ─────────────────────────────────────────
    SET @layer_end = GETDATE();
    PRINT '========================================';
    PRINT 'Gold Layer Load Complete!';
    PRINT 'Total Time: ' + CAST(DATEDIFF(SECOND, @layer_start, @layer_end) AS NVARCHAR) + ' seconds';
    PRINT '========================================';
END
GO


