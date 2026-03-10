-- ============================================================
-- FILE    : silver/ddl/slv_sales_order_detail.sql
-- PURPOSE : Create silver table for Sales Order Detail
-- SOURCE  : bronze.brz_sales_order_detail
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('silver.slv_sales_order_detail', 'U') IS NOT NULL
    DROP TABLE silver.slv_sales_order_detail;
GO

CREATE TABLE silver.slv_sales_order_detail (
    SalesOrderID            INT             NOT NULL,
    SalesOrderDetailID      INT             NOT NULL,
    CarrierTrackingNumber   NVARCHAR(25)    NULL,
    OrderQty                SMALLINT        NOT NULL,
    ProductID               INT             NOT NULL,
    SpecialOfferID          INT             NOT NULL,
    UnitPrice               MONEY           NOT NULL,
    UnitPriceDiscount       MONEY           NOT NULL,
    LineTotal               NUMERIC(38,6)   NOT NULL,
    dwh_create_date         DATETIME        DEFAULT GETDATE()
);
GO