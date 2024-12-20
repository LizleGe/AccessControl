USE [Optimi_College]
GO
/****** Object:  StoredProcedure [dbo].[ErrorRecords]    Script Date: 16 Dec 2023 18:22:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Elizma
-- Create date: 2 December 2023
-- Description: This is a stored procedure which shows all the error records within the table, ImportEmployee. 
--				All the named columns below are selected from table, ImportEmployee. In the event that the  
--				records match the Event_Description, 'Person Not Registered' or 'Validate Interval Too Short'
--				it will be seen as an error record.
-- =============================================
ALTER PROCEDURE [dbo].[ErrorRecords]							-- The Stored Procedure name, ErrorRecords. 
																
AS
BEGIN
																-- SET NOCOUNT ON added to prevent extra result sets from
																-- interfering with SELECT statements.
    SET NOCOUNT ON;
  
    SELECT
        [Date And Time] AS DateAndTime,							-- The Date And Time column is selected and given an alias of DateAndTime, which will be used in C# to call this procedure.
        [Device_Name] AS DeviceName,							-- The Device_Name column is selected and given an alias of DeviceName, which will be used in C# to call this procedure.
        [Event_Point] AS EventPoint,							-- The Event_Point column is selected and given an alias of EventPoint, which will be used in C# to call this procedure.
        [Verify_Type] AS VerifyType,							-- The Verify_Type column is selected and given an alias of VerifyType, which will be used in C# to call this procedure.
        [In/Out_Status] AS InOutStatus,							-- The In/Out_Status column is selected and given an alias of InOutStatus, which will be used in C# to call this procedure.
        [Event_Description] AS EventDescription					-- The Event_Description column is selected and given an alias of EventDescription, 
																-- which will be used in C# to call this procedure.

    FROM [dbo].[ImportEmployee]									-- The records are selected from the table named Import Employee.
    
	WHERE [Event_Description] IN ('Person Not Registered',		
								'Validate Interval Too Short')	-- The records are filtered where the Event_Description is 'Person Not Registered' or 'Validate Interval Too Short'.
																 	
    ORDER BY [Date And Time] ASC;								-- The records are sorted in ascending order by using the Date and Time.
   
END
