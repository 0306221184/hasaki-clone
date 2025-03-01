USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindUniqueReview]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueReview]
    @product_id INT,
    @user_id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Query for finding a unique review based on product_id and user_id
    SELECT TOP 1 *
    FROM [dbo].[reviews]
    WHERE [product_id] = @product_id
      AND [user_id] = @user_id
END;



GO
