-- ============================================================
-- FILE    : bronze/ddl/brz_purchase_order_detail.sql
-- SOURCE  : AdventureWorks2022.Purchasing.PurchaseOrderDetail
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('bronze.brz_purchase_order_detail', 'U') IS NOT NULL
    DROP TABLE bronze.brz_purchase_order_detail;
GO

CREATE TABLE bronze.brz_purchase_order_detail (
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