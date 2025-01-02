USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindUniqueNotification]    Script Date: 1/2/2025 4:27:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueNotification]
    @id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find a unique notification entry by `id`
    SELECT *
    FROM [dbo].[notifications]
    WHERE [id] = @id;
END;



GO
