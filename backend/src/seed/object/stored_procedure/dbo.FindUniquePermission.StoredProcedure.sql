USE [project]
GO
/****** Object:  StoredProcedure [dbo].[FindUniquePermission]    Script Date: 12/29/2024 4:01:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniquePermission]
    @id INT = NULL,
    @name NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find a unique permission based on either `id` or `name`
    SELECT *
    FROM [dbo].[permissions]
    WHERE (@id IS NOT NULL AND [id] = @id)
       OR (@name IS NOT NULL AND [name] = @name);
END;



GO
