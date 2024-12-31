USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindUniqueCategory]    Script Date: 12/31/2024 5:53:24 PM ******/
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
