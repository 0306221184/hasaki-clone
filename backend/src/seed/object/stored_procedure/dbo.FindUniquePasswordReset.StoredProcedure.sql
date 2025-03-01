USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindUniquePasswordReset]    Script Date: 1/3/2025 8:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniquePasswordReset]
    @id INT = NULL,
    @email NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find a unique password reset entry based on either `id` or `email`
    SELECT *
    FROM [dbo].[password_resets]
    WHERE (@id IS NOT NULL AND [id] = @id)
       OR (@email IS NOT NULL AND [email] = @email);
END;



GO
