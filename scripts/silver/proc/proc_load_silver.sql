-- ============================================================
-- FILE    : scripts/silver/proc/proc_load_silver.sql
-- PURPOSE : Load and clean all silver tables from bronze layer
-- HOW     : TRUNCATE each table then INSERT cleaned data
-- RUN     : EXEC silver.proc_load_silver
-- ============================================================

USE AdventureWorksDW;
GO

CREATE OR ALTER PROCEDURE silver.proc_load_silver
AS
BEGIN
    -- ─────────────────────────────────────────
    -- TIME VARIABLES
    -- ─────────────────────────────────────────
    DECLARE @layer_start    DATETIME;
    DECLARE @layer_end      DATETIME;
    DECLARE @table_start    DATETIME;
    DECLARE @table_end      DATETIME;

    SET @layer_start = GETDATE();

    PRINT '========================================';
    PRINT 'Loading Silver Layer';
    PRINT '========================================';

    -- ─────────────────────────────────────────
    -- 1. silver.slv_country_region
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_country_region';
    TRUNCATE TABLE silver.slv_country_region;
    PRINT '<< INSERTING DATA INTO : silver.slv_country_region';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_country_region (
        CountryRegionCode,
        Name
    )
    SELECT
        TRIM(CountryRegionCode),
        TRIM(Name)
    FROM bronze.brz_country_region;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_country_region | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 2. silver.slv_sales_territory
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_sales_territory';
    TRUNCATE TABLE silver.slv_sales_territory;
    PRINT '<< INSERTING DATA INTO : silver.slv_sales_territory';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_sales_territory (
        TerritoryID,
        Name,
        CountryRegionCode,
        TerritoryGroup,
        SalesYTD,
        SalesLastYear,
        CostYTD,
        CostLastYear
    )
    SELECT
        TerritoryID,
        TRIM(Name),
        TRIM(CountryRegionCode),
        TRIM([Group]),
        SalesYTD,
        SalesLastYear,
        CostYTD,
        CostLastYear
    FROM bronze.brz_sales_territory;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_sales_territory | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 3. silver.slv_state_province
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_state_province';
    TRUNCATE TABLE silver.slv_state_province;
    PRINT '<< INSERTING DATA INTO : silver.slv_state_province';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_state_province (
        StateProvinceID,
        StateProvinceCode,
        CountryRegionCode,
        IsOnlyStateProvinceFlag,
        Name,
        TerritoryID
    )
    SELECT
        StateProvinceID,
        TRIM(StateProvinceCode),
        TRIM(CountryRegionCode),
        IsOnlyStateProvinceFlag,
        TRIM(Name),
        TerritoryID
    FROM bronze.brz_state_province;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_state_province | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 4. silver.slv_address
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_address';
    TRUNCATE TABLE silver.slv_address;
    PRINT '<< INSERTING DATA INTO : silver.slv_address';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_address (
        AddressID,
        AddressLine1,
        AddressLine2,
        City,
        StateProvinceID,
        PostalCode
    )
    SELECT
        AddressID,
        TRIM(AddressLine1),
        ISNULL(TRIM(AddressLine2), 'N/A'),
        TRIM(City),
        StateProvinceID,
        TRIM(PostalCode)
    FROM bronze.brz_address;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_address | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 5. silver.slv_currency_rate
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_currency_rate';
    TRUNCATE TABLE silver.slv_currency_rate;
    PRINT '<< INSERTING DATA INTO : silver.slv_currency_rate';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_currency_rate (
        CurrencyRateID,
        CurrencyRateDate,
        FromCurrencyCode,
        ToCurrencyCode,
        AverageRate,
        EndOfDayRate
    )
    SELECT
        CurrencyRateID,
        CurrencyRateDate,
        TRIM(FromCurrencyCode),
        TRIM(ToCurrencyCode),
        AverageRate,
        EndOfDayRate
    FROM bronze.brz_currency_rate;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_currency_rate | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 6. silver.slv_ship_method
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_ship_method';
    TRUNCATE TABLE silver.slv_ship_method;
    PRINT '<< INSERTING DATA INTO : silver.slv_ship_method';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_ship_method (
        ShipMethodID,
        Name,
        ShipBase,
        ShipRate
    )
    SELECT
        ShipMethodID,
        TRIM(Name),
        ShipBase,
        ShipRate
    FROM bronze.brz_ship_method;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_ship_method | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 7. silver.slv_special_offer
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_special_offer';
    TRUNCATE TABLE silver.slv_special_offer;
    PRINT '<< INSERTING DATA INTO : silver.slv_special_offer';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_special_offer (
        SpecialOfferID,
        Description,
        DiscountPct,
        Type,
        Category,
        StartDate,
        EndDate,
        MinQty,
        MaxQty
    )
    SELECT
        SpecialOfferID,
        TRIM(Description),
        DiscountPct,
        TRIM(Type),
        TRIM(Category),
        StartDate,
        EndDate,
        MinQty,
        ISNULL(MaxQty, 0)
    FROM bronze.brz_special_offer;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_special_offer | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 8. silver.slv_product_category
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_product_category';
    TRUNCATE TABLE silver.slv_product_category;
    PRINT '<< INSERTING DATA INTO : silver.slv_product_category';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_product_category (
        ProductCategoryID,
        Name
    )
    SELECT
        ProductCategoryID,
        TRIM(Name)
    FROM bronze.brz_product_category;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_product_category | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 9. silver.slv_product_subcategory
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_product_subcategory';
    TRUNCATE TABLE silver.slv_product_subcategory;
    PRINT '<< INSERTING DATA INTO : silver.slv_product_subcategory';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_product_subcategory (
        ProductSubcategoryID,
        ProductCategoryID,
        Name
    )
    SELECT
        ProductSubcategoryID,
        ProductCategoryID,
        TRIM(Name)
    FROM bronze.brz_product_subcategory;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_product_subcategory | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 10. silver.slv_product
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_product';
    TRUNCATE TABLE silver.slv_product;
    PRINT '<< INSERTING DATA INTO : silver.slv_product';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_product (
        ProductID,
        Name,
        ProductNumber,
        MakeFlag,
        FinishedGoodsFlag,
        Color,
        SafetyStockLevel,
        ReorderPoint,
        StandardCost,
        ListPrice,
        Size,
        SizeUnitMeasureCode,
        WeightUnitMeasureCode,
        Weight,
        DaysToManufacture,
        ProductLine,
        Class,
        Style,
        ProductSubcategoryID,
        ProductModelID,
        SellStartDate,
        SellEndDate,
        DiscontinuedDate
    )
    SELECT
        ProductID,
        TRIM(Name),
        TRIM(ProductNumber),
        CASE MakeFlag
            WHEN 1 THEN 'Manufactured In-House'
            WHEN 0 THEN 'Purchased'
            ELSE 'N/A'
        END,
        CASE FinishedGoodsFlag
            WHEN 1 THEN 'Finished Product'
            WHEN 0 THEN 'Not For Sale'
            ELSE 'N/A'
        END,
        ISNULL(Color, 'N/A'),
        SafetyStockLevel,
        ReorderPoint,
        StandardCost,
        ListPrice,
        ISNULL(Size, 'N/A'),
        SizeUnitMeasureCode,
        WeightUnitMeasureCode,
        Weight,
        DaysToManufacture,
        CASE ProductLine
            WHEN 'R' THEN 'Road'
            WHEN 'M' THEN 'Mountain'
            WHEN 'T' THEN 'Touring'
            WHEN 'S' THEN 'Standard'
            ELSE 'N/A'
        END,
        CASE Class
            WHEN 'H' THEN 'High'
            WHEN 'M' THEN 'Medium'
            WHEN 'L' THEN 'Low'
            ELSE 'N/A'
        END,
        CASE Style
            WHEN 'W' THEN 'Womens'
            WHEN 'M' THEN 'Mens'
            WHEN 'U' THEN 'Universal'
            ELSE 'N/A'
        END,
        ProductSubcategoryID,
        ProductModelID,
        SellStartDate,
        SellEndDate,
        DiscontinuedDate
    FROM bronze.brz_product;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_product | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 11. silver.slv_department
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_department';
    TRUNCATE TABLE silver.slv_department;
    PRINT '<< INSERTING DATA INTO : silver.slv_department';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_department (
        DepartmentID,
        Name,
        GroupName
    )
    SELECT
        DepartmentID,
        TRIM(Name),
        TRIM(GroupName)
    FROM bronze.brz_department;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_department | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 12. silver.slv_employee
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_employee';
    TRUNCATE TABLE silver.slv_employee;
    PRINT '<< INSERTING DATA INTO : silver.slv_employee';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_employee (
        BusinessEntityID,
        NationalIDNumber,
        LoginID,
        JobTitle,
        BirthDate,
        MaritalStatus,
        Gender,
        HireDate,
        SalariedFlag,
        VacationHours,
        SickLeaveHours,
        CurrentFlag
    )
    SELECT
        BusinessEntityID,
        TRIM(NationalIDNumber),
        TRIM(LoginID),
        TRIM(JobTitle),
        BirthDate,
        CASE MaritalStatus
            WHEN 'S' THEN 'Single'
            WHEN 'M' THEN 'Married'
            ELSE 'N/A'
        END,
        CASE Gender
            WHEN 'M' THEN 'Male'
            WHEN 'F' THEN 'Female'
            ELSE 'N/A'
        END,
        HireDate,
        CASE SalariedFlag
            WHEN 1 THEN 'Salaried'
            WHEN 0 THEN 'Hourly'
            ELSE 'N/A'
        END,
        VacationHours,
        SickLeaveHours,
        CASE CurrentFlag
            WHEN 1 THEN 'Currently Active'
            WHEN 0 THEN 'Resigned / Fired'
            ELSE 'N/A'
        END
    FROM bronze.brz_employee;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_employee | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 13. silver.slv_emp_department_history
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_emp_department_history';
    TRUNCATE TABLE silver.slv_emp_department_history;
    PRINT '<< INSERTING DATA INTO : silver.slv_emp_department_history';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_emp_department_history (
        BusinessEntityID,
        DepartmentID,
        ShiftID,
        StartDate,
        EndDate
    )
    SELECT
        BusinessEntityID,
        DepartmentID,
        ShiftID,
        StartDate,
        EndDate     
    FROM bronze.brz_emp_department_history;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_emp_department_history | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 14. silver.slv_person
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_person';
    TRUNCATE TABLE silver.slv_person;
    PRINT '<< INSERTING DATA INTO : silver.slv_person';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_person (
        BusinessEntityID,
        PersonType,
        NameStyle,
        Title,
        FirstName,
        MiddleName,
        LastName,
        Suffix,
        EmailPromotion
    )
    SELECT
        BusinessEntityID,
        CASE PersonType
            WHEN 'EM' THEN 'Employee'
            WHEN 'SP' THEN 'Sales Person'
            WHEN 'SC' THEN 'Store Contact'
            WHEN 'VC' THEN 'Vendor Contact'
            WHEN 'IN' THEN 'Individual Customer'
            WHEN 'GC' THEN 'General Contact'
            ELSE 'N/A'
        END,
        CASE NameStyle
            WHEN 0 THEN 'Western'
            WHEN 1 THEN 'Eastern'
            ELSE 'N/A'
        END,
        ISNULL(Title, 'N/A'),
        TRIM(FirstName),
        ISNULL(TRIM(MiddleName), 'N/A'),
        TRIM(LastName),
        ISNULL(Suffix, 'N/A'),
        CASE EmailPromotion
            WHEN 0 THEN 'No Promotion'
            WHEN 1 THEN 'AdventureWorks Promotions Only'
            WHEN 2 THEN 'All Promotions'
            ELSE 'N/A'
        END
    FROM bronze.brz_person;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_person | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 15. silver.slv_vendor
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_vendor';
    TRUNCATE TABLE silver.slv_vendor;
    PRINT '<< INSERTING DATA INTO : silver.slv_vendor';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_vendor (
        BusinessEntityID,
        AccountNumber,
        Name,
        CreditRating,
        PreferredVendorStatus,
        ActiveFlag,
        PurchasingWebServiceURL
    )
    SELECT
        BusinessEntityID,
        TRIM(AccountNumber),
        TRIM(Name),
        CASE CreditRating
            WHEN 1 THEN 'Superior'
            WHEN 2 THEN 'Excellent'
            WHEN 3 THEN 'Above Average'
            WHEN 4 THEN 'Average'
            WHEN 5 THEN 'Below Average'
            ELSE 'N/A'
        END,
        CASE PreferredVendorStatus
            WHEN 1 THEN 'Preferred Vendor'
            WHEN 0 THEN 'Not Preferred'
            ELSE 'N/A'
        END,
        CASE ActiveFlag
            WHEN 1 THEN 'Active'
            WHEN 0 THEN 'Inactive'
            ELSE 'N/A'
        END,
        ISNULL(PurchasingWebServiceURL, 'N/A')
    FROM bronze.brz_vendor;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_vendor | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 16. silver.slv_customer
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_customer';
    TRUNCATE TABLE silver.slv_customer;
    PRINT '<< INSERTING DATA INTO : silver.slv_customer';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_customer (
        CustomerID,
        PersonID,
        StoreID,
        TerritoryID,
        AccountNumber
    )
    SELECT
        CustomerID,
        PersonID,
        StoreID,
        TerritoryID,
        TRIM(AccountNumber)
    FROM bronze.brz_customer;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_customer | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 17. silver.slv_purchase_order_header
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_purchase_order_header';
    TRUNCATE TABLE silver.slv_purchase_order_header;
    PRINT '<< INSERTING DATA INTO : silver.slv_purchase_order_header';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_purchase_order_header (
        PurchaseOrderID,
        RevisionNumber,
        Status,
        EmployeeID,
        VendorID,
        ShipMethodID,
        OrderDate,
        ShipDate,
        SubTotal,
        TaxAmt,
        Freight,
        TotalDue
    )
    SELECT
        PurchaseOrderID,
        RevisionNumber,
        CASE Status
            WHEN 1 THEN 'Pending'
            WHEN 2 THEN 'Approved'
            WHEN 3 THEN 'Rejected'
            WHEN 4 THEN 'Complete'
            ELSE 'N/A'
        END,
        EmployeeID,
        VendorID,
        ShipMethodID,
        OrderDate,
        ShipDate,
        SubTotal,
        TaxAmt,
        Freight,
        TotalDue
    FROM bronze.brz_purchase_order_header;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_purchase_order_header | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 18. silver.slv_purchase_order_detail
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_purchase_order_detail';
    TRUNCATE TABLE silver.slv_purchase_order_detail;
    PRINT '<< INSERTING DATA INTO : silver.slv_purchase_order_detail';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_purchase_order_detail (
        PurchaseOrderID,
        PurchaseOrderDetailID,
        DueDate,
        OrderQty,
        ProductID,
        UnitPrice,
        LineTotal,
        ReceivedQty,
        RejectedQty,
        StockedQty
    )
    SELECT
        PurchaseOrderID,
        PurchaseOrderDetailID,
        DueDate,
        OrderQty,
        ProductID,
        UnitPrice,
        LineTotal,
        ReceivedQty,
        RejectedQty,
        StockedQty
    FROM bronze.brz_purchase_order_detail;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_purchase_order_detail | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 19. silver.slv_sales_order_header
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_sales_order_header';
    TRUNCATE TABLE silver.slv_sales_order_header;
    PRINT '<< INSERTING DATA INTO : silver.slv_sales_order_header';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_sales_order_header (
        SalesOrderID,
        RevisionNumber,
        OrderDate,
        DueDate,
        ShipDate,
        Status,
        OnlineOrderFlag,
        SalesOrderNumber,
        CustomerID,
        SalesPersonID,
        TerritoryID,
        BillToAddressID,
        ShipToAddressID,
        ShipMethodID,
        CurrencyRateID,
        SubTotal,
        TaxAmt,
        Freight,
        TotalDue,
        Comment
    )
    SELECT
        SalesOrderID,
        RevisionNumber,
        OrderDate,
        DueDate,
        ShipDate,
        CASE Status
            WHEN 1 THEN 'In Process'
            WHEN 2 THEN 'Approved'
            WHEN 3 THEN 'Backordered'
            WHEN 4 THEN 'Rejected'
            WHEN 5 THEN 'Shipped'
            WHEN 6 THEN 'Cancelled'
            ELSE 'N/A'
        END,
        CASE OnlineOrderFlag
            WHEN 1 THEN 'Online Order'
            WHEN 0 THEN 'Sales Rep Order'
            ELSE 'N/A'
        END,
        TRIM(SalesOrderNumber),
        CustomerID,
        SalesPersonID,
        TerritoryID,
        BillToAddressID,
        ShipToAddressID,
        CASE ShipMethodID
            WHEN 1 THEN 'XRQ - TRUCK GROUND'
            WHEN 2 THEN 'ZY - EXPRESS'
            WHEN 3 THEN 'OVERSEAS - DELUXE'
            WHEN 4 THEN 'OVERNIGHT J-FAST'
            WHEN 5 THEN 'CARGO TRANSPORT 5'
            ELSE 'N/A'
        END,
        CurrencyRateID,
        SubTotal,
        TaxAmt,
        Freight,
        TotalDue,
        ISNULL(Comment, 'N/A')
    FROM bronze.brz_sales_order_header;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_sales_order_header | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- 20. silver.slv_sales_order_detail
    -- ─────────────────────────────────────────
    PRINT '<< TRUNCATING TABLE : silver.slv_sales_order_detail';
    TRUNCATE TABLE silver.slv_sales_order_detail;
    PRINT '<< INSERTING DATA INTO : silver.slv_sales_order_detail';
    SET @table_start = GETDATE();
    INSERT INTO silver.slv_sales_order_detail (
        SalesOrderID,
        SalesOrderDetailID,
        CarrierTrackingNumber,
        OrderQty,
        ProductID,
        SpecialOfferID,
        UnitPrice,
        UnitPriceDiscount,
        LineTotal
    )
    SELECT
        SalesOrderID,
        SalesOrderDetailID,
        TRIM(CarrierTrackingNumber),
        OrderQty,
        ProductID,
        SpecialOfferID,
        UnitPrice,
        UnitPriceDiscount,
        LineTotal
    FROM bronze.brz_sales_order_detail;
    SET @table_end = GETDATE();
    PRINT 'Done: slv_sales_order_detail | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- DONE
    -- ─────────────────────────────────────────
    SET @layer_end = GETDATE();
    PRINT '========================================';
    PRINT 'Silver Layer Load Complete!';
    PRINT 'Total Time: ' + CAST(DATEDIFF(SECOND, @layer_start, @layer_end) AS NVARCHAR) + ' seconds';
    PRINT '========================================';
END
GO



EXEC silver.proc_load_silver