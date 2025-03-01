USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindUniqueOrder]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueOrder]
    @id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find a unique order entry based on either `id` or `user_id`
    SELECT *
    FROM [dbo].[orders]
    WHERE id = @id
END;



GO
