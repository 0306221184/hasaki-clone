USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindManyPermissionsByRoleId]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FindManyPermissionsByRoleId]
    @role_id INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT [dbo].[permissions].*
    FROM [dbo].[role_permissions] INNER JOIN [dbo].[permissions] ON [dbo].[permissions].id = [dbo].[role_permissions].permission_id
    WHERE [dbo].[role_permissions].role_id = @role_id
END;




GO
