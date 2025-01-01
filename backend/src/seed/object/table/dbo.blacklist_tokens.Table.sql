USE [hasaki_db]
GO
/****** Object:  Table [dbo].[blacklist_tokens]    Script Date: 1/1/2025 7:20:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[blacklist_tokens](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[token] [varchar](max) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
