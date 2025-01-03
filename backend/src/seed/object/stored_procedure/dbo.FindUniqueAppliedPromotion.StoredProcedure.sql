USE [project]
GO
/****** Object:  StoredProcedure [dbo].[FindUniqueAppliedPromotion]    Script Date: 12/29/2024 4:01:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueAppliedPromotion]
    @id INT = NULL,
    @order_id INT = NULL,
    @promo_id INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Fetch a unique applied promotion either by id or order_id and promo_id
    IF @id IS NOT NULL
    BEGIN
        SELECT *
        FROM [dbo].[applied_promotions]
        WHERE [id] = @id;
    END
    ELSE IF @order_id IS NOT NULL AND @promo_id IS NOT NULL
    BEGIN
        SELECT *
        FROM [dbo].[applied_promotions]
        WHERE [order_id] = @order_id AND [promo_id] = @promo_id;
    END
    ELSE
    BEGIN
        SELECT 'Error: Please provide either an id or both order_id and promo_id.';
    END
END;



GO
