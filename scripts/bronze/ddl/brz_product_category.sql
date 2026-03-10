-- ============================================================
-- FILE    : bronze/ddl/brz_product_category.sql
-- SOURCE  : AdventureWorks2022.Production.ProductCategory
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('bronze.brz_product_category', 'U') IS NOT NULL
    DROP TABLE bronze.brz_product_category;
GO

CREATE TABLE bronze.brz_product_category (
    ProductCategoryID   INT             NOT NULL,
    Name                NVARCHAR(50)    NOT NULL,
    dwh_create_date     DATETIME        DEFAULT GETDATE()
);
GO