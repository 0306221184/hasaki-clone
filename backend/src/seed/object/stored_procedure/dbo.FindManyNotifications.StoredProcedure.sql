USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindManyNotifications]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindManyNotifications]
    @user_id INT = NULL,
    @is_read BIT = NULL,
	@created_at DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find multiple notification entries based on optional filters
    SELECT *
    FROM [dbo].[notifications]
    WHERE (@user_id IS NULL OR [user_id] = @user_id)
      AND (@is_read IS NULL OR [is_read] = @is_read)
      AND (@created_at IS NULL OR created_at = @created_at);
END;



GO
