-- ============================================================
-- FILE    : silver/ddl/slv_vendor.sql
-- PURPOSE : Create silver table for Vendor
-- SOURCE  : bronze.brz_vendor
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('silver.slv_vendor', 'U') IS NOT NULL
    DROP TABLE silver.slv_vendor;
GO

CREATE TABLE silver.slv_vendor (
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