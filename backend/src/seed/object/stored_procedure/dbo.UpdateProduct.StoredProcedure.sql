USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[UpdateProduct]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateProduct]
    @product_id INT,
    @name NVARCHAR(255) = null,
	@description NVARCHAR(255) = NULL,
	@price DECIMAL = null,
	@discount_price DECIMAL = null,
	@sku NVARCHAR(255) = NULL,
	@quantity_in_stock INT = null,
	@category_name NVARCHAR(255)=null,
	@rating DECIMAL=null,
	@image_url NVARCHAR(255) = NULL,
	@variants NVARCHAR(255) = NULL,
	@tags NVARCHAR(255) = NULL,
    @toggle_active bit = 0
AS
BEGIN
    DECLARE @sql nvarchar(max);
    DECLARE @category_id INT;
	 -- Initialize the SQL string
    SET @sql = 'UPDATE products SET';
    -- Check if the category exists
    IF (SELECT COUNT(id) FROM categories WHERE name = @category_name) > 0
    BEGIN
        -- If category exists, get the category_id
        SELECT @category_id = id FROM categories WHERE name = @category_name;
    END
    ELSE
    BEGIN
        -- If category doesn't exist, insert the new category and get the category_id
        INSERT INTO categories (name) VALUES (@category_name);
        SELECT @category_id = id FROM categories WHERE name = @category_name;
    END
	-- Conditionally append column updates based on parameters
    SET @sql = @sql + ' updated_at = GETDATE(),';
	IF @name is not null
        SET @sql = @sql + ' name = @name,';
	IF @description is not null
        SET @sql = @sql + ' description = @description,';
	IF @price is not null
		SET @sql = @sql + ' price = @price,';
	IF @discount_price is not null
		SET @sql = @sql + ' discount_price = @discount_price,';
	IF @sku is not null
        SET @sql = @sql + ' sku = @sku,';
	IF @quantity_in_stock is not null
        SET @sql = @sql + ' quantity_in_stock = @quantity_in_stock,';
	IF @category_name is not null
        SET @sql = @sql + ' category_id = @category_id,';
	IF @rating is not null
        SET @sql = @sql + ' rating = @rating,';
	IF @image_url is not null
        SET @sql = @sql + ' image_url = @image_url,';
	IF @variants is not null
        SET @sql = @sql + ' variants = @variants,';
	IF @tags is not null
        SET @sql = @sql + ' tags = @tags,';
        IF @toggle_active = 1
        SET @sql = @sql + ' is_active = is_active ^ 1,';
	 -- Remove the trailing comma
    SET @sql = LEFT(@sql, LEN(@sql) - 1);

    -- Add WHERE clause
    SET @sql = @sql + ' WHERE id = @product_id';

	-- Execute the dynamic SQL
	EXEC sp_executesql @sql,N' @product_id INT, @name NVARCHAR(255), @description NVARCHAR(255), @price DECIMAL, @discount_price DECIMAL, @sku NVARCHAR(255), @quantity_in_stock INT, @category_id int, @rating DECIMAL, @image_url NVARCHAR(255), @variants NVARCHAR(255), @tags NVARCHAR(255)
'                               , @product_id, @name, @description, @price, @discount_price, @sku, @quantity_in_stock, @category_id, @rating, @image_url, @variants, @tags;

-- Return the updated user
    SELECT * FROM products WHERE id = @product_id;
END;




GO
