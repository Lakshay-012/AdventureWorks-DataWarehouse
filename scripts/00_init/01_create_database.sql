-- ============================================================
-- FILE    : 00_init/01_create_database.sql
-- PURPOSE : Create the AdventureWorks Data Warehouse database
-- ============================================================

USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'AdventureWorksDW')
BEGIN
    CREATE DATABASE AdventureWorksDW;
    PRINT 'Database AdventureWorksDW created successfully.';
END
ELSE
BEGIN
    PRINT 'Database AdventureWorksDW already exists. Skipping.';
END
GO