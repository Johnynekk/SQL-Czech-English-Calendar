CREATE TABLE calendar (
  date DATE,
  date_cz VARCHAR(20),
  day INT,
  month INT,
  year INT,
  day_en VARCHAR(20),
  day_cz VARCHAR(20),
  month_name_en VARCHAR(20),
  month_name_cz VARCHAR(20)
  
);



DECLARE @year INT = YEAR(GETDATE());
DECLARE @endYear INT = @year + 10;

WHILE (@year <= @endYear)
BEGIN
  DECLARE @month INT = 1;
  WHILE (@month <= 12)
  BEGIN
    DECLARE @day INT = 1;
    DECLARE @lastDayOfMonth INT = DAY(EOMONTH(CAST(@year AS VARCHAR(4)) + '-' + CAST(@month AS VARCHAR(2)) + '-01'));
    WHILE (@day <= @lastDayOfMonth)
    BEGIN
      DECLARE @date DATE = CAST(@year AS VARCHAR(4)) + '-' + CAST(@month AS VARCHAR(2)) + '-' + CAST(@day AS VARCHAR(2));
      DECLARE @date_cz VARCHAR(20) = CONVERT(VARCHAR(10), @date, 104);
      DECLARE @day_en VARCHAR(20) = DATENAME(WEEKDAY, @date);
      DECLARE @day_cz VARCHAR(20) = 
        CASE
          WHEN @day_en = 'Monday' THEN 'Pondělí'
          WHEN @day_en = 'Tuesday' THEN 'Úterý'
          WHEN @day_en = 'Wednesday' THEN 'Středa'
          WHEN @day_en = 'Thursday' THEN 'Čtvrtek'
          WHEN @day_en = 'Friday' THEN 'Pátek'
          WHEN @day_en = 'Saturday' THEN 'Sobota'
          ELSE 'Neděle'
        END;
      DECLARE @month_name_en VARCHAR(20) = DATENAME(MONTH, @date);
      DECLARE @month_name_cz VARCHAR(20) = 
        CASE
          WHEN @month_name_en = 'January' THEN 'Leden'
          WHEN @month_name_en = 'February' THEN 'Únor'
          WHEN @month_name_en = 'March' THEN 'Březen'
          WHEN @month_name_en = 'April' THEN 'Duben'
          WHEN @month_name_en = 'May' THEN 'Květen'
          WHEN @month_name_en = 'June' THEN 'Červen'
          WHEN @month_name_en = 'July' THEN 'Červenec'
          WHEN @month_name_en = 'August' THEN 'Srpen'
          WHEN @month_name_en = 'September' THEN 'Září'
          WHEN @month_name_en = 'October' THEN 'Říjen'
          WHEN @month_name_en = 'November' THEN 'Listopad'
          ELSE 'Prosinec'
        END;
      
      INSERT INTO calendar (date, date_cz, day, month, year, day_en, day_cz, month_name_en, month_name_cz)
      VALUES (@date, @date_cz, @day, @month, @year, @day_en, @day_cz, @month_name_en, @month_name_cz);
      
      SET @day = @day + 1;
    END;
    SET @month = @month + 1;
  END;
  SET @year = @year + 1;
END;



ALTER TABLE calendar
ADD school_year VARCHAR(9);

UPDATE calendar
SET school_year =
CASE WHEN [date] between '2022-09-01' and '2023-08-31' THEN '2022/2023'
	 WHEN [date] between '2023-09-01' and '2024-08-31' THEN '2023/2024'
	WHEN [date] between '2024-09-01' and '2025-08-31' THEN '2024/2025'
	 WHEN [date] between '2025-09-01' and '2026-08-31' THEN '2025/2026'
	 WHEN [date] between '2026-09-01' and '2027-08-31' THEN '2026/2027'
	 WHEN [date] between '2027-09-01' and '2028-08-31' THEN '2027/2028'
	 WHEN [date] between '2028-09-01' and '2029-08-31' THEN '2028/2029'
	 WHEN [date] between '2029-09-01' and '2030-08-31' THEN '2029/2030'
	 WHEN [date] between '2030-09-01' and '2031-08-31' THEN '2030/2031'
	 WHEN [date] between '2031-09-01' and '2032-08-31' THEN '2031/2032'
	 WHEN [date] between '2032-09-01' and '2033-08-31' THEN '2032/2033'
	 WHEN [date] between '2033-09-01' and '2034-08-31' THEN '2033/2034'
END
;
