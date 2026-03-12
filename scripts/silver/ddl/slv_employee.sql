-- ============================================================
-- FILE    : silver/ddl/slv_employee.sql
-- PURPOSE : Create silver table for Employee
-- SOURCE  : bronze.brz_employee
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('silver.slv_employee', 'U') IS NOT NULL
    DROP TABLE silver.slv_employee;
GO

CREATE TABLE silver.slv_employee (
    BusinessEntityID    INT             NOT NULL,
    NationalIDNumber    NVARCHAR(15)    NOT NULL,
    LoginID             NVARCHAR(256)   NOT NULL,
    JobTitle            NVARCHAR(50)    NOT NULL,
    BirthDate           DATE            NOT NULL,
    MaritalStatus       NVARCHAR(20)    NOT NULL,
    Gender              NVARCHAR(20)    NOT NULL,
    HireDate            DATE            NOT NULL,
    SalariedFlag        NVARCHAR(20)    NOT NULL,
    VacationHours       SMALLINT        NOT NULL,
    SickLeaveHours      SMALLINT        NOT NULL,
    CurrentFlag         NVARCHAR(20)    NOT NULL,
    dwh_create_date     DATETIME        DEFAULT GETDATE()
);
GO