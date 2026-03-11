-- ============================================================
-- FILE    : bronze/ddl/brz_ship_method.sql
-- PURPOSE : Create bronze table for Ship Method
-- SOURCE  : AdventureWorks2022.Purchasing.ShipMethod
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('bronze.brz_ship_method', 'U') IS NOT NULL
    DROP TABLE bronze.brz_ship_method;
GO

CREATE TABLE bronze.brz_ship_method (
    ShipMethodID    INT             NOT NULL,
    Name            NVARCHAR(50)    NOT NULL,
    ShipBase        MONEY           NOT NULL,
    ShipRate        MONEY           NOT NULL,
    dwh_create_date DATETIME        DEFAULT GETDATE()
);
GO