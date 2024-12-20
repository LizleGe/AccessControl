USE [Optimi_College]
GO
/****** Object:  StoredProcedure [dbo].[FireDrill]    Script Date: 16 Dec 2023 18:22:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:       <Author: Elizma le Grange>
-- Create date:  <Create Date: 2 Desmeber 2023>
-- Description:  <This is a Stored Procedure that will provide all the records between 9:45 and 9:50
--                where employees logged in and out.The user can therefore, have a record of everyone 
--				  who logged in and out during the specific time period.
--            
--                During a firedrill, Employees takes time to leave the building
--				  therefore, a time of 10 min was given for employees to leave the building. The user
--                can change this time based on company needs.
--                
--                The user can modify this stored procedure based on their specific firedrill date and 
--                time.In line 35 & 36 they can change the time interval or add a date.The code has been
--                provided in line 37, to change the date (Please remove the "--" infornt of the code to
--                remove the comments).
--                The user can remove either or the 'Normal Open' and 'Exit Button Open' based on 
--                the company needs.>               
-- =============================================

ALTER PROCEDURE [dbo].[FireDrill]									-- The Stored Procedure name, FireDrill.
AS
BEGIN
    SET NOCOUNT ON; 
																	-- SET NOCOUNT ON added to prevent extra result sets from
																	-- interfering with SELECT statements.
    DECLARE @StartTime TIME = '09:45:00';							-- Start time for the fire drill interval.
    DECLARE @EndTime TIME = '09:50:00';								-- End time for the fire drill interval.
--	DECLARE @StartDate DATE = '2023-11-16'							--Read description for more information

    SELECT 
        [Date And Time] AS DateAndTime,								-- Selecting the Date and Time column, aliasing it as DateAndTime.
        [Personnel_ID] AS PersonnelID,								-- Selecting the Personnel_ID column, aliasing it as PersonnelID to be used in C#. 
        [Card_Number] AS CardNumber,								-- Selecting the Card_Number column, aliasing it as CardNumber to be used in C#. 
        [Device_Name] AS DeviceName,								-- Selecting the Device_Name column, aliasing it as DeviceName to be used in C#. 
        [Event_Point] AS EventPoint,								-- Selecting the Event_Point column, aliasing it as EventPoint to be used in C#. 
        [Event_Description] AS EventDescription						-- Selecting the Event_Description column, aliasing it as EventDescription to be used in C#. 
    FROM [dbo].[ImportEmployee]										-- Retrieving records from the ImportEmployee table.
    WHERE CONVERT(TIME, [Date And Time]) >= @StartTime				-- Filtering records where the time portion of [Date and Time] is greater or equal to @StartTime.
    AND CONVERT(TIME, [Date And Time]) <= @EndTime					-- Filtering records where the time portion of [Date and Time] is less or equal to @EndTime.
    AND [Personnel_ID] IS NOT NULL									-- Filtering out rows where Personnel_ID column is not null.
    AND [Event_Description] IN ('Normal Open', 'Exit Button Open')	-- The records are filtered where the Event_Description is 'Normal Open' or 'Exit Button Open'.
    ORDER BY [Date And Time] ASC;									-- Sorting the records in ascending order by [Date and Time].
END
