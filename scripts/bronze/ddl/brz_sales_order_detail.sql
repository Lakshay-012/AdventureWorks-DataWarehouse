-- ============================================================
-- FILE    : bronze/ddl/brz_sales_order_detail.sql
-- SOURCE  : AdventureWorks2022.Sales.SalesOrderDetail
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('bronze.brz_sales_order_detail', 'U') IS NOT NULL
    DROP TABLE bronze.brz_sales_order_detail;
GO

CREATE TABLE bronze.brz_sales_order_detail (
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