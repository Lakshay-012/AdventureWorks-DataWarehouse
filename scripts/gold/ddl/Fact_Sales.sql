USE AdventureWorksDW;
GO

IF OBJECT_ID('gold.Fact_Sales', 'U') IS NOT NULL
    DROP TABLE gold.Fact_Sales;

CREATE TABLE gold.Fact_Sales (
    Sales_SK            INT             NOT NULL,
    SalesOrderID        INT             NOT NULL,
    SalesOrderDetailID  INT             NOT NULL,
    Customer_SK         INT             NOT NULL,
    Product_SK          INT             NOT NULL,
    Employee_SK         INT             NULL,
    Territory_SK        INT             NOT NULL,
    OrderDate           DATE            NOT NULL,
    DueDate             DATE            NOT NULL,
    ShipDate            DATE            NULL,
    OrderQty            SMALLINT        NOT NULL,
    UnitPrice           MONEY           NOT NULL,
    UnitPriceDiscount   FLOAT           NOT NULL,
    LineTotal           MONEY           NOT NULL,
    TaxAmt              MONEY           NOT NULL,
    Freight             MONEY           NOT NULL,
    TotalDue            MONEY           NOT NULL
);