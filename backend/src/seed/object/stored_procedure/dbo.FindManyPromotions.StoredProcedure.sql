USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindManyPromotions]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindManyPromotions]
    @code NVARCHAR(50) = NULL,
    @discount_percentage DECIMAL(5, 2) = NULL,
    @start_date DATE = NULL,
    @end_date DATE = NULL,
    @is_active BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find multiple promotions based on the filtering parameters
    SELECT *
    FROM [dbo].[promotions]
    WHERE (@code IS NULL OR [code] = @code)
      AND (@discount_percentage IS NULL OR [discount_percentage] = @discount_percentage)
      AND (@start_date IS NULL OR [start_date] = @start_date)
      AND (@end_date IS NULL OR [end_date] = @end_date)
      AND (@is_active IS NULL OR [is_active] = @is_active);
END;



GO
