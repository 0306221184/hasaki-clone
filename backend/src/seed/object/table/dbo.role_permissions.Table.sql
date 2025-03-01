USE [hasaki_db]
GO
/****** Object:  Table [dbo].[role_permissions]    Script Date: 1/9/2025 8:19:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[role_permissions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [int] NOT NULL,
	[permission_id] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [uq_role_permission] UNIQUE NONCLUSTERED 
(
	[role_id] ASC,
	[permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[role_permissions] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[role_permissions] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[role_permissions]  WITH CHECK ADD  CONSTRAINT [fk_role_permissions_permissions] FOREIGN KEY([permission_id])
REFERENCES [dbo].[permissions] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[role_permissions] CHECK CONSTRAINT [fk_role_permissions_permissions]
GO
ALTER TABLE [dbo].[role_permissions]  WITH CHECK ADD  CONSTRAINT [fk_role_permissions_roles] FOREIGN KEY([role_id])
REFERENCES [dbo].[roles] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[role_permissions] CHECK CONSTRAINT [fk_role_permissions_roles]
GO
