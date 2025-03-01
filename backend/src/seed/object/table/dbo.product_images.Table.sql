USE [hasaki_db]
GO
/****** Object:  Table [dbo].[product_images]    Script Date: 1/9/2025 8:19:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_images](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NULL,
	[image_url] [varchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[product_images]  WITH CHECK ADD  CONSTRAINT [fk_product_images_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[product_images] CHECK CONSTRAINT [fk_product_images_product]
GO
