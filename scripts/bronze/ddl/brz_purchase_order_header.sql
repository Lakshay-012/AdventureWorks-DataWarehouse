-- ============================================================
-- FILE    : bronze/ddl/brz_purchase_order_header.sql
-- SOURCE  : AdventureWorks2022.Purchasing.PurchaseOrderHeader
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('bronze.brz_purchase_order_header', 'U') IS NOT NULL
    DROP TABLE bronze.brz_purchase_order_header;
GO

CREATE TABLE bronze.brz_purchase_order_header (
    PurchaseOrderID     INT         NOT NULL,
    RevisionNumber      TINYINT     NOT NULL,
    Status              TINYINT     NOT NULL,
    EmployeeID          INT         NOT NULL,
    VendorID            INT         NOT NULL,
    ShipMethodID        INT         NOT NULL,
    OrderDate           DATETIME    NOT NULL,
    ShipDate            DATETIME    NULL,
    SubTotal            MONEY       NOT NULL,
    TaxAmt              MONEY       NOT NULL,
    Freight             MONEY       NOT NULL,
    TotalDue            MONEY       NOT NULL,
    dwh_create_date     DATETIME    DEFAULT GETDATE()
);
GO