USE [hasaki_db]
GO
/****** Object:  Table [dbo].[users]    Script Date: 1/9/2025 8:19:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](255) NULL,
	[email] [nvarchar](255) NOT NULL,
	[password] [nvarchar](max) NULL,
	[access_token] [nvarchar](max) NULL,
	[refresh_token] [nvarchar](max) NULL,
	[role_id] [int] NOT NULL,
	[avatar] [nvarchar](max) NULL,
	[full_name] [nvarchar](255) NULL,
	[phone_number] [nvarchar](50) NULL,
	[is_disabled] [bit] NOT NULL,
	[is_deleted] [bit] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
	[last_login] [datetime] NULL,
	[provider] [varchar](255) NULL,
	[provider_id] [varchar](255) NULL,
	[is_email_verified] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [is_disabled]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [is_deleted]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [is_email_verified]
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [fk_users_roles] FOREIGN KEY([role_id])
REFERENCES [dbo].[roles] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [fk_users_roles]
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [chk_password_or_provider] CHECK  (([password] IS NOT NULL AND [provider] IS NULL AND [provider_id] IS NULL OR [password] IS NULL AND [provider] IS NOT NULL AND [provider_id] IS NOT NULL))
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [chk_password_or_provider]
GO
