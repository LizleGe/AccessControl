USE [Optimi_College]
GO
/****** Object:  StoredProcedure [dbo].[AllEmployees]    Script Date: 16 Dec 2023 18:19:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[AllEmployees]-- The Stored Procedure name, AllEmployees.
AS
BEGIN
    -- =============================================
    -- Author:      <Author, Elizma le Grange>
    -- Create date: <Create Date: 2 December 2023>
    -- Description: <This is a Stored Procedure that will display all the employees working at Optimi College>
    -- =============================================

    SET NOCOUNT ON;							-- The NOCOUNT ON means that when the stored procedure is executed, it will not display the number of rows that are affected. This improves performance.

   
    SELECT DISTINCT							-- It means unique, it is used to prevent the selection of duplicate records. The selection is unique,distinct.
        [Personnel_ID] AS PersonnelID,		-- The unique Personnel ID is selected as PersonnelID. "PersonnelID will be used in C# to identify the stored procedure".
        [Card_Number] AS CardNumber			-- The unique Card Number of personnel is selected as CardNumber. "CardNumber will be used in C# to identify the stored procedure".
    FROM [dbo].[ImportEmployee]				-- Will be selected from the tabel name ImportEmployee.
    WHERE [Card_Number] IS NOT NULL			-- The records are filtered to give records where the card number is not a NULL.
    AND [Card_Number] <> 0					-- The records are filtered to give records where the card number is not equal to 0.
    AND [Personnel_ID] IS NOT NULL			-- The records are filtered to give records where the Personnel ID is not a NULL.
    AND [Personnel_ID] <> 0					-- The records are filtered to give records where the Personnel ID is not equal to 0.
	
	ORDER BY [PersonnelID] ASC;				-- The records are sorted via Personnel_ID in ascending order. 
END
