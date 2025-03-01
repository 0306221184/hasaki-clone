USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindUniqueCategory]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueCategory]
    @id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find a unique category entry by `id`
    SELECT *
    FROM [dbo].[categories]
    WHERE [id] = @id;
END;



GO
