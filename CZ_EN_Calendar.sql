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