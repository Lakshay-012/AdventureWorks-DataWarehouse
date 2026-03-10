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


-- CHECKING IF THE BRONZE SCHEMA ALREADY EXISTS AND IF IT DOES THEN DROP IT AND CREATE NEW ONE.
IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'bronze')
DROP SCHEMA bronze;
BEGIN
    EXEC('CREATE SCHEMA bronze');
END;
GO



-- CHECKING IF THE SILVER SCHEMA ALREADY EXISTS AND IF IT DOES THEN DROP IT AND CREATE NEW ONE.
IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'silver')
DROP SCHEMA silver;
BEGIN
    EXEC('CREATE SCHEMA silver');
END;
GO




-- CHECKING IF THE SILVER SCHEMA ALREADY EXISTS AND IF IT DOES THEN DROP IT AND CREATE NEW ONE.
IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'gold')
DROP SCHEMA gold;
BEGIN
    EXEC('CREATE SCHEMA gold');
END;
GO
