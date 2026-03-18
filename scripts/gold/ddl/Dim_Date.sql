CREATE OR ALTER PROCEDURE gold.proc_load_dim_date
AS
BEGIN
    DECLARE @StartDate  DATE = '2011-01-01';
    DECLARE @EndDate    DATE = '2014-12-31';

    PRINT '========================================';
    PRINT 'Loading gold.Dim_Date';
    PRINT '========================================';

    TRUNCATE TABLE gold.Dim_Date;

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

    PRINT 'Done: Dim_Date loaded!';
    PRINT '========================================';
END
GO