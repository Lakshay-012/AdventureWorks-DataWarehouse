-- ============================================================
-- FILE    : bronze/ddl/brz_emp_department_history.sql
-- SOURCE  : AdventureWorks2022.HumanResources.EmployeeDepartmentHistory
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('bronze.brz_emp_department_history', 'U') IS NOT NULL
    DROP TABLE bronze.brz_emp_department_history;
GO

CREATE TABLE bronze.brz_emp_department_history (
    BusinessEntityID    INT         NOT NULL,
    DepartmentID        SMALLINT    NOT NULL,
    ShiftID             TINYINT     NOT NULL,
    StartDate           DATE        NOT NULL,
    EndDate             DATE        NULL,
    dwh_create_date     DATETIME    DEFAULT GETDATE()
);
GO