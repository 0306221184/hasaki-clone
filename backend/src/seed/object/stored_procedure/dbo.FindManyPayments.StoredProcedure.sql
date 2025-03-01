USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindManyPayments]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindManyPayments]
    @order_id INT = NULL,
    @payment_method NVARCHAR(50) = NULL,
    @payment_status NVARCHAR(50) = NULL,
    @created_at DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find multiple payments based on the filtering parameters
    SELECT *
    FROM [dbo].[payments]
    WHERE (@order_id IS NULL OR [order_id] = @order_id)
      AND (@payment_method IS NULL OR [payment_method] LIKE '%' + @payment_method + '%')
      AND (@payment_status IS NULL OR [payment_status] LIKE '%' + @payment_status + '%')
      AND (@created_at IS NULL OR [created_at] = @created_at);
END;



GO
