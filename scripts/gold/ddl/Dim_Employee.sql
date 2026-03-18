USE AdventureWorksDW;
GO

IF OBJECT_ID('gold.Dim_Employee', 'U') IS NOT NULL
    DROP TABLE gold.Dim_Employee;

CREATE TABLE gold.Dim_Employee (
    Employee_SK         INT             NOT NULL,
    EmployeeID          INT             NOT NULL,
    FirstName           NVARCHAR(50)    NOT NULL,
    LastName            NVARCHAR(50)    NOT NULL,
    FullName            NVARCHAR(100)   NOT NULL,
    JobTitle            NVARCHAR(50)    NOT NULL,
    Department          NVARCHAR(50)    NOT NULL,
    DepartmentGroup     NVARCHAR(50)    NOT NULL,
    MaritalStatus       NVARCHAR(10)    NOT NULL,
    Gender              NVARCHAR(10)    NOT NULL,
    HireDate            DATE            NOT NULL,
    BirthDate           DATE            NOT NULL,
    SalariedFlag        NVARCHAR(10)    NOT NULL,
    CurrentFlag         NVARCHAR(20)    NOT NULL,
    VacationHours       SMALLINT        NOT NULL,
    SickLeaveHours      SMALLINT        NOT NULL
);