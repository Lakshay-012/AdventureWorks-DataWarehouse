-- ============================================================
-- FILE    : silver/ddl/slv_state_province.sql
-- PURPOSE : Create silver table for State Province
-- SOURCE  : bronze.brz_state_province
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('silver.slv_state_province', 'U') IS NOT NULL
    DROP TABLE silver.slv_state_province;
GO

CREATE TABLE silver.slv_state_province (
    StateProvinceID         INT             NOT NULL,
    StateProvinceCode       NCHAR(3)        NOT NULL,
    CountryRegionCode       NVARCHAR(3)     NOT NULL,
    IsOnlyStateProvinceFlag BIT             NOT NULL,
    Name                    NVARCHAR(50)    NOT NULL,
    TerritoryID             INT             NOT NULL,
    dwh_create_date         DATETIME        DEFAULT GETDATE()
);
GO