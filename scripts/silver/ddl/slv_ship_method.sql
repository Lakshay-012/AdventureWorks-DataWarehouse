-- ============================================================
-- FILE    : silver/ddl/slv_ship_method.sql
-- PURPOSE : Create silver table for Ship Method
-- SOURCE  : bronze.brz_ship_method
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('silver.slv_ship_method', 'U') IS NOT NULL
    DROP TABLE silver.slv_ship_method;
GO

CREATE TABLE silver.slv_ship_method (
    ShipMethodID    INT             NOT NULL,
    Name            NVARCHAR(50)    NOT NULL,
    ShipBase        MONEY           NOT NULL,
    ShipRate        MONEY           NOT NULL,
    dwh_create_date DATETIME        DEFAULT GETDATE()
);
GO