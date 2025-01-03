USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[SortDeleteUser]    Script Date: 1/3/2025 8:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SortDeleteUser]
    @user_id INT
AS
BEGIN
    UPDATE users SET is_deleted = 1 WHERE id = @user_id

    -- Optionally, you could return a status message or number of rows affected
    SELECT 'User sort deleted successfully' AS Message;
END;







GO
