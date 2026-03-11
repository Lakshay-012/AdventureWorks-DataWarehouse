-- ============================================================
-- FILE    : silver/ddl/slv_country_region.sql
-- PURPOSE : Create silver table for Country Region
-- SOURCE  : bronze.brz_country_region
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('silver.slv_country_region', 'U') IS NOT NULL
    DROP TABLE silver.slv_country_region;
GO

CREATE TABLE silver.slv_country_region (
    CountryRegionCode   NVARCHAR(3)     NOT NULL,
    Name                NVARCHAR(50)    NOT NULL,
    dwh_create_date     DATETIME        DEFAULT GETDATE()
);
GO