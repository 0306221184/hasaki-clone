USE [project]
GO
/****** Object:  StoredProcedure [dbo].[FindUniqueOrderDetail]    Script Date: 12/29/2024 4:01:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueOrderDetail]
    @id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find a unique order detail entry based on either `id`, `order_id` or `product_id`
    SELECT *
    FROM [dbo].[order_details]
    WHERE id=@id
END;



GO
