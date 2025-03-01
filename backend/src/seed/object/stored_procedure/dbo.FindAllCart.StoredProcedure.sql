USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindAllCart]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindAllCart]
    @id INT = NULL,
    @user_id INT = NULL,
    @created_at DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find all cart items with optional filters for each property
    SELECT *
    FROM [dbo].[carts]
    WHERE (@id IS NULL OR [id] = @id)
      AND (@user_id IS NULL OR [user_id] = @user_id)
      AND (@created_at IS NULL OR [created_at] = @created_at);
END;



GO
