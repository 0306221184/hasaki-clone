USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindManyRolesByPermissionId]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FindManyRolesByPermissionId]
    @permission_id INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT [dbo].[roles].*
    FROM [dbo].[role_permissions] INNER JOIN [dbo].[roles] ON [dbo].[roles].id = [dbo].[role_permissions].role_id
    WHERE [dbo].[role_permissions].permission_id = @permission_id
END;




GO
