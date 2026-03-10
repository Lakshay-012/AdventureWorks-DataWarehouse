-- ============================================================
-- FILE    : bronze/ddl/brz_product_subcategory.sql
-- SOURCE  : AdventureWorks2022.Production.ProductSubcategory
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('bronze.brz_product_subcategory', 'U') IS NOT NULL
    DROP TABLE bronze.brz_product_subcategory;
GO

CREATE TABLE bronze.brz_product_subcategory (
    ProductSubcategoryID    INT             NOT NULL,
    ProductCategoryID       INT             NOT NULL,
    Name                    NVARCHAR(50)    NOT NULL,
    dwh_create_date         DATETIME        DEFAULT GETDATE()
);
GO