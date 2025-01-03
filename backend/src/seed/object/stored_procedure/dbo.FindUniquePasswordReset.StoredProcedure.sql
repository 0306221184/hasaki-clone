USE [project]
GO
/****** Object:  StoredProcedure [dbo].[FindUniquePasswordReset]    Script Date: 12/29/2024 4:01:00 PM ******/
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
