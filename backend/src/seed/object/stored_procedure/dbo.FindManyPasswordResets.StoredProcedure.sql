USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindManyPasswordResets]    Script Date: 1/3/2025 8:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindManyPasswordResets]
    @email NVARCHAR(255) = NULL,
    @user_id INT = NULL,
    @created_at DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find multiple password reset entries based on the filtering parameters
    SELECT *
    FROM [dbo].[password_resets]
    WHERE (@email IS NULL OR [email] LIKE '%' + @email + '%')
      AND (@user_id IS NULL OR [user_id] = @user_id)
      AND (@created_at IS NULL OR [created_at] = @created_at);
END;



GO
