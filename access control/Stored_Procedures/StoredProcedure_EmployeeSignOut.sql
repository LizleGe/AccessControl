USE [Optimi_College]
GO
/****** Object:  StoredProcedure [dbo].[EmployeeSignOut]    Script Date: 16 Dec 2023 18:21:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: Elizma le Grange>
-- Create date: <Create Date: 2 Desember 2023>
-- Description:	<Description: This Stored Procedure shows all the employees that sign out.>
-- =============================================
ALTER PROCEDURE [dbo].[EmployeeSignOut]									-- The Stored Procedure name, EmployeeSignOut.
																		-- Below all the named columns are selected from table, ImportEmployee, where the records match the Event_Description, 'normal open' or 'Exit Button Open'
																		-- and sorted in ascending order by using the Date and Time.
AS
BEGIN
	SET NOCOUNT ON;
											
    SELECT
        [Date And Time] AS DateAndTime,									-- The Date And Time column is selected and given an alias of DateAndTime, which will be used in C# to call this procedure.
        [Personnel_ID] AS PersonnelID,									-- The Personnel_ID column is selected and given an alias of PersonnelID, which will be used in C# to call this procedure.    
        [Device_Name] AS DeviceName,									-- The Device_Name column is selected and given an alias of DeviceName, which will be used in C# to call this procedure.
        [Event_Point] AS EventPoint,									-- The Event_Point column is selected and given an alias of EventPoint, which will be used in C# to call this procedure.
        [Verify_Type] AS VerifyType,									-- The Verify_Type column is selected and given an alias of VerifyType, which will be used in C# to call this procedure.
        [Event_Description] AS EventDescription							-- The Event_Description column is selected and given an alias of EventDescription, which will be used in C# to call this procedure.
    FROM [dbo].[ImportEmployee]											-- The records are selected from the table named Import Employee.
    WHERE [Event_Description] IN ('Disconnected', 'Exit Button Open')	-- The records are filtered where the Event_Description is 'normal open' or 'Exit Button Open'.
      
    ORDER BY [Date And Time] ASC;										-- The records are sorted in ascending order by using the Date and Time.
   
END
