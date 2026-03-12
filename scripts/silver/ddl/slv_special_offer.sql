-- ============================================================
-- FILE    : silver/ddl/slv_special_offer.sql
-- PURPOSE : Create silver table for Special Offer
-- SOURCE  : bronze.brz_special_offer
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('silver.slv_special_offer', 'U') IS NOT NULL
    DROP TABLE silver.slv_special_offer;
GO

CREATE TABLE silver.slv_special_offer (
    SpecialOfferID  INT             NOT NULL,
    Description     NVARCHAR(255)   NOT NULL,
    DiscountPct     SMALLMONEY      NOT NULL,
    Type            NVARCHAR(50)    NOT NULL,
    Category        NVARCHAR(50)    NOT NULL,
    StartDate       DATETIME        NOT NULL,
    EndDate         DATETIME        NOT NULL,
    MinQty          INT             NOT NULL,
    MaxQty          INT             NOT NULL,
    dwh_create_date DATETIME        DEFAULT GETDATE()
);
GO