USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindAllAppliedPromotions]    Script Date: 1/3/2025 8:03:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindAllAppliedPromotions]
    @id INT = NULL,
    @order_id INT = NULL,
    @promo_id INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find all applied promotions with optional filters for each property
    SELECT *
    FROM [dbo].[applied_promotions]
    WHERE (@id IS NULL OR [id] = @id)
      AND (@order_id IS NULL OR [order_id] = @order_id)
      AND (@promo_id IS NULL OR [promo_id] = @promo_id);
END;



GO
