USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindManyRolePermissions]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindManyRolePermissions]
	@id INT = NULL,
    @role_id INT = NULL,
    @permission_id INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM [dbo].[role_permissions]
    WHERE (@role_id IS NULL OR [role_id] = @role_id)
      AND (@permission_id IS NULL OR [permission_id] = @permission_id)
      AND (@id IS NULL OR [id] = @id);
END;



GO
