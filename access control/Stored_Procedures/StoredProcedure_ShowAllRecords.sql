USE [Optimi_College]
GO
/****** Object:  StoredProcedure [dbo].[ShowAllRecords]    Script Date: 16 Dec 2023 18:23:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        <Author: Elizma le Grange>
-- Create date:   <Create Date: 2 Desember 2023>
-- Description:   <Description: This is a Stored Procedure to show all the records from the table, ImportEmployee>
-- =============================================
ALTER PROCEDURE [dbo].[ShowAllRecords]
AS
BEGIN
    
    SELECT 
        [Date And Time] AS DateAndTime,				-- The Date And Time column is selected and given an alias of DateAndTime, which will be used in C# to call this procedure.
        [Personnel_ID] AS PersonnelID,				-- The Personnel_ID column is selected and given an alias of PersonnelID, which will be used in C# to call this procedure.
        [Card_Number] AS CardNumber,				-- The Card_Number column is selected and given an alias of CardNumber, which will be used in C# to call this procedure.
        [Device_Name] AS DeviceName,				-- The Device_Name column is selected and given an alias of DeviceName, which will be used in C# to call this procedure.
        [Event_Point] AS EventPoint,				-- The Event_Point column is selected and given an alias of EventPoint, which will be used in C# to call this procedure.
        [Verify_Type] AS VerifyType,				-- The Verify_Type column is selected and given an alias of VerifyType, which will be used in C# to call this procedure.
        [In/Out_Status] AS InOutStatus,				-- The In/Out_Status column is selected and given an alias of EventDescription, which will be used in C# to call this procedure.
        [Event_Description] AS EventDescription,	-- The Event_Description column is selected and given an alias of EventDescription, which will be used in C# to call this procedure.
		[Remarks] AS Remarks						-- The Remarks column is selected and given an alias of Remarks, which will be used in C# to call this procedure.
        
    FROM [dbo].[ImportEmployee]						-- It is selected from the table ImportEmployee
    
    ORDER BY [Date And Time] ASC;					-- The records are sorted in ascending order by using the Date and Time.
   
END
