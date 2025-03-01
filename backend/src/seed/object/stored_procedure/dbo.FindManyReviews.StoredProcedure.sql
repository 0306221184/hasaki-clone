USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindManyReviews]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindManyReviews]
    @product_id INT = NULL,
    @user_id INT = NULL,
    @rating INT = NULL,
    @review_text NVARCHAR(MAX) = NULL,
    @created_at DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query for finding multiple reviews based on various optional parameters
    SELECT *
    FROM [dbo].[reviews]
    WHERE (@product_id IS NULL OR [product_id] = @product_id)
      AND (@user_id IS NULL OR [user_id] = @user_id)
      AND (@rating IS NULL OR [rating] = @rating)
      AND (@review_text IS NULL OR [review_text] LIKE '%' + @review_text + '%')
      AND (@created_at IS NULL OR [created_at] = @created_at);
END;



GO
