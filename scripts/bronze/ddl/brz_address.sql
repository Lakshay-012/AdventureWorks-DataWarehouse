-- ============================================================
-- FILE    : bronze/ddl/brz_address.sql
-- SOURCE  : AdventureWorks2022.Person.Address
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('bronze.brz_address', 'U') IS NOT NULL
    DROP TABLE bronze.brz_address;
GO

CREATE TABLE bronze.brz_address (
    AddressID       INT             NOT NULL,
    AddressLine1    NVARCHAR(60)    NOT NULL,
    AddressLine2    NVARCHAR(60)    NULL,
    City            NVARCHAR(30)    NOT NULL,
    StateProvinceID INT             NOT NULL,
    PostalCode      NVARCHAR(15)    NOT NULL,
    dwh_create_date DATETIME        DEFAULT GETDATE()
);
GO