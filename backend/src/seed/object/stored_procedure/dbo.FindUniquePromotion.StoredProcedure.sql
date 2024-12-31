USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindUniquePromotion]    Script Date: 12/31/2024 5:53:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniquePromotion]
    @id INT = NULL,
    @code NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find a unique promotion based on either `id` or `code`
    SELECT *
    FROM [dbo].[promotions]
    WHERE (@id IS NOT NULL AND [id] = @id)
       OR (@code IS NOT NULL AND [code] = @code);
END;



GO
