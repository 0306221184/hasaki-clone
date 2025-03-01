USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindUniqueProduct]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueProduct]
    @id INT = NULL,                          -- Optional: product ID filter
    @sku NVARCHAR(100) = NULL,                -- Optional: SKU filter
    @column NVARCHAR(MAX) = '*'               -- Optional: dynamic column selection
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @sql NVARCHAR(MAX)

    -- Building the dynamic SQL query to select the columns based on @column input
    SET @sql = N'SELECT TOP 1 ' + @column + N' FROM [dbo].[products] WHERE (@id IS NULL OR [id] = @id) AND (@sku IS NULL OR [sku] = @sku);'

    -- Executing the dynamic SQL with the parameters passed
    EXEC sp_executesql @sql, N'@id INT, @sku NVARCHAR(100)', @id, @sku;
END;



GO
