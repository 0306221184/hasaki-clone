USE [hasaki_db]
GO
/****** Object:  Table [dbo].[applied_promotions]    Script Date: 1/2/2025 4:27:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[applied_promotions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NOT NULL,
	[promo_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[applied_promotions]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([id])
GO
ALTER TABLE [dbo].[applied_promotions]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([id])
GO
ALTER TABLE [dbo].[applied_promotions]  WITH CHECK ADD FOREIGN KEY([promo_id])
REFERENCES [dbo].[promotions] ([id])
GO
ALTER TABLE [dbo].[applied_promotions]  WITH CHECK ADD FOREIGN KEY([promo_id])
REFERENCES [dbo].[promotions] ([id])
GO
