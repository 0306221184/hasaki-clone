USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindUniqueWishList]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueWishList]
    @wishlist_id INT = NULL,
    @user_id INT = NULL,
    @product_id INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query for finding a unique wish list entry based on wishlist_id, user_id or product_id
    SELECT TOP 1 *
    FROM [dbo].[wish_lists]
    WHERE (@wishlist_id IS NULL OR id = @wishlist_id)
      AND (@user_id IS NULL OR [user_id] = @user_id)
      AND (@product_id IS NULL OR [product_id] = @product_id)
END;



GO
