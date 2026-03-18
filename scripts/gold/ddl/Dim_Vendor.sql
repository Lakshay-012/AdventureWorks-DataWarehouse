USE AdventureWorksDW;
GO

IF OBJECT_ID('gold.Dim_Vendor', 'U') IS NOT NULL
    DROP TABLE gold.Dim_Vendor;

CREATE TABLE gold.Dim_Vendor (
    Vendor_SK               INT             NOT NULL,
    VendorID                INT             NOT NULL,
    VendorName              NVARCHAR(50)    NOT NULL,
    AccountNumber           NVARCHAR(15)    NOT NULL,
    CreditRating            NVARCHAR(20)    NOT NULL,
    PreferredVendorStatus   NVARCHAR(20)    NOT NULL,
    ActiveFlag              NVARCHAR(10)    NOT NULL
);