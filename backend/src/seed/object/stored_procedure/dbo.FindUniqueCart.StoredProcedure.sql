USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindUniqueCart]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueCart]
    @id INT = NULL,
    @user_id INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Fetch a unique cart item either by id or user_id and product_id
    IF @id IS NOT NULL
    BEGIN
        SELECT *
        FROM [dbo].[carts]
        WHERE [id] = @id;
    END
    ELSE IF @user_id IS NOT NULL
    BEGIN
        SELECT *
        FROM [dbo].[carts]
        WHERE [user_id] = @user_id;
    END
    ELSE
    BEGIN
        SELECT 'Error: Please provide either an id or both user_id and product_id.';
    END
END;



GO
