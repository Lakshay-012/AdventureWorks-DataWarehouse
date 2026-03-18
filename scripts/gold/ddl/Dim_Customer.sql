USE AdventureWorksDW;
GO

IF OBJECT_ID('gold.Dim_Customer', 'U') IS NOT NULL
    DROP TABLE gold.Dim_Customer;

CREATE TABLE gold.Dim_Customer (
    Customer_SK         INT             NOT NULL,
    CustomerID          INT             NOT NULL,
    FirstName           NVARCHAR(50),
    LastName            NVARCHAR(50),
    FullName            NVARCHAR(100),
    TerritoryName       NVARCHAR(50)    NOT NULL,
    TerritoryGroup      NVARCHAR(50)    NOT NULL,
    CountryCode         NVARCHAR(3)     NOT NULL,
    CountryName         NVARCHAR(50)    NOT NULL
);