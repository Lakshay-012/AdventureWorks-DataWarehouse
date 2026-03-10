-- ============================================================
-- FILE    : bronze/ddl/brz_vendor.sql
-- SOURCE  : AdventureWorks2022.Purchasing.Vendor
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('bronze.brz_vendor', 'U') IS NOT NULL
    DROP TABLE bronze.brz_vendor;
GO

CREATE TABLE bronze.brz_vendor (
    BusinessEntityID        INT             NOT NULL,
    AccountNumber           NVARCHAR(15)    NOT NULL,
    Name                    NVARCHAR(50)    NOT NULL,
    CreditRating            TINYINT         NOT NULL,
    PreferredVendorStatus   BIT             NOT NULL,
    ActiveFlag              BIT             NOT NULL,
    PurchasingWebServiceURL NVARCHAR(1024)  NULL,
    dwh_create_date         DATETIME        DEFAULT GETDATE()
);
GO