-- ============================================================
-- FILE    : silver/ddl/slv_customer.sql
-- PURPOSE : Create silver table for Customer
-- SOURCE  : bronze.brz_customer
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('silver.slv_customer', 'U') IS NOT NULL
    DROP TABLE silver.slv_customer;
GO

CREATE TABLE silver.slv_customer (
    CustomerID      INT             NOT NULL,
    PersonID        INT             NULL,
    StoreID         INT             NULL,
    TerritoryID     INT             NULL,
    AccountNumber   NVARCHAR(10)    NOT NULL,
    dwh_create_date DATETIME        DEFAULT GETDATE()
);
GO