USE AdventureWorksDW;
GO

IF OBJECT_ID('gold.Dim_Product', 'U') IS NOT NULL
    DROP TABLE gold.Dim_Product;

CREATE TABLE gold.Dim_Product (
    Product_SK          INT             NOT NULL,
    ProductID           INT             NOT NULL,
    ProductNumber       NVARCHAR(25)    NOT NULL,
    ProductName         NVARCHAR(50)    NOT NULL,
    ProductLine         NVARCHAR(15)    NOT NULL,
    Class               NVARCHAR(10)    NOT NULL,
    Color               NVARCHAR(15)    NOT NULL,
    Size                NVARCHAR(5)     NOT NULL,
    ListPrice           MONEY           NOT NULL,
    StandardCost        MONEY           NOT NULL,
    SubcategoryName     NVARCHAR(50),
    CategoryName        NVARCHAR(50)
);