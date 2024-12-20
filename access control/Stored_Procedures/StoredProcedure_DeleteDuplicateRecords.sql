USE [Optimi_College]
GO
/****** Object:  StoredProcedure [dbo].[DeleteDuplicateRecords]    Script Date: 16 Dec 2023 18:19:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: Elizma le Grange>
-- Create date: <Create Date: 2 Desember 2023>
-- Description:	<This is a stored procedure to delete all the duplicate records once the user import the excel file into the Optimi_college database.>
-- =============================================
ALTER PROCEDURE [dbo].[DeleteDuplicateRecords] -- The Stored Procedure name, DeleteDuplicateRecords.
	
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	SET NOCOUNT ON;

	-- Below each row of the table, ImportEmployees are checked that contains data in different columns.-- 
	-- A unique number is given to each row, by using the ROW_NUMBER() function.
	-- Each selected column is checked to see if there is duplicates or not. 
	-- If a row has the same information across al the columns it will be given the same row number.
	-- Therefore, after the Row as a number assigned, and there is more than 1 row with the same number, it will be seen as a duplicate and remove it.

     WITH [Optimi_College] AS (		-- Selects from Optimi_College database.
        SELECT 
            *,
            ROW_NUMBER() OVER (							-- A unique number is given to each row, by using the ROW_NUMBER() function.
                PARTITION BY							-- Partition BY means dividing. 
				[Date And Time]							-- The columns names of table, ImportEmployees that will be partitioned. 
				,[Personnel_ID]
				,[Card_Number]
				,[Device_Name]
				,[Event_Point]
				,[Verify_Type]
				,[In/Out_Status]
				,[Event_Description]
				,[Remarks]
                ORDER BY (SELECT NULL)) AS RowNumber	-- The rows are counted and given a name named RowNumber.
        FROM 
           [dbo].[ImportEmployee]						-- Selected from table, ImportEmployee
    )
    DELETE FROM [Optimi_College] WHERE RowNumber > 1;	-- If there is a RowNumber greater than 1, it is a duplicate and will be deleted from the Database, Optimi_College.
END
