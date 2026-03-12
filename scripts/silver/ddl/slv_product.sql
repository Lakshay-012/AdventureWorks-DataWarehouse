-- ============================================================
-- FILE    : silver/ddl/slv_product.sql
-- PURPOSE : Create silver table for Product
-- SOURCE  : bronze.brz_product
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('silver.slv_product', 'U') IS NOT NULL
    DROP TABLE silver.slv_product;
GO

CREATE TABLE silver.slv_product (
    ProductID               INT             NOT NULL,
    Name                    NVARCHAR(50)    NOT NULL,
    ProductNumber           NVARCHAR(25)    NOT NULL,
    MakeFlag                NVARCHAR(25)    NOT NULL,
    FinishedGoodsFlag       NVARCHAR(25)    NOT NULL,
    Color                   NVARCHAR(15)    NOT NULL,
    SafetyStockLevel        SMALLINT        NOT NULL,
    ReorderPoint            SMALLINT        NOT NULL,
    StandardCost            MONEY           NOT NULL,
    ListPrice               MONEY           NOT NULL,
    Size                    NVARCHAR(5)     NOT NULL,
    SizeUnitMeasureCode     NCHAR(3)        NULL,
    WeightUnitMeasureCode   NCHAR(3)        NULL,
    Weight                  DECIMAL(8,2)    NULL,
    DaysToManufacture       INT             NOT NULL,
    ProductLine             NVARCHAR(25)    NULL,
    Class                   NVARCHAR(25)    NULL,
    Style                   NVARCHAR(25)    NULL,
    ProductSubcategoryID    INT             NULL,
    ProductModelID          INT             NULL,
    SellStartDate           DATETIME        NOT NULL,
    SellEndDate             DATETIME        NULL,
    DiscontinuedDate        DATETIME        NULL,
    dwh_create_date         DATETIME        DEFAULT GETDATE()
);
GO