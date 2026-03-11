-- ============================================================
-- FILE    : bronze/ddl/brz_special_offer.sql
-- PURPOSE : Create bronze table for Special Offer
-- SOURCE  : AdventureWorks2022.Sales.SpecialOffer
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('bronze.brz_special_offer', 'U') IS NOT NULL
    DROP TABLE bronze.brz_special_offer;
GO

CREATE TABLE bronze.brz_special_offer (
    SpecialOfferID  INT             NOT NULL,
    Description     NVARCHAR(255)   NOT NULL,
    DiscountPct     SMALLMONEY      NOT NULL,
    Type            NVARCHAR(50)    NOT NULL,
    Category        NVARCHAR(50)    NOT NULL,
    StartDate       DATETIME        NOT NULL,
    EndDate         DATETIME        NOT NULL,
    MinQty          INT             NOT NULL,
    MaxQty          INT             NULL,
    dwh_create_date DATETIME        DEFAULT GETDATE()
);
GO