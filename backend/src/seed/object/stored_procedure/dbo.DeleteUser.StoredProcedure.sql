USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure to delete a user by ID
CREATE PROCEDURE [dbo].[DeleteUser]
    @user_id INT
AS
BEGIN
    DELETE FROM Users
    WHERE Id = @user_id;

    -- Optionally, you could return a status message or number of rows affected
    SELECT 'User deleted successfully' AS Message;
END;








GO
