USE [Optimi_College]
GO
/****** Object:  StoredProcedure [dbo].[ImportAndSortEmployeeRecords]    Script Date: 16 Dec 2023 18:22:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: Elizma le Grange>
-- Create date: <Create Date: 2 Desember 2023>
-- Description:	<This is a Stored Procedure that will sort all the records in the table, ImportEmployee in ascending order by using the Date and Time.>
-- =============================================
ALTER PROCEDURE [dbo].[ImportAndSortEmployeeRecords]
AS
BEGIN
									-- SET NOCOUNT ON added to prevent extra result sets from
									-- interfering with SELECT statements.
    SET NOCOUNT ON;

    
    SELECT *						-- All the records are selected from table ImportEmployee and sorted by the Date and Time in ascending order. 
    FROM ImportEmployee
    ORDER BY [Date And Time] DESC;	-- The records are sorted in ascending order by using the Date and Time.
END;
