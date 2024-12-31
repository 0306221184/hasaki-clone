USE [hasaki_db]
GO
/****** Object:  Table [dbo].[blacklist_tokens]    Script Date: 12/31/2024 5:53:06 PM ******/
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
