USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindManyOrderDetails]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindManyOrderDetails]
    @order_id INT = NULL,
    @product_id INT = NULL,
    @quantity INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find multiple order detail entries based on the filtering parameters
    SELECT *
    FROM [dbo].[order_details]
    WHERE (@order_id IS NULL OR [order_id] = @order_id)
      AND (@product_id IS NULL OR [product_id] = @product_id)
      AND (@quantity IS NULL OR quantity = @quantity);
END;



GO
