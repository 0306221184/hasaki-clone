USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindManyProducts]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindManyProducts]
    @name NVARCHAR(255) = NULL,
    @category_id INT = NULL,
    @is_active BIT = NULL,
    @min_price DECIMAL(10, 2) = NULL,
    @max_price DECIMAL(10, 2) = NULL,
    @min_quantity_in_stock INT = NULL,
    @rating DECIMAL(2, 1) = NULL,
    @column NVARCHAR(MAX) = '*',
    @top INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Initialize the base query
    DECLARE @sql NVARCHAR(MAX) = N'SELECT ';

    -- Add TOP clause if specified
    IF @top IS NOT NULL
        SET @sql += N'TOP (' + CAST(@top AS NVARCHAR) + N') ';

    -- Add column selection
    SET @sql += @column + N' FROM [dbo].[products] WHERE 1 = 1';

    -- Add optional filters
    IF @name IS NOT NULL
        SET @sql += N' AND [name] LIKE ''%' + REPLACE(@name, '''', '''''') + N'%''';
    IF @category_id IS NOT NULL
        SET @sql += N' AND [category_id] = @category_id';
    IF @is_active IS NOT NULL
        SET @sql += N' AND [is_active] = @is_active';
    IF @min_price IS NOT NULL
        SET @sql += N' AND [price] >= @min_price';
    IF @max_price IS NOT NULL
        SET @sql += N' AND [price] <= @max_price';
    IF @min_quantity_in_stock IS NOT NULL
        SET @sql += N' AND [quantity_in_stock] >= @min_quantity_in_stock';
    IF @rating IS NOT NULL
        SET @sql += N' AND [rating] = @rating';
    -- Execute the dynamic SQL
    EXEC sp_executesql 
        @sql,
        N'@category_id INT, @is_active BIT, @min_price DECIMAL(10,2), 
          @max_price DECIMAL(10,2), @min_quantity_in_stock INT, @rating DECIMAL(2,1)',
        @category_id, @is_active, @min_price, @max_price, @min_quantity_in_stock, @rating;
END;
GO
