-- ============================================================
-- FILE    : bronze/ddl/brz_department.sql
-- SOURCE  : AdventureWorks2022.HumanResources.Department
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('bronze.brz_department', 'U') IS NOT NULL
    DROP TABLE bronze.brz_department;
GO

CREATE TABLE bronze.brz_department (
    DepartmentID    SMALLINT        NOT NULL,
    Name            NVARCHAR(50)    NOT NULL,
    GroupName       NVARCHAR(50)    NOT NULL,
    dwh_create_date DATETIME        DEFAULT GETDATE()
);
GO