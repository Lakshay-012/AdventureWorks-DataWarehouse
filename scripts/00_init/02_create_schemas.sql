-- ============================================================
-- FILE    : 00_init/02_create_schemas.sql
-- PURPOSE : Create the 3 schemas for Medallion Architecture
--           inside the AdventureWorksDW database
-- SCHEMAS :
--           bronze → Raw data copied as-is from source
--           silver → Cleaned and transformed data
--           gold   → Final star schema (dims + facts)
-- NOTE    : Run this AFTER 01_create_database.sql
-- ============================================================


USE AdventureWorksDW;
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'bronze')
    EXEC('CREATE SCHEMA bronze');
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'silver')
    EXEC('CREATE SCHEMA silver');
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'gold')
    EXEC('CREATE SCHEMA gold');
GO