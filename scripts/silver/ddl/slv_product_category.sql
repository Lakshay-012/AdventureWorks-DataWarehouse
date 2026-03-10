-- ============================================================
-- FILE    : silver/ddl/slv_product_category.sql
-- PURPOSE : Create silver table for Product Category
-- SOURCE  : bronze.brz_product_category
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('silver.slv_product_category', 'U') IS NOT NULL
    DROP TABLE silver.slv_product_category;
GO

CREATE TABLE silver.slv_product_category (
    ProductCategoryID   INT             NOT NULL,
    Name                NVARCHAR(50)    NOT NULL,
    dwh_create_date     DATETIME        DEFAULT GETDATE()
);
GO