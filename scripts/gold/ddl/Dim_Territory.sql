USE AdventureWorksDW;
GO
IF OBJECT_ID('gold.Dim_Territory','U') IS NOT NULL
	DROP TABLE gold.Dim_Territory;

CREATE TABLE gold.Dim_Territory
(
    Territory_SK        INT             NOT NULL,
    TerritoryID         INT             NOT NULL,
    TerritoryName       NVARCHAR(50)    NOT NULL,
    TerritoryGroup      NVARCHAR(50)    NOT NULL,
    CountryCode         NVARCHAR(3)     NOT NULL,
    CountryName         NVARCHAR(50)    NOT NULL
);