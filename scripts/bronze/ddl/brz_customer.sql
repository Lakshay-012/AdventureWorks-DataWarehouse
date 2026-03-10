-- ============================================================
-- FILE    : bronze/ddl/brz_customer.sql
-- SOURCE  : AdventureWorks2022.Sales.Customer
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('bronze.brz_customer', 'U') IS NOT NULL
    DROP TABLE bronze.brz_customer;
GO

CREATE TABLE bronze.brz_customer (
    CustomerID      INT             NOT NULL,
    PersonID        INT             NULL,
    StoreID         INT             NULL,
    TerritoryID     INT             NULL,
    AccountNumber   NVARCHAR(10)    NOT NULL,
    dwh_create_date DATETIME        DEFAULT GETDATE()
);
GO