-- ============================================================
-- FILE    : bronze/ddl/brz_country_region.sql
-- PURPOSE : Create bronze table for Country Region
-- SOURCE  : AdventureWorks2022.Person.CountryRegion
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('bronze.brz_country_region', 'U') IS NOT NULL
    DROP TABLE bronze.brz_country_region;
GO

CREATE TABLE bronze.brz_country_region (
    CountryRegionCode   NVARCHAR(3)     NOT NULL,
    Name                NVARCHAR(50)    NOT NULL,
    dwh_create_date     DATETIME        DEFAULT GETDATE()
);
GO