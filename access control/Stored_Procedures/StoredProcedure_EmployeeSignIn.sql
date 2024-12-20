USE [Optimi_College]
GO
/****** Object:  StoredProcedure [dbo].[EmployeeSignIn]    Script Date: 16 Dec 2023 18:21:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: Elizma le Grange>
-- Create date: <Create Date: 2 Desemeber 2023>
-- Description:	<This Stored Procedure shows all the employees that signed in.>
-- =============================================
ALTER PROCEDURE [dbo].[EmployeeSignIn]				-- The Stored Procedure name, EmployeeSignIn.
	
AS
BEGIN
													-- SET NOCOUNT ON added to prevent extra result sets from
													-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT
        [Date And Time] AS DateAndTime,				-- The Date And Time column is selected and given an alias of DateAndTime, which will be used in C# to call this procedure.
        [Personnel_ID] AS PersonnelID,				-- The Personnel_ID column is selected and given an alias of PersonnelID, which will be used in C# to call this procedure.
        [Card_Number] AS CardNumber,				-- The Card_Number column is selected and given an alias of CardNumber, which will be used in C# to call this procedure.
        [Event_Point] AS EventPoint,				-- The Event_Point column is selected and given an alias of EventPoint, which will be used in C# to call this procedure.
        [Event_Description] AS EventDescription		-- The Event_Description column is selected and given an alias of EventDescription, which will be used in C# to call this procedure.
    FROM [dbo].[ImportEmployee]						-- The records are selected from the table named Import Employee.
    WHERE [Event_Description] = 'normal open'		-- The records are filtered where the Event_Description is 'normal open'.
    ORDER BY [Date And Time] ASC;					-- The records are sorted in ascending order by using the Date and Time.

END
