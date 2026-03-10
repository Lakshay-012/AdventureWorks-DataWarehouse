-- ============================================================
-- FILE    : silver/ddl/slv_purchase_order_detail.sql
-- PURPOSE : Create silver table for Purchase Order Detail
-- SOURCE  : bronze.brz_purchase_order_detail
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('silver.slv_purchase_order_detail', 'U') IS NOT NULL
    DROP TABLE silver.slv_purchase_order_detail;
GO

CREATE TABLE silver.slv_purchase_order_detail (
    PurchaseOrderID         INT             NOT NULL,
    PurchaseOrderDetailID   INT             NOT NULL,
    DueDate                 DATETIME        NOT NULL,
    OrderQty                SMALLINT        NOT NULL,
    ProductID               INT             NOT NULL,
    UnitPrice               MONEY           NOT NULL,
    LineTotal               MONEY           NOT NULL,
    ReceivedQty             DECIMAL(8,2)    NOT NULL,
    RejectedQty             DECIMAL(8,2)    NOT NULL,
    StockedQty              DECIMAL(8,2)    NOT NULL,
    dwh_create_date         DATETIME        DEFAULT GETDATE()
);
GO