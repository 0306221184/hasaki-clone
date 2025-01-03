USE [project]
GO
/****** Object:  StoredProcedure [dbo].[FindAllCategories]    Script Date: 12/29/2024 4:01:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindAllCategories]
    @id INT = NULL,
    @name NVARCHAR(255) = NULL,
    @parent_id INT = NULL,
    @is_active BIT = NULL,
    @language_code NVARCHAR(10) = NULL,
    @created_at DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find multiple categories with optional filters for each property
    SELECT *
    FROM [dbo].[categories]
    WHERE (@id IS NULL OR [id] = @id)
      AND (@name IS NULL OR [name] LIKE '%' + @name + '%')
      AND (@parent_id IS NULL OR [parent_id] = @parent_id)
      AND (@is_active IS NULL OR [is_active] = @is_active)
      AND (@language_code IS NULL OR [language_code] = @language_code)
      AND (@created_at IS NULL OR [created_at] = @created_at)
END;



GO
