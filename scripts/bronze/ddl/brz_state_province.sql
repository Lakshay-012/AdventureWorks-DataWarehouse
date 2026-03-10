-- ============================================================
-- FILE    : bronze/ddl/brz_state_province.sql
-- SOURCE  : AdventureWorks2022.Person.StateProvince
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('bronze.brz_state_province', 'U') IS NOT NULL
    DROP TABLE bronze.brz_state_province;
GO

CREATE TABLE bronze.brz_state_province (
    StateProvinceID     INT             NOT NULL,
    StateProvinceCode   NCHAR(3)        NOT NULL,
    CountryRegionCode   NVARCHAR(3)     NOT NULL,
    IsOnlyStateProvinceFlag BIT         NOT NULL,
    Name                NVARCHAR(50)    NOT NULL,
    TerritoryID         INT             NOT NULL,
    dwh_create_date     DATETIME        DEFAULT GETDATE()
);
GO