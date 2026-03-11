-- ============================================================
-- FILE    : bronze/ddl/brz_sales_territory.sql
-- PURPOSE : Create bronze table for Sales Territory
-- SOURCE  : AdventureWorks2022.Sales.SalesTerritory
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('bronze.brz_sales_territory', 'U') IS NOT NULL
    DROP TABLE bronze.brz_sales_territory;
GO

CREATE TABLE bronze.brz_sales_territory (
    TerritoryID         INT             NOT NULL,
    Name                NVARCHAR(50)    NOT NULL,
    CountryRegionCode   NVARCHAR(3)     NOT NULL,
    [Group]               NVARCHAR(50)    NOT NULL,
    SalesYTD            MONEY           NOT NULL,
    SalesLastYear       MONEY           NOT NULL,
    CostYTD             MONEY           NOT NULL,
    CostLastYear        MONEY           NOT NULL,
    dwh_create_date     DATETIME        DEFAULT GETDATE()
);
GO