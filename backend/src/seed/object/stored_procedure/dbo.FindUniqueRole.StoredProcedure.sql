USE [project]
GO
/****** Object:  StoredProcedure [dbo].[FindUniqueRole]    Script Date: 12/29/2024 4:01:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueRole]
    @role_id INT = NULL,
    @role_name NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query for finding a unique role based on role_id or role_name
    SELECT TOP 1 *
    FROM [dbo].[roles]
    WHERE (@role_id IS NULL OR [id] = @role_id)
      AND (@role_name IS NULL OR [name] = @role_name)
END;



GO
