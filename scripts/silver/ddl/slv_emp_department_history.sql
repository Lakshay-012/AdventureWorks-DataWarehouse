-- ============================================================
-- FILE    : silver/ddl/slv_emp_department_history.sql
-- PURPOSE : Create silver table for Employee Department History
-- SOURCE  : bronze.brz_emp_department_history
-- ============================================================

USE AdventureWorksDW;
GO

IF OBJECT_ID('silver.slv_emp_department_history', 'U') IS NOT NULL
    DROP TABLE silver.slv_emp_department_history;
GO

CREATE TABLE silver.slv_emp_department_history (
    BusinessEntityID    INT         NOT NULL,
    DepartmentID        SMALLINT    NOT NULL,
    ShiftID             TINYINT     NOT NULL,
    StartDate           DATE        NOT NULL,
    EndDate             DATE        NULL,
    dwh_create_date     DATETIME    DEFAULT GETDATE()
);
GO