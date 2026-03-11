-- ============================================================
-- FILE    : silver/ddl/slv_sales_territory.sql
-- PURPOSE : Create silver table for Sales Territory
-- SOURCE  : bronze.brz_sales_territory
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('silver.slv_sales_territory', 'U') IS NOT NULL
    DROP TABLE silver.slv_sales_territory;
GO

CREATE TABLE silver.slv_sales_territory (
    TerritoryID         INT             NOT NULL,
    Name                NVARCHAR(50)    NOT NULL,
    CountryRegionCode   NVARCHAR(3)     NOT NULL,
    TerritoryGroup      NVARCHAR(50)    NOT NULL,
    SalesYTD            MONEY           NOT NULL,
    SalesLastYear       MONEY           NOT NULL,
    CostYTD             MONEY           NOT NULL,
    CostLastYear        MONEY           NOT NULL,
    dwh_create_date     DATETIME        DEFAULT GETDATE()
);
GO