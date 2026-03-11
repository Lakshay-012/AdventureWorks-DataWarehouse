-- ============================================================
-- FILE    : bronze/proc/proc_load_bronze.sql
-- PURPOSE : Load all bronze tables from AdventureWorks2022
-- HOW     : TRUNCATE each table then INSERT fresh data
-- RUN     : EXEC bronze.proc_load_bronze
-- ============================================================

USE AdventureWorksDW;
GO

CREATE OR ALTER PROCEDURE bronze.proc_load_bronze
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
    PRINT 'Loading Bronze Layer';
    PRINT '========================================';

    -- ─────────────────────────────────────────
    -- SALES
    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_sales_order_header';
    TRUNCATE TABLE bronze.brz_sales_order_header;
    PRINT '<< INSERTING DATA INTO : bronze.brz_sales_order_header';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_sales_order_header (
        SalesOrderID, RevisionNumber, OrderDate, DueDate, ShipDate,
        Status, OnlineOrderFlag, SalesOrderNumber, CustomerID,
        SalesPersonID, TerritoryID, BillToAddressID, ShipToAddressID,
        ShipMethodID, CurrencyRateID, SubTotal, TaxAmt, Freight,
        TotalDue, Comment
    )
    SELECT
        SalesOrderID, RevisionNumber, OrderDate, DueDate, ShipDate,
        Status, OnlineOrderFlag, SalesOrderNumber, CustomerID,
        SalesPersonID, TerritoryID, BillToAddressID, ShipToAddressID,
        ShipMethodID, CurrencyRateID, SubTotal, TaxAmt, Freight,
        TotalDue, Comment
    FROM AdventureWorks2022.Sales.SalesOrderHeader;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_sales_order_header | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_sales_order_detail';
    TRUNCATE TABLE bronze.brz_sales_order_detail;
    PRINT '<< INSERTING DATA INTO : bronze.brz_sales_order_detail';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_sales_order_detail (
        SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber,
        OrderQty, ProductID, SpecialOfferID, UnitPrice,
        UnitPriceDiscount, LineTotal
    )
    SELECT
        SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber,
        OrderQty, ProductID, SpecialOfferID, UnitPrice,
        UnitPriceDiscount, LineTotal
    FROM AdventureWorks2022.Sales.SalesOrderDetail;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_sales_order_detail | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_customer';
    TRUNCATE TABLE bronze.brz_customer;
    PRINT '<< INSERTING DATA INTO : bronze.brz_customer';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_customer (
        CustomerID, PersonID, StoreID, TerritoryID, AccountNumber
    )
    SELECT
        CustomerID, PersonID, StoreID, TerritoryID, AccountNumber
    FROM AdventureWorks2022.Sales.Customer;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_customer | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- PRODUCTION
    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_product';
    TRUNCATE TABLE bronze.brz_product;
    PRINT '<< INSERTING DATA INTO : bronze.brz_product';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_product (
        ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag,
        Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice,
        Size, SizeUnitMeasureCode, WeightUnitMeasureCode, Weight,
        DaysToManufacture, ProductLine, Class, Style,
        ProductSubcategoryID, ProductModelID, SellStartDate,
        SellEndDate, DiscontinuedDate
    )
    SELECT
        ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag,
        Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice,
        Size, SizeUnitMeasureCode, WeightUnitMeasureCode, Weight,
        DaysToManufacture, ProductLine, Class, Style,
        ProductSubcategoryID, ProductModelID, SellStartDate,
        SellEndDate, DiscontinuedDate
    FROM AdventureWorks2022.Production.Product;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_product | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_product_subcategory';
    TRUNCATE TABLE bronze.brz_product_subcategory;
    PRINT '<< INSERTING DATA INTO : bronze.brz_product_subcategory';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_product_subcategory (
        ProductSubcategoryID, ProductCategoryID, Name
    )
    SELECT
        ProductSubcategoryID, ProductCategoryID, Name
    FROM AdventureWorks2022.Production.ProductSubcategory;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_product_subcategory | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_product_category';
    TRUNCATE TABLE bronze.brz_product_category;
    PRINT '<< INSERTING DATA INTO : bronze.brz_product_category';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_product_category (
        ProductCategoryID, Name
    )
    SELECT
        ProductCategoryID, Name
    FROM AdventureWorks2022.Production.ProductCategory;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_product_category | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- HUMAN RESOURCES
    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_employee';
    TRUNCATE TABLE bronze.brz_employee;
    PRINT '<< INSERTING DATA INTO : bronze.brz_employee';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_employee (
        BusinessEntityID, NationalIDNumber, LoginID, JobTitle,
        BirthDate, MaritalStatus, Gender, HireDate, SalariedFlag,
        VacationHours, SickLeaveHours, CurrentFlag
    )
    SELECT
        BusinessEntityID, NationalIDNumber, LoginID, JobTitle,
        BirthDate, MaritalStatus, Gender, HireDate, SalariedFlag,
        VacationHours, SickLeaveHours, CurrentFlag
    FROM AdventureWorks2022.HumanResources.Employee;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_employee | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_department';
    TRUNCATE TABLE bronze.brz_department;
    PRINT '<< INSERTING DATA INTO : bronze.brz_department';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_department (
        DepartmentID, Name, GroupName
    )
    SELECT
        DepartmentID, Name, GroupName
    FROM AdventureWorks2022.HumanResources.Department;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_department | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_emp_department_history';
    TRUNCATE TABLE bronze.brz_emp_department_history;
    PRINT '<< INSERTING DATA INTO : bronze.brz_emp_department_history';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_emp_department_history (
        BusinessEntityID, DepartmentID, ShiftID, StartDate, EndDate
    )
    SELECT
        BusinessEntityID, DepartmentID, ShiftID, StartDate, EndDate
    FROM AdventureWorks2022.HumanResources.EmployeeDepartmentHistory;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_emp_department_history | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- PERSON
    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_person';
    TRUNCATE TABLE bronze.brz_person;
    PRINT '<< INSERTING DATA INTO : bronze.brz_person';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_person (
        BusinessEntityID, PersonType, NameStyle, Title,
        FirstName, MiddleName, LastName, Suffix, EmailPromotion
    )
    SELECT
        BusinessEntityID, PersonType, NameStyle, Title,
        FirstName, MiddleName, LastName, Suffix, EmailPromotion
    FROM AdventureWorks2022.Person.Person;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_person | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_address';
    TRUNCATE TABLE bronze.brz_address;
    PRINT '<< INSERTING DATA INTO : bronze.brz_address';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_address (
        AddressID, AddressLine1, AddressLine2,
        City, StateProvinceID, PostalCode
    )
    SELECT
        AddressID, AddressLine1, AddressLine2,
        City, StateProvinceID, PostalCode
    FROM AdventureWorks2022.Person.Address;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_address | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_state_province';
    TRUNCATE TABLE bronze.brz_state_province;
    PRINT '<< INSERTING DATA INTO : bronze.brz_state_province';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_state_province (
        StateProvinceID, StateProvinceCode, CountryRegionCode,
        IsOnlyStateProvinceFlag, Name, TerritoryID
    )
    SELECT
        StateProvinceID, StateProvinceCode, CountryRegionCode,
        IsOnlyStateProvinceFlag, Name, TerritoryID
    FROM AdventureWorks2022.Person.StateProvince;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_state_province | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────
    -- PURCHASING
    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_vendor';
    TRUNCATE TABLE bronze.brz_vendor;
    PRINT '<< INSERTING DATA INTO : bronze.brz_vendor';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_vendor (
        BusinessEntityID, AccountNumber, Name, CreditRating,
        PreferredVendorStatus, ActiveFlag, PurchasingWebServiceURL
    )
    SELECT
        BusinessEntityID, AccountNumber, Name, CreditRating,
        PreferredVendorStatus, ActiveFlag, PurchasingWebServiceURL
    FROM AdventureWorks2022.Purchasing.Vendor;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_vendor | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_purchase_order_header';
    TRUNCATE TABLE bronze.brz_purchase_order_header;
    PRINT '<< INSERTING DATA INTO : bronze.brz_purchase_order_header';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_purchase_order_header (
        PurchaseOrderID, RevisionNumber, Status, EmployeeID,
        VendorID, ShipMethodID, OrderDate, ShipDate,
        SubTotal, TaxAmt, Freight, TotalDue
    )
    SELECT
        PurchaseOrderID, RevisionNumber, Status, EmployeeID,
        VendorID, ShipMethodID, OrderDate, ShipDate,
        SubTotal, TaxAmt, Freight, TotalDue
    FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_purchase_order_header | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_purchase_order_detail';
    TRUNCATE TABLE bronze.brz_purchase_order_detail;
    PRINT '<< INSERTING DATA INTO : bronze.brz_purchase_order_detail';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_purchase_order_detail (
        PurchaseOrderID, PurchaseOrderDetailID, DueDate,
        OrderQty, ProductID, UnitPrice, LineTotal,
        ReceivedQty, RejectedQty, StockedQty
    )
    SELECT
        PurchaseOrderID, PurchaseOrderDetailID, DueDate,
        OrderQty, ProductID, UnitPrice, LineTotal,
        ReceivedQty, RejectedQty, StockedQty
    FROM AdventureWorks2022.Purchasing.PurchaseOrderDetail;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_purchase_order_detail | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────

    -- ─────────────────────────────────────────
    -- LOOKUP / REFERENCE TABLES
    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_ship_method';
    TRUNCATE TABLE bronze.brz_ship_method;
    PRINT '<< INSERTING DATA INTO : bronze.brz_ship_method';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_ship_method (
        ShipMethodID, Name, ShipBase, ShipRate
    )
    SELECT
        ShipMethodID, Name, ShipBase, ShipRate
    FROM AdventureWorks2022.Purchasing.ShipMethod;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_ship_method | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_special_offer';
    TRUNCATE TABLE bronze.brz_special_offer;
    PRINT '<< INSERTING DATA INTO : bronze.brz_special_offer';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_special_offer (
        SpecialOfferID, Description, DiscountPct,
        Type, Category, StartDate, EndDate, MinQty, MaxQty
    )
    SELECT
        SpecialOfferID, Description, DiscountPct,
        Type, Category, StartDate, EndDate, MinQty, MaxQty
    FROM AdventureWorks2022.Sales.SpecialOffer;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_special_offer | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_sales_territory';
    TRUNCATE TABLE bronze.brz_sales_territory;
    PRINT '<< INSERTING DATA INTO : bronze.brz_sales_territory';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_sales_territory (
        TerritoryID, Name, CountryRegionCode,
        [Group], SalesYTD, SalesLastYear, CostYTD, CostLastYear
    )
    SELECT
        TerritoryID, Name, CountryRegionCode,
        [Group], SalesYTD, SalesLastYear, CostYTD, CostLastYear
    FROM AdventureWorks2022.Sales.SalesTerritory;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_sales_territory | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_currency_rate';
    TRUNCATE TABLE bronze.brz_currency_rate;
    PRINT '<< INSERTING DATA INTO : bronze.brz_currency_rate';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_currency_rate (
        CurrencyRateID, CurrencyRateDate, FromCurrencyCode,
        ToCurrencyCode, AverageRate, EndOfDayRate
    )
    SELECT
        CurrencyRateID, CurrencyRateDate, FromCurrencyCode,
        ToCurrencyCode, AverageRate, EndOfDayRate
    FROM AdventureWorks2022.Sales.CurrencyRate;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_currency_rate | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    -- ─────────────────────────────────────────

    PRINT '<< TRUNCATING TABLE : bronze.brz_country_region';
    TRUNCATE TABLE bronze.brz_country_region;
    PRINT '<< INSERTING DATA INTO : bronze.brz_country_region';
    SET @table_start = GETDATE();
    INSERT INTO bronze.brz_country_region (
        CountryRegionCode, Name
    )
    SELECT
        CountryRegionCode, Name
    FROM AdventureWorks2022.Person.CountryRegion;
    SET @table_end = GETDATE();
    PRINT 'Done: brz_country_region | Time: ' + CAST(DATEDIFF(SECOND, @table_start, @table_end) AS NVARCHAR) + ' seconds';

    SET @layer_end = GETDATE();
    PRINT '========================================';
    PRINT 'Bronze Layer Load Complete!';
    PRINT 'Total Time: ' + CAST(DATEDIFF(SECOND, @layer_start, @layer_end) AS NVARCHAR) + ' seconds';
    PRINT '========================================';
END
GO





EXEC bronze.proc_load_bronze;