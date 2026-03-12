-- ============================================================
-- FILE    : silver/ddl/slv_person.sql
-- PURPOSE : Create silver table for Person
-- SOURCE  : bronze.brz_person
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('silver.slv_person', 'U') IS NOT NULL
    DROP TABLE silver.slv_person;
GO

CREATE TABLE silver.slv_person (
    BusinessEntityID    INT             NOT NULL,
    PersonType          NVARCHAR(25)    NOT NULL,
    NameStyle           NVARCHAR(25)    NOT NULL,
    Title               NVARCHAR(8)     NOT NULL,
    FirstName           NVARCHAR(50)    NOT NULL,
    MiddleName          NVARCHAR(50)    NOT NULL,
    LastName            NVARCHAR(50)    NOT NULL,
    Suffix              NVARCHAR(10)    NOT NULL,
    EmailPromotion      NVARCHAR(30)    NOT NULL,
    dwh_create_date     DATETIME        DEFAULT GETDATE()
);
GO