-- ============================================================
-- FILE    : bronze/ddl/brz_employee.sql
-- SOURCE  : AdventureWorks2022.HumanResources.Employee
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('bronze.brz_employee', 'U') IS NOT NULL
    DROP TABLE bronze.brz_employee;
GO

CREATE TABLE bronze.brz_employee (
    BusinessEntityID    INT             NOT NULL,
    NationalIDNumber    NVARCHAR(15)    NOT NULL,
    LoginID             NVARCHAR(256)   NOT NULL,
    JobTitle            NVARCHAR(50)    NOT NULL,
    BirthDate           DATE            NOT NULL,
    MaritalStatus       NCHAR(1)        NOT NULL,
    Gender              NCHAR(1)        NOT NULL,
    HireDate            DATE            NOT NULL,
    SalariedFlag        BIT             NOT NULL,
    VacationHours       SMALLINT        NOT NULL,
    SickLeaveHours      SMALLINT        NOT NULL,
    CurrentFlag         BIT             NOT NULL,
    dwh_create_date     DATETIME        DEFAULT GETDATE()
);
GO