USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindManyOrders]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindManyOrders]
    @user_id INT = NULL,
    @order_status NVARCHAR(50) = NULL,
    @created_at DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find multiple order entries based on the filtering parameters
    SELECT *
    FROM [dbo].[orders]
    WHERE (@user_id IS NULL OR [user_id] = @user_id)
      AND (@order_status IS NULL OR [order_status] LIKE '%' + @order_status + '%')
      AND (@created_at IS NULL OR [created_at] = @created_at);
END;



GO
