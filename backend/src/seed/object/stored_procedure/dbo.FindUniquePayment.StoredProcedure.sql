USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindUniquePayment]    Script Date: 12/31/2024 5:53:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniquePayment]
    @id INT = NULL,
    @order_id INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find a unique payment based on either `id` or `order_id`
    SELECT *
    FROM [dbo].[payments]
    WHERE (@id IS NOT NULL AND [id] = @id)
       OR (@order_id IS NOT NULL AND [order_id] = @order_id);
END;



GO
