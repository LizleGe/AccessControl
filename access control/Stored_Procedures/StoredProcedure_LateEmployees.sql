USE [Optimi_College]
GO
/****** Object:  StoredProcedure [dbo].[LateEmployees]    Script Date: 16 Dec 2023 18:48:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        <Author: Elizma le Grange>
-- Create date:   <Create Date: 2 Desember 2023>
-- Description:   <Description: This is a Stored Procedure to show all the late employees signing in the first time after 8:30 am>
-- =============================================
ALTER PROCEDURE [dbo].[LateEmployees]														-- The Stored Procedure name, LateEmployees.
AS
BEGIN
    SET NOCOUNT ON;
																							-- SET NOCOUNT ON added to prevent extra result sets from
--																							   interfering with SELECT statements.

    DECLARE @thresholdTime TIME = '08:30:00.000';											-- The time at which the employee should start are declared.

    SELECT 
        CONVERT(DATETIME, [Date And Time]) AS [DateAndTime],								-- The Date And Time column is selected and given an alias of DateAndTime, which will be used in C# to call this procedure.
        [Personnel_ID] AS PersonnelID,														-- The Personnel_ID column is selected and given an alias of PersonnelID, which will be used in C# to call this procedure.
        [Date And Time] AS FirstLogInTime,													-- The Date And Time column is selected and given an alias of FirstLogInTime, which will be used in C# to call this procedure.
        'Late' AS LateToday																	-- The Value 'Late' is created with alias Late too show the late employees. 
		
    FROM (
        SELECT 
            [Personnel_ID],																	-- The personnel_ID column is selected from the Optimi_College database from ImportEmployee table
            [Date And Time],																-- The [Date And Time] column is selected from the Optimi_College database from ImportEmployee table
            ROW_NUMBER() OVER (PARTITION BY CONVERT(DATE, [Date And Time]), [Personnel_ID]	-- Row numbers are generated starting from 1 for 
																							-- Each unique combination of date and personnelID ordered by the date and time 																  --
			ORDER BY [Date And Time]) AS RowNum												-- The Data and Time and Personnel_ID wil be ordered by Data and Time.
			
        FROM 
            [Optimi_College].[dbo].[ImportEmployee]											-- The records are selected from Otimi_College database and the table, Import Employee 


        WHERE [Event_Description] NOT IN (													-- If the Event_Description column has the values:Person Not Registered, Validate Interval TooShort 
            																				-- Disconnected and exit Button Open, it will be excluded from the results.
                'Person Not Registered',
                'Validate Interval Too Short',
                'Disconnected',
                'Exit Button Open'
            )
            AND CONVERT(TIME, [Date And Time]) > @thresholdTime								-- The records are filtered where Login time is greater than @thresholdTime
    ) AS Earliest_LogIn_Employee															-- My subquery is Earliest_LogIn_Employee which identifies the earliest late logins. 
	
    WHERE  Earliest_LogIn_Employee.RowNum = 1												-- This will filter the late login records for each employee on a specific day	 
      												
    ORDER BY [Date And Time] ASC;															-- Sorting the records in ascending order by Date and Time.															
        
END