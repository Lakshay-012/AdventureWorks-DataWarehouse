-- ============================================================
-- FILE    : silver/ddl/slv_currency_rate.sql
-- PURPOSE : Create silver table for Currency Rate
-- SOURCE  : bronze.brz_currency_rate
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('silver.slv_currency_rate', 'U') IS NOT NULL
    DROP TABLE silver.slv_currency_rate;
GO

CREATE TABLE silver.slv_currency_rate (
    CurrencyRateID      INT             NOT NULL,
    CurrencyRateDate    DATETIME        NOT NULL,
    FromCurrencyCode    NCHAR(3)        NOT NULL,
    ToCurrencyCode      NCHAR(3)        NOT NULL,
    AverageRate         MONEY           NOT NULL,
    EndOfDayRate        MONEY           NOT NULL,
    dwh_create_date     DATETIME        DEFAULT GETDATE()
);
GO