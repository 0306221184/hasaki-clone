USE [hasaki_db]
GO
/****** Object:  StoredProcedure [dbo].[UpdateUser]    Script Date: 1/9/2025 8:19:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateUser]
    @user_id INT,
    @username NVARCHAR(255) = NULL, -- NULL for social login users
    @password NVARCHAR(MAX) = NULL, -- NULL for social login users
    @access_token NVARCHAR(MAX) = NULL,
    @refresh_token NVARCHAR(MAX) = NULL,
    @role_name VARCHAR(255) = NULL,
    @avatar NVARCHAR(MAX) = NULL,
    @full_name NVARCHAR(255) = NULL,
    @phone_number NVARCHAR(50) = NULL,
    @address NVARCHAR(MAX) = NULL,
    @provider VARCHAR(255) = NULL, -- NULL for local users
    @provider_id VARCHAR(255) = NULL, -- Unique ID from provider (NULL for local users)
    @last_login BIT = 0,
    @is_email_verified BIT = NULL,
    @toggle_disabled BIT = 0,
    @toggle_deleted BIT = 0,
    @set_access_token_to_null BIT = 0, -- Explicit flag to set access_token to NULL
    @set_refresh_token_to_null BIT = 0 -- Explicit flag to set refresh_token to NULL
AS
BEGIN
    DECLARE @role_id INT, @sql NVARCHAR(MAX);

    -- Fetch role_id based on role_name
    IF @role_name IS NOT NULL
    BEGIN
        IF (SELECT COUNT(id) FROM roles WHERE name = @role_name) > 0
            SELECT @role_id = Id FROM Roles WHERE Name = @role_name;
        ELSE
        BEGIN
            INSERT INTO roles(name) VALUES (@role_name);
            SELECT @role_id = Id FROM Roles WHERE Name = @role_name;
        END
    END

    -- Initialize the SQL string
    SET @sql = 'UPDATE users SET';

    -- Conditionally append column updates based on parameters
    SET @sql = @sql + ' updated_at = GETDATE(),';

    IF @last_login = 1
        SET @sql = @sql + ' last_login = GETDATE(),';

    IF @username IS NOT NULL
        SET @sql = @sql + ' username = @username,';
    
    IF @password IS NOT NULL
        SET @sql = @sql + ' password = @password,';

    -- Explicitly set access_token to NULL if the flag is set
    IF @set_access_token_to_null = 1
        SET @sql = @sql + ' access_token = NULL,';
    ELSE IF @access_token IS NOT NULL
        SET @sql = @sql + ' access_token = @access_token,';

    -- Explicitly set refresh_token to NULL if the flag is set
    IF @set_refresh_token_to_null = 1
        SET @sql = @sql + ' refresh_token = NULL,';
    ELSE IF @refresh_token IS NOT NULL
        SET @sql = @sql + ' refresh_token = @refresh_token,';

    IF @role_id IS NOT NULL
        SET @sql = @sql + ' role_id = @role_id,';

    IF @avatar IS NOT NULL
        SET @sql = @sql + ' avatar = @avatar,';

    IF @full_name IS NOT NULL
        SET @sql = @sql + ' full_name = @full_name,';

    IF @phone_number IS NOT NULL
        SET @sql = @sql + ' phone_number = @phone_number,';

    IF @address IS NOT NULL
        SET @sql = @sql + ' address = @address,';

    IF @provider IS NOT NULL
        SET @sql = @sql + ' provider = @provider,';

    IF @provider_id IS NOT NULL
        SET @sql = @sql + ' provider_id = @provider_id,';
	IF @is_email_verified IS NOT NULL
        SET @sql = @sql + ' is_email_verified = @is_email_verified,';
	IF @toggle_disabled = 1
        SET @sql = @sql + ' is_disabled = is_disabled ^ 1,';
	IF @toggle_deleted = 1
        SET @sql = @sql + ' is_deleted = is_deleted ^ 1,';
    -- Remove the trailing comma
    SET @sql = LEFT(@sql, LEN(@sql) - 1);

    -- Add WHERE clause
    SET @sql = @sql + ' WHERE id = @user_id';

    -- Execute the dynamic SQL
    EXEC sp_executesql @sql, 
        N'@username NVARCHAR(255), @password NVARCHAR(MAX), @access_token NVARCHAR(MAX), 
        @refresh_token NVARCHAR(MAX), @role_id INT, @avatar NVARCHAR(MAX), 
        @full_name NVARCHAR(255), @phone_number NVARCHAR(50), @address NVARCHAR(MAX), 
        @provider VARCHAR(255), @provider_id VARCHAR(255), @is_email_verified BIT, @user_id INT', 
        @username, @password, @access_token, @refresh_token, @role_id, @avatar, 
        @full_name, @phone_number, @address, @provider, @provider_id, @is_email_verified, @user_id;

    -- Return the updated user
    SELECT * FROM Users WHERE id = @user_id;
END;




GO
