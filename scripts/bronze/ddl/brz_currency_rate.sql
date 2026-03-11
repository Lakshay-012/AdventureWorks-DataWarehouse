-- ============================================================
-- FILE    : bronze/ddl/brz_currency_rate.sql
-- PURPOSE : Create bronze table for Currency Rate
-- SOURCE  : AdventureWorks2022.Sales.CurrencyRate
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('bronze.brz_currency_rate', 'U') IS NOT NULL
    DROP TABLE bronze.brz_currency_rate;
GO

CREATE TABLE bronze.brz_currency_rate (
    CurrencyRateID      INT             NOT NULL,
    CurrencyRateDate    DATETIME        NOT NULL,
    FromCurrencyCode    NCHAR(3)        NOT NULL,
    ToCurrencyCode      NCHAR(3)        NOT NULL,
    AverageRate         MONEY           NOT NULL,
    EndOfDayRate        MONEY           NOT NULL,
    dwh_create_date     DATETIME        DEFAULT GETDATE()
);
GO