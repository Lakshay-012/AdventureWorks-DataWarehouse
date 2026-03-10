-- ============================================================
-- FILE    : silver/ddl/slv_address.sql
-- PURPOSE : Create silver table for Address
-- SOURCE  : bronze.brz_address
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('silver.slv_address', 'U') IS NOT NULL
    DROP TABLE silver.slv_address;
GO

CREATE TABLE silver.slv_address (
    AddressID       INT             NOT NULL,
    AddressLine1    NVARCHAR(60)    NOT NULL,
    AddressLine2    NVARCHAR(60)    NULL,
    City            NVARCHAR(30)    NOT NULL,
    StateProvinceID INT             NOT NULL,
    PostalCode      NVARCHAR(15)    NOT NULL,
    dwh_create_date DATETIME        DEFAULT GETDATE()
);
GO