-- ============================================================
-- POPULATING Dim_Date FROM 2011-01-01 TO 2014-12-31
-- ============================================================

USE AdventureWorksDW;
GO

DECLARE @StartDate DATE = '2011-01-01';
DECLARE @EndDate   DATE = '2014-12-31';

WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO gold.Dim_Date (
        Date_SK,
        FullDate,
        Day,
        Month,
        MonthName,
        Quarter,
        Year,
        DayOfWeek,
        DayName,
        IsWeekend
    )
    VALUES (
        -- YYYYMMDD format
        CAST(FORMAT(@StartDate, 'yyyyMMdd') AS INT),
        @StartDate,
        DAY(@StartDate),
        MONTH(@StartDate),
        DATENAME(MONTH, @StartDate),
        DATEPART(QUARTER, @StartDate),
        YEAR(@StartDate),
        DATEPART(WEEKDAY, @StartDate),
        DATENAME(WEEKDAY, @StartDate),
        CASE
            WHEN DATEPART(WEEKDAY, @StartDate) IN (1, 7) THEN 'Yes'
            ELSE 'No'
        END
    );

    SET @StartDate = DATEADD(DAY, 1, @StartDate);
END

