-- ============================================================
-- FILE    : silver/ddl/slv_product_subcategory.sql
-- PURPOSE : Create silver table for Product Subcategory
-- SOURCE  : bronze.brz_product_subcategory
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('silver.slv_product_subcategory', 'U') IS NOT NULL
    DROP TABLE silver.slv_product_subcategory;
GO

CREATE TABLE silver.slv_product_subcategory (
    ProductSubcategoryID    INT             NOT NULL,
    ProductCategoryID       INT             NOT NULL,
    Name                    NVARCHAR(50)    NOT NULL,
    dwh_create_date         DATETIME        DEFAULT GETDATE()
);
GO