-- ============================================================
-- FILE    : bronze/ddl/brz_sales_order_header.sql
-- SOURCE  : AdventureWorks2022.Sales.SalesOrderHeader
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('bronze.brz_sales_order_header', 'U') IS NOT NULL
    DROP TABLE bronze.brz_sales_order_header;
GO

CREATE TABLE bronze.brz_sales_order_header (
    SalesOrderID        INT             NOT NULL,
    RevisionNumber      TINYINT         NOT NULL,
    OrderDate           DATETIME        NOT NULL,
    DueDate             DATETIME        NOT NULL,
    ShipDate            DATETIME        NULL,
    Status              TINYINT         NOT NULL,
    OnlineOrderFlag     BIT             NOT NULL,
    SalesOrderNumber    NVARCHAR(25)    NOT NULL,
    CustomerID          INT             NOT NULL,
    SalesPersonID       INT             NULL,
    TerritoryID         INT             NULL,
    BillToAddressID     INT             NOT NULL,
    ShipToAddressID     INT             NOT NULL,
    ShipMethodID        INT             NOT NULL,
    CurrencyRateID      INT             NULL,
    SubTotal            MONEY           NOT NULL,
    TaxAmt              MONEY           NOT NULL,
    Freight             MONEY           NOT NULL,
    TotalDue            MONEY           NOT NULL,
    Comment             NVARCHAR(128)   NULL,
    dwh_create_date     DATETIME        DEFAULT GETDATE()
);
GO