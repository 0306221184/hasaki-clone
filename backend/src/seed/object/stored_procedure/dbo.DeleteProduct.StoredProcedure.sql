USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[DeleteProduct]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure to delete a user by ID
CREATE PROCEDURE [dbo].[DeleteProduct]
    @product_id INT
AS
BEGIN
	DELETE FROM product_images WHERE product_id = @product_id
    DELETE FROM products
    WHERE Id = @product_id;

    -- Optionally, you could return a status message or number of rows affected
    SELECT 'Product deleted successfully' AS Message;
END;









GO
