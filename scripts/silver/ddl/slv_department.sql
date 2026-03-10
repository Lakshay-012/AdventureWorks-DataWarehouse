-- ============================================================
-- FILE    : silver/ddl/slv_department.sql
-- PURPOSE : Create silver table for Department
-- SOURCE  : bronze.brz_department
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('silver.slv_department', 'U') IS NOT NULL
    DROP TABLE silver.slv_department;
GO

CREATE TABLE silver.slv_department (
    DepartmentID    SMALLINT        NOT NULL,
    Name            NVARCHAR(50)    NOT NULL,
    GroupName       NVARCHAR(50)    NOT NULL,
    dwh_create_date DATETIME        DEFAULT GETDATE()
);
GO