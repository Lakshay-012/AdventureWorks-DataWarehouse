-- ============================================================
-- FILE    : bronze/ddl/brz_person.sql
-- SOURCE  : AdventureWorks2022.Person.Person
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('bronze.brz_person', 'U') IS NOT NULL
    DROP TABLE bronze.brz_person;
GO

CREATE TABLE bronze.brz_person (
    BusinessEntityID    INT             NOT NULL,
    PersonType          NCHAR(2)        NOT NULL,
    NameStyle           BIT             NOT NULL,
    Title               NVARCHAR(8)     NULL,
    FirstName           NVARCHAR(50)    NOT NULL,
    MiddleName          NVARCHAR(50)    NULL,
    LastName            NVARCHAR(50)    NOT NULL,
    Suffix              NVARCHAR(10)    NULL,
    EmailPromotion      INT             NOT NULL,
    dwh_create_date     DATETIME        DEFAULT GETDATE()
);
GO