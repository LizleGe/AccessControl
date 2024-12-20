USE [Optimi_College]
GO
/****** Object:  StoredProcedure [dbo].[EmployeeInAndOut]    Script Date: 16 Dec 2023 18:20:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author: Elizma le Grange>
-- Create date: <Create Date: 2 Desmeber 2023>
-- Description:	<Shows Employees that go In and Out of the building.>
-- =============================================

ALTER PROCEDURE [dbo].[EmployeeInAndOut]			-- The Stored Procedure name, EmployeeInAndOut.
	
AS
BEGIN
													-- SET NOCOUNT ON added to prevent extra result sets from
													-- interfering with SELECT statements.
	SET NOCOUNT ON;									-- The NOCOUNT ON means that when the stored procedure is executed, it will not display the number of rows that are affected. This improves performance.

    SELECT  
		[Date And Time] AS DateAndTime,				-- The Date and Time column is selected and given an alias of DateAndTime, which will be used in C# to call this procedure.
		[Personnel_ID] AS PersonnelID,				-- The Personnel_ID column is selected and given an alias of PersonnelID, which will be used in C# to call this procedure.
		[Card_Number] AS CardNumber,				-- The Card_Number column is selected and given an alias of CardNumber, which will be used in C# to call this procedure.
		[Event_Point] AS EventPoint,				-- The Event_Point column is selected and given an alias of EventPoint, which will be used in C# to call this procedure.
		[Verify_Type] AS VerifyType,				-- The Verify_Type column is selected and given an alias of VerifyType, which will be used in C# to call this procedure.
		[In/Out_Status] AS In_OutStatus,			-- The In/Out_Status column is selected and given an alias of In_OutStatus, which will be used in C# to call this procedure.
		[Event_Description] AS EventDescription		-- The Event_Description column is selected and given an alias of EventDescription, which will be used in C# to call this procedure.
	FROM [Optimi_College].[dbo].[ImportEmployee]	-- The records are selected from the Optimi_College database and the table named ImportEmployee.
	WHERE [Event_Description] = 'Normal Open'		-- The records are filtered where the Event_Description is 'normal open'.
		OR [Event_Description] = 'Exit Button Open' -- The records are filtered where the Event_Description is 'Exit Button Open'.
		OR [Event_Description] = 'Disconnected'		-- The records are filtered where the Event_Description is 'Disconnected'.
	ORDER BY [Date And Time] ASC;					-- The records are sorted in ascending order by using the Date and Time.
	
END
