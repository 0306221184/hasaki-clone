USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[CreateProduct]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateProduct]
    @name NVARCHAR(255),
    @description NVARCHAR(255) = NULL,
    @price DECIMAL,
    @discount_price DECIMAL,
    @quantity_in_stock INT = 0,
    @category_name NVARCHAR(255),
    @rating DECIMAL = 0,
    @image_url NVARCHAR(255) = NULL,
    @variants NVARCHAR(255) = NULL
AS
BEGIN
    DECLARE @category_id INT;
    DECLARE @productId INT
    -- Check if the category exists
    IF (SELECT COUNT(id) FROM categories WHERE name = @category_name) > 0
    BEGIN
        -- If category exists, get the category_id
        SELECT @category_id = id FROM categories WHERE name = @category_name;

        -- Insert product into the products table
        INSERT INTO products (name, description, price, discount_price, quantity_in_stock, category_id, rating, image_url, variants)
        VALUES (@name, @description, @price, @discount_price, @quantity_in_stock, @category_id, @rating, @image_url, @variants);
    END
    ELSE
    BEGIN
        -- If category doesn't exist, insert the new category and get the category_id
        INSERT INTO categories (name) VALUES (@category_name);
        SELECT @category_id = id FROM categories WHERE name = @category_name;

        -- Insert product into the products table
        INSERT INTO products (name, description, price, discount_price, quantity_in_stock, category_id, rating, image_url, variants)
        VALUES (@name, @description, @price, @discount_price, @quantity_in_stock, @category_id, @rating, @image_url, @variants);
    END

    -- Get the id of the last inserted product
    SET @productId = SCOPE_IDENTITY();

    -- Return the product information including the id of the newly created product
    SELECT * FROM products WHERE id = @productId;
END;


GO
