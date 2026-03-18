USE AdventureWorksDW;
GO

IF OBJECT_ID('gold.Fact_Purchases', 'U') IS NOT NULL
    DROP TABLE gold.Fact_Purchases;

CREATE TABLE gold.Fact_Purchases (
    Purchase_SK             INT         NOT NULL,
    PurchaseOrderID         INT         NOT NULL,
    PurchaseOrderDetailID   INT         NOT NULL,
    Employee_SK             INT         NOT NULL,
    Vendor_SK               INT         NOT NULL,
    Product_SK              INT         NOT NULL,
    OrderDate               DATE        NOT NULL,
    ShipDate                DATE        NULL,
    DueDate                 DATE        NOT NULL,
    OrderQty                SMALLINT    NOT NULL,
    UnitPrice               MONEY       NOT NULL,
    LineTotal               MONEY       NOT NULL,
    ReceivedQty             FLOAT       NOT NULL,
    RejectedQty             FLOAT       NOT NULL,
    StockedQty              FLOAT       NOT NULL,
    TaxAmt                  MONEY       NOT NULL,
    Freight                 MONEY       NOT NULL,
    TotalDue                MONEY       NOT NULL
);