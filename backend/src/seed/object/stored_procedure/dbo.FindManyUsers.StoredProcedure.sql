USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[FindManyUsers]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindManyUsers]
    @id INT = NULL,                          -- User ID
    @username NVARCHAR(255) = NULL,           -- Username
    @email NVARCHAR(255) = NULL,              -- Email
    @password NVARCHAR(MAX) = NULL,           -- Password
    @access_token NVARCHAR(MAX) = NULL,       -- Access token
    @refresh_token NVARCHAR(MAX) = NULL,      -- Refresh token
    @role_id INT = NULL,                      -- Role ID
    @avatar NVARCHAR(MAX) = NULL,             -- Avatar
    @full_name NVARCHAR(255) = NULL,          -- Full name
    @phone_number NVARCHAR(50) = NULL,       -- Phone number
    @address NVARCHAR(MAX) = NULL,            -- Address
    @is_disabled BIT = NULL,                  -- Is disabled flag
    @is_deleted BIT = NULL,                   -- Is deleted flag
    @created_at DATETIME = NULL,              -- Created at
    @updated_at DATETIME = NULL,              -- Updated at
    @last_login DATETIME = NULL,              -- Last login
    @provider NVARCHAR(255) = NULL,           -- Provider
    @provider_id NVARCHAR(255) = NULL,        -- Provider ID
    @is_email_verified BIT = NULL,            -- Is email verified flag
    @column NVARCHAR(MAX) = '*',          -- Optional: column filter
	@top INT = NULL,
	@order_by VARCHAR(10) = 'DESC'
AS
BEGIN
    SET NOCOUNT ON;

    -- Declare SQL variable for dynamic query
    DECLARE @sql NVARCHAR(MAX)
    
    -- Create the dynamic SQL string with SELECT columns
	IF @top IS NOT NULL
		SET @sql = N'SELECT TOP @top @column';
	ELSE
		SET @sql = N'SELECT @column';
    SET @sql += N' FROM [dbo].[users] WHERE ' +
              N'(@id IS NULL OR [id] = @id) AND ' +
              N'(@username IS NULL OR [username] = @username) AND ' +
              N'(@email IS NULL OR [email] = @email) AND ' +
              N'(@password IS NULL OR [password] = @password) AND ' +
              N'(@access_token IS NULL OR [access_token] = @access_token) AND ' +
              N'(@refresh_token IS NULL OR [refresh_token] = @refresh_token) AND ' +
              N'(@role_id IS NULL OR [role_id] = @role_id) AND ' +
              N'(@avatar IS NULL OR [avatar] = @avatar) AND ' +
              N'(@full_name IS NULL OR [full_name] = @full_name) AND ' +
              N'(@phone_number IS NULL OR [phone_number] = @phone_number) AND ' +
              N'(@address IS NULL OR [address] = @address) AND ' +
              N'(@is_disabled IS NULL OR [is_disabled] = @is_disabled) AND ' +
              N'(@is_deleted IS NULL OR [is_deleted] = @is_deleted) AND ' +
              N'(@created_at IS NULL OR [created_at] = @created_at) AND ' +
              N'(@updated_at IS NULL OR [updated_at] = @updated_at) AND ' +
              N'(@last_login IS NULL OR [last_login] = @last_login) AND ' +
              N'(@provider IS NULL OR [provider] = @provider) AND ' +
              N'(@provider_id IS NULL OR [provider_id] = @provider_id) AND ' +
              N'(@is_email_verified IS NULL OR [is_email_verified] = @is_email_verified) ' +
              N'ORDER BY [created_at] @order_by;'

    -- Execute the dynamic SQL with the parameters
    EXEC sp_executesql @sql, 
        N'@id INT, @username NVARCHAR(255), @email NVARCHAR(255), @password NVARCHAR(MAX), 
          @access_token NVARCHAR(MAX), @refresh_token NVARCHAR(MAX), @role_id INT, @avatar NVARCHAR(MAX), 
          @full_name NVARCHAR(255), @phone_number NVARCHAR(50), @address NVARCHAR(MAX), @is_disabled BIT, 
          @is_deleted BIT, @created_at DATETIME, @updated_at DATETIME, @last_login DATETIME, @provider NVARCHAR(255), 
          @provider_id NVARCHAR(255), @is_email_verified BIT, @top INT, @column NVARCHAR(MAX), @order_by VARCHAR(10)', 
        @id, @username, @email, @password, @access_token, @refresh_token, @role_id, @avatar, @full_name, 
        @phone_number, @address, @is_disabled, @is_deleted, @created_at, @updated_at, @last_login, @provider, 
        @provider_id, @is_email_verified, @top, @column,@order_by;
END;


GO
