-- ============================================================
-- FILE    : silver/ddl/slv_purchase_order_header.sql
-- PURPOSE : Create silver table for Purchase Order Header
-- SOURCE  : bronze.brz_purchase_order_header
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('silver.slv_purchase_order_header', 'U') IS NOT NULL
    DROP TABLE silver.slv_purchase_order_header;
GO

CREATE TABLE silver.slv_purchase_order_header (
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