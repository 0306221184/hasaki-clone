USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindUniqueUser]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueUser]
    @username NVARCHAR(255) = NULL,          -- Optional: username filter
    @email NVARCHAR(255) = NULL,             -- Optional: email filter
    @id INT = NULL      ,
	@column nvarchar(max) = '*'                     -- Optional: user ID filter
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @sql NVARCHAR(MAX)
	SET @sql = N'SELECT TOP 1 '+ @column + N' FROM [dbo].[users] WHERE (@username IS NULL OR [username] = @username) AND (@email IS NULL OR [email] = @email) AND (@id IS NULL OR [id] = @id) ORDER BY [created_at] DESC;'
    EXEC sp_executesql @sql , N'@username nvarchar(255), @email nvarchar(255), @id int',@username,@email,@id;
END;


GO
