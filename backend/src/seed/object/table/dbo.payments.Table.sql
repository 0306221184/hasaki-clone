USE [hasaki_db]
GO
/****** Object:  Table [dbo].[payments]    Script Date: 1/9/2025 8:19:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NOT NULL,
	[stripe_payment_intent_id] [varchar](200) NULL,
	[stripe_checkout_session_id] [varchar](200) NULL,
	[stripe_customer_id] [varchar](200) NULL,
	[payment_method] [nvarchar](50) NULL,
	[payment_status] [nvarchar](50) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[payments] ADD  DEFAULT ('card') FOR [payment_method]
GO
ALTER TABLE [dbo].[payments] ADD  DEFAULT ('pending') FOR [payment_status]
GO
ALTER TABLE [dbo].[payments] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[payments]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([id])
GO
ALTER TABLE [dbo].[payments]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([id])
GO
