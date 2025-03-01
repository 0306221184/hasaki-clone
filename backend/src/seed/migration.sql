USE [master]
GO
/****** Object:  Database [hasaki_db]    Script Date: 1/13/2025 4:21:16 PM ******/
CREATE DATABASE [hasaki_db]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'hasaki_db', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.TINWANASQLSERVER\MSSQL\DATA\hasaki_db.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'hasaki_db_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.TINWANASQLSERVER\MSSQL\DATA\hasaki_db_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [hasaki_db] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [hasaki_db].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [hasaki_db] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [hasaki_db] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [hasaki_db] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [hasaki_db] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [hasaki_db] SET ARITHABORT OFF 
GO
ALTER DATABASE [hasaki_db] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [hasaki_db] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [hasaki_db] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [hasaki_db] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [hasaki_db] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [hasaki_db] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [hasaki_db] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [hasaki_db] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [hasaki_db] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [hasaki_db] SET  ENABLE_BROKER 
GO
ALTER DATABASE [hasaki_db] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [hasaki_db] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [hasaki_db] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [hasaki_db] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [hasaki_db] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [hasaki_db] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [hasaki_db] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [hasaki_db] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [hasaki_db] SET  MULTI_USER 
GO
ALTER DATABASE [hasaki_db] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [hasaki_db] SET DB_CHAINING OFF 
GO
ALTER DATABASE [hasaki_db] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [hasaki_db] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [hasaki_db] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [hasaki_db] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'hasaki_db', N'ON'
GO
ALTER DATABASE [hasaki_db] SET QUERY_STORE = ON
GO
ALTER DATABASE [hasaki_db] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [hasaki_db]
GO
/****** Object:  Table [dbo].[address]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[address](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[street_address] [nvarchar](255) NOT NULL,
	[city] [nvarchar](100) NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cart_items]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart_items](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cart_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
	[total_price]  AS ([quantity]*[price]) PERSISTED,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[carts]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[carts](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categories]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[description] [nvarchar](max) NULL,
	[parent_id] [int] NULL,
	[is_active] [bit] NULL,
	[icon_url] [nvarchar](255) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[notifications]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[notifications](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[message] [nvarchar](max) NULL,
	[type] [nvarchar](20) NULL,
	[is_read] [bit] NULL,
	[image_url] [varchar](max) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_details]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_details](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[promotion_id] [int] NULL,
	[shipping_id] [int] NULL,
	[note] [nvarchar](255) NULL,
	[total_amount] [decimal](10, 2) NOT NULL,
	[order_status] [nvarchar](50) NOT NULL,
	[currency] [varchar](10) NOT NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payments]    Script Date: 1/13/2025 4:21:16 PM ******/
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
/****** Object:  Table [dbo].[permissions]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[permissions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_images]    Script Date: 1/13/2025 4:21:16 PM ******/
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
/****** Object:  Table [dbo].[products]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[description] [nvarchar](max) NULL,
	[price] [decimal](10, 2) NOT NULL,
	[discount_price] [decimal](10, 2) NULL,
	[quantity_in_stock] [int] NOT NULL,
	[category_id] [int] NULL,
	[is_active] [bit] NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
	[rating] [decimal](2, 1) NULL,
	[image_url] [nvarchar](255) NULL,
	[variants] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[promotions]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[promotions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[code] [nvarchar](50) NULL,
	[discount_percentage] [decimal](5, 2) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[is_active] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reviews]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reviews](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[rating] [int] NULL,
	[review_text] [nvarchar](max) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[role_permissions]    Script Date: 1/13/2025 4:21:16 PM ******/
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
/****** Object:  Table [dbo].[roles]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[created_at] [datetime] NOT NULL,
	[updated_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[shipping]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[shipping](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[address_id] [int] NOT NULL,
	[phone_number] [char](20) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 1/13/2025 4:21:16 PM ******/
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
	[birth_date] [date] NULL,
	[gender] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wish_lists]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wish_lists](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UX_users_email_provider]    Script Date: 1/13/2025 4:21:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_users_email_provider] ON [dbo].[users]
(
	[email] ASC,
	[provider] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[address] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[address] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[carts] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[categories] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[categories] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[categories] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[notifications] ADD  DEFAULT ((0)) FOR [is_read]
GO
ALTER TABLE [dbo].[notifications] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT ('pending') FOR [order_status]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT ('usd') FOR [currency]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[payments] ADD  DEFAULT ('card') FOR [payment_method]
GO
ALTER TABLE [dbo].[payments] ADD  DEFAULT ('pending') FOR [payment_status]
GO
ALTER TABLE [dbo].[payments] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[permissions] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[permissions] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[products] ADD  DEFAULT ((0)) FOR [quantity_in_stock]
GO
ALTER TABLE [dbo].[products] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[products] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[products] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[promotions] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[reviews] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[role_permissions] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[role_permissions] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[roles] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[roles] ADD  DEFAULT (getdate()) FOR [updated_at]
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
ALTER TABLE [dbo].[wish_lists] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[cart_items]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[cart_items]  WITH CHECK ADD  CONSTRAINT [FK__cart_items__id__04E4BC85] FOREIGN KEY([cart_id])
REFERENCES [dbo].[carts] ([id])
GO
ALTER TABLE [dbo].[cart_items] CHECK CONSTRAINT [FK__cart_items__id__04E4BC85]
GO
ALTER TABLE [dbo].[carts]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[carts]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[categories]  WITH CHECK ADD FOREIGN KEY([parent_id])
REFERENCES [dbo].[categories] ([id])
GO
ALTER TABLE [dbo].[categories]  WITH CHECK ADD FOREIGN KEY([parent_id])
REFERENCES [dbo].[categories] ([id])
GO
ALTER TABLE [dbo].[notifications]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[notifications]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([id])
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([id])
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([promotion_id])
REFERENCES [dbo].[promotions] ([id])
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([shipping_id])
REFERENCES [dbo].[shipping] ([id])
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[payments]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([id])
GO
ALTER TABLE [dbo].[payments]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([id])
GO
ALTER TABLE [dbo].[product_images]  WITH CHECK ADD  CONSTRAINT [fk_product_images_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[product_images] CHECK CONSTRAINT [fk_product_images_product]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[categories] ([id])
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[categories] ([id])
GO
ALTER TABLE [dbo].[reviews]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[reviews]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[reviews]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[reviews]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
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
ALTER TABLE [dbo].[shipping]  WITH CHECK ADD FOREIGN KEY([address_id])
REFERENCES [dbo].[address] ([id])
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [fk_users_roles] FOREIGN KEY([role_id])
REFERENCES [dbo].[roles] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [fk_users_roles]
GO
ALTER TABLE [dbo].[wish_lists]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[wish_lists]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[wish_lists]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[wish_lists]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[cart_items]  WITH CHECK ADD CHECK  (([quantity]>(0)))
GO
ALTER TABLE [dbo].[reviews]  WITH CHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
ALTER TABLE [dbo].[reviews]  WITH CHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD  CONSTRAINT [chk_password_or_provider] CHECK  (([password] IS NOT NULL AND [provider] IS NULL AND [provider_id] IS NULL OR [password] IS NULL AND [provider] IS NOT NULL AND [provider_id] IS NOT NULL))
GO
ALTER TABLE [dbo].[users] CHECK CONSTRAINT [chk_password_or_provider]
GO
/****** Object:  StoredProcedure [dbo].[CreateProduct]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateProduct]
    @name NVARCHAR(255),
    @description NVARCHAR(255) = NULL,
    @price DECIMAL,
    @discount_price DECIMAL,
    @quantity_in_stock INT = 0,
    @category_name NVARCHAR(255),
    @rating DECIMAL = 0,
    @image_url NVARCHAR(255) = NULL,
    @variants NVARCHAR(255) = NULL
AS
BEGIN
    DECLARE @category_id INT;
    DECLARE @productId INT
    -- Check if the category exists
    IF (SELECT COUNT(id) FROM categories WHERE name = @category_name) > 0
    BEGIN
        -- If category exists, get the category_id
        SELECT @category_id = id FROM categories WHERE name = @category_name;

        -- Insert product into the products table
        INSERT INTO products (name, description, price, discount_price, quantity_in_stock, category_id, rating, image_url, variants)
        VALUES (@name, @description, @price, @discount_price, @quantity_in_stock, @category_id, @rating, @image_url, @variants);
    END
    ELSE
    BEGIN
        -- If category doesn't exist, insert the new category and get the category_id
        INSERT INTO categories (name) VALUES (@category_name);
        SELECT @category_id = id FROM categories WHERE name = @category_name;

        -- Insert product into the products table
        INSERT INTO products (name, description, price, discount_price, quantity_in_stock, category_id, rating, image_url, variants)
        VALUES (@name, @description, @price, @discount_price, @quantity_in_stock, @category_id, @rating, @image_url, @variants);
    END

    -- Get the id of the last inserted product
    SET @productId = SCOPE_IDENTITY();

    -- Return the product information including the id of the newly created product
    SELECT * FROM products WHERE id = @productId;
END;


GO
/****** Object:  StoredProcedure [dbo].[CreateUser]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateUser]
@username NVARCHAR(255) = NULL, -- NULL for social login users
@email NVARCHAR(255),
@password NVARCHAR(MAX) = NULL, -- NULL for social login users
@access_token NVARCHAR(MAX) = NULL,
@refresh_token NVARCHAR(MAX) = NULL,
@role_name VARCHAR(255) = 'USER',
@avatar NVARCHAR(MAX) =NULL,
@full_name NVARCHAR(255) = NULL,
@phone_number NVARCHAR(50) = NULL,
@provider VARCHAR(255) = NULL, -- NULL for local users
@provider_id VARCHAR(255) = NULL ,-- Unique ID from provider (NULL for local users)
@is_email_verified BIT = 0,
@gender NVARCHAR(50) = NULL, -- Thêm tham số gender
@birth_date DATETIME = NULL -- Thêm tham số birth_date
AS
BEGIN
	DECLARE @role_id int
	IF (SELECT COUNT(id) FROM roles WHERE name = @role_name) > 0
	BEGIN
		SELECT @role_id = id FROM roles WHERE name = @role_name;
    	INSERT INTO Users (username,email,password,access_token,refresh_token,role_id,avatar,full_name,phone_number,provider,provider_id,is_email_verified,gender,birth_date)
    	VALUES (@username,@email,@password,@access_token,@refresh_token,@role_id,@avatar,@full_name,@phone_number,@provider,@provider_id,@is_email_verified,@gender,@birth_date);
	END
	ELSE
	BEGIN
		INSERT INTO roles(name) VALUES (@role_name)
		SELECT @role_id = id FROM roles WHERE name = @role_name;
		INSERT INTO Users (username,email,password,access_token,refresh_token,role_id,avatar,full_name,phone_number,provider,provider_id,is_email_verified,gender,birth_date)
    	VALUES (@username,@email,@password,@access_token,@refresh_token,@role_id,@avatar,@full_name,@phone_number,@provider,@provider_id,@is_email_verified,@gender,@birth_date);
	END
	
    -- Return the newly created user (similar to Prisma returning the created object)
    SELECT 
        *
    FROM 
        Users
    WHERE 
        email = @email;
END;


GO
/****** Object:  StoredProcedure [dbo].[DeleteProduct]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure to delete a user by ID
CREATE PROCEDURE [dbo].[DeleteProduct]
    @product_id INT
AS
BEGIN
	DELETE FROM product_images WHERE product_id = @product_id
    DELETE FROM products
    WHERE Id = @product_id;

    -- Optionally, you could return a status message or number of rows affected
    SELECT 'Product deleted successfully' AS Message;
END;









GO
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Create a stored procedure to delete a user by ID
CREATE PROCEDURE [dbo].[DeleteUser]
    @user_id INT
AS
BEGIN
    DELETE FROM Users
    WHERE Id = @user_id;

    -- Optionally, you could return a status message or number of rows affected
    SELECT 'User deleted successfully' AS Message;
END;








GO
/****** Object:  StoredProcedure [dbo].[FindAllCart]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindAllCart]
    @id INT = NULL,
    @user_id INT = NULL,
    @created_at DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find all cart items with optional filters for each property
    SELECT *
    FROM [dbo].[carts]
    WHERE (@id IS NULL OR [id] = @id)
      AND (@user_id IS NULL OR [user_id] = @user_id)
      AND (@created_at IS NULL OR [created_at] = @created_at);
END;



GO
/****** Object:  StoredProcedure [dbo].[FindAllCategories]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindAllCategories]
    @id INT = NULL,
    @name NVARCHAR(255) = NULL,
    @parent_id INT = NULL,
    @is_active BIT = NULL,
    @created_at DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find multiple categories with optional filters for each property
    SELECT *
    FROM [dbo].[categories]
    WHERE (@id IS NULL OR [id] = @id)
      AND (@name IS NULL OR [name] LIKE '%' + @name + '%')
      AND (@parent_id IS NULL OR [parent_id] = @parent_id)
      AND (@is_active IS NULL OR [is_active] = @is_active)
      AND (@created_at IS NULL OR [created_at] = @created_at)
END;



GO
/****** Object:  StoredProcedure [dbo].[FindManyNotifications]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindManyNotifications]
    @user_id INT = NULL,
    @is_read BIT = NULL,
	@created_at DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find multiple notification entries based on optional filters
    SELECT *
    FROM [dbo].[notifications]
    WHERE (@user_id IS NULL OR [user_id] = @user_id)
      AND (@is_read IS NULL OR [is_read] = @is_read)
      AND (@created_at IS NULL OR created_at = @created_at);
END;



GO
/****** Object:  StoredProcedure [dbo].[FindManyOrderDetails]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindManyOrderDetails]
    @order_id INT = NULL,
    @product_id INT = NULL,
    @quantity INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find multiple order detail entries based on the filtering parameters
    SELECT *
    FROM [dbo].[order_details]
    WHERE (@order_id IS NULL OR [order_id] = @order_id)
      AND (@product_id IS NULL OR [product_id] = @product_id)
      AND (@quantity IS NULL OR quantity = @quantity);
END;



GO
/****** Object:  StoredProcedure [dbo].[FindManyOrders]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindManyOrders]
    @user_id INT = NULL,
    @order_status NVARCHAR(50) = NULL,
    @created_at DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find multiple order entries based on the filtering parameters
    SELECT *
    FROM [dbo].[orders]
    WHERE (@user_id IS NULL OR [user_id] = @user_id)
      AND (@order_status IS NULL OR [order_status] LIKE '%' + @order_status + '%')
      AND (@created_at IS NULL OR [created_at] = @created_at);
END;



GO
/****** Object:  StoredProcedure [dbo].[FindManyPayments]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindManyPayments]
    @order_id INT = NULL,
    @payment_method NVARCHAR(50) = NULL,
    @payment_status NVARCHAR(50) = NULL,
    @created_at DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find multiple payments based on the filtering parameters
    SELECT *
    FROM [dbo].[payments]
    WHERE (@order_id IS NULL OR [order_id] = @order_id)
      AND (@payment_method IS NULL OR [payment_method] LIKE '%' + @payment_method + '%')
      AND (@payment_status IS NULL OR [payment_status] LIKE '%' + @payment_status + '%')
      AND (@created_at IS NULL OR [created_at] = @created_at);
END;



GO
/****** Object:  StoredProcedure [dbo].[FindManyPermissions]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindManyPermissions]
    @name NVARCHAR(255) = NULL,
    @created_at DATETIME = NULL,
    @updated_at DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find multiple permissions based on the filtering parameters
    SELECT *
    FROM [dbo].[permissions]
    WHERE (@name IS NULL OR [name] LIKE '%' + @name + '%')
      AND (@created_at IS NULL OR [created_at] = @created_at)
      AND (@updated_at IS NULL OR [updated_at] = @updated_at);
END;



GO
/****** Object:  StoredProcedure [dbo].[FindManyPermissionsByRoleId]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FindManyPermissionsByRoleId]
    @role_id INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT [dbo].[permissions].*
    FROM [dbo].[role_permissions] INNER JOIN [dbo].[permissions] ON [dbo].[permissions].id = [dbo].[role_permissions].permission_id
    WHERE [dbo].[role_permissions].role_id = @role_id
END;




GO
/****** Object:  StoredProcedure [dbo].[FindManyProducts]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindManyProducts]
    @name NVARCHAR(255) = NULL,
    @category_id INT = NULL,
    @is_active BIT = NULL,
    @min_price DECIMAL(10, 2) = NULL,
    @max_price DECIMAL(10, 2) = NULL,
    @min_quantity_in_stock INT = NULL,
    @rating DECIMAL(2, 1) = NULL,
    @column NVARCHAR(MAX) = '*',
    @top INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Initialize the base query
    DECLARE @sql NVARCHAR(MAX) = N'SELECT ';

    -- Add TOP clause if specified
    IF @top IS NOT NULL
        SET @sql += N'TOP (' + CAST(@top AS NVARCHAR) + N') ';

    -- Add column selection
    SET @sql += @column + N' FROM [dbo].[products] WHERE 1 = 1';

    -- Add optional filters
    IF @name IS NOT NULL
        SET @sql += N' AND [name] LIKE ''%' + REPLACE(@name, '''', '''''') + N'%''';
    IF @category_id IS NOT NULL
        SET @sql += N' AND [category_id] = @category_id';
    IF @is_active IS NOT NULL
        SET @sql += N' AND [is_active] = @is_active';
    IF @min_price IS NOT NULL
        SET @sql += N' AND [price] >= @min_price';
    IF @max_price IS NOT NULL
        SET @sql += N' AND [price] <= @max_price';
    IF @min_quantity_in_stock IS NOT NULL
        SET @sql += N' AND [quantity_in_stock] >= @min_quantity_in_stock';
    IF @rating IS NOT NULL
        SET @sql += N' AND [rating] = @rating';
    -- Execute the dynamic SQL
    EXEC sp_executesql 
        @sql,
        N'@category_id INT, @is_active BIT, @min_price DECIMAL(10,2), 
          @max_price DECIMAL(10,2), @min_quantity_in_stock INT, @rating DECIMAL(2,1)',
        @category_id, @is_active, @min_price, @max_price, @min_quantity_in_stock, @rating;
END;
GO
/****** Object:  StoredProcedure [dbo].[FindManyPromotions]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindManyPromotions]
    @code NVARCHAR(50) = NULL,
    @discount_percentage DECIMAL(5, 2) = NULL,
    @start_date DATE = NULL,
    @end_date DATE = NULL,
    @is_active BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find multiple promotions based on the filtering parameters
    SELECT *
    FROM [dbo].[promotions]
    WHERE (@code IS NULL OR [code] = @code)
      AND (@discount_percentage IS NULL OR [discount_percentage] = @discount_percentage)
      AND (@start_date IS NULL OR [start_date] = @start_date)
      AND (@end_date IS NULL OR [end_date] = @end_date)
      AND (@is_active IS NULL OR [is_active] = @is_active);
END;



GO
/****** Object:  StoredProcedure [dbo].[FindManyReviews]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindManyReviews]
    @product_id INT = NULL,
    @user_id INT = NULL,
    @rating INT = NULL,
    @review_text NVARCHAR(MAX) = NULL,
    @created_at DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query for finding multiple reviews based on various optional parameters
    SELECT *
    FROM [dbo].[reviews]
    WHERE (@product_id IS NULL OR [product_id] = @product_id)
      AND (@user_id IS NULL OR [user_id] = @user_id)
      AND (@rating IS NULL OR [rating] = @rating)
      AND (@review_text IS NULL OR [review_text] LIKE '%' + @review_text + '%')
      AND (@created_at IS NULL OR [created_at] = @created_at);
END;



GO
/****** Object:  StoredProcedure [dbo].[FindManyRolePermissions]    Script Date: 1/13/2025 4:21:16 PM ******/
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
/****** Object:  StoredProcedure [dbo].[FindManyRolesByPermissionId]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FindManyRolesByPermissionId]
    @permission_id INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT [dbo].[roles].*
    FROM [dbo].[role_permissions] INNER JOIN [dbo].[roles] ON [dbo].[roles].id = [dbo].[role_permissions].role_id
    WHERE [dbo].[role_permissions].permission_id = @permission_id
END;




GO
/****** Object:  StoredProcedure [dbo].[FindManyUsers]    Script Date: 1/13/2025 4:21:16 PM ******/
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
/****** Object:  StoredProcedure [dbo].[FindManyWishLists]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindManyWishLists]
    @user_id INT = NULL,
    @product_id INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query for finding multiple wish list entries based on user_id and product_id
    SELECT *
    FROM [dbo].[wish_lists]
    WHERE (@user_id IS NULL OR [user_id] = @user_id)
      AND (@product_id IS NULL OR [product_id] = @product_id);
END;



GO
/****** Object:  StoredProcedure [dbo].[FindUniqueCart]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueCart]
    @id INT = NULL,
    @user_id INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Fetch a unique cart item either by id or user_id and product_id
    IF @id IS NOT NULL
    BEGIN
        SELECT *
        FROM [dbo].[carts]
        WHERE [id] = @id;
    END
    ELSE IF @user_id IS NOT NULL
    BEGIN
        SELECT *
        FROM [dbo].[carts]
        WHERE [user_id] = @user_id;
    END
    ELSE
    BEGIN
        SELECT 'Error: Please provide either an id or both user_id and product_id.';
    END
END;



GO
/****** Object:  StoredProcedure [dbo].[FindUniqueCategory]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueCategory]
    @id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find a unique category entry by `id`
    SELECT *
    FROM [dbo].[categories]
    WHERE [id] = @id;
END;



GO
/****** Object:  StoredProcedure [dbo].[FindUniqueNotification]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueNotification]
    @id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find a unique notification entry by `id`
    SELECT *
    FROM [dbo].[notifications]
    WHERE [id] = @id;
END;



GO
/****** Object:  StoredProcedure [dbo].[FindUniqueOrder]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueOrder]
    @id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find a unique order entry based on either `id` or `user_id`
    SELECT *
    FROM [dbo].[orders]
    WHERE id = @id
END;



GO
/****** Object:  StoredProcedure [dbo].[FindUniqueOrderDetail]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueOrderDetail]
    @id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find a unique order detail entry based on either `id`, `order_id` or `product_id`
    SELECT *
    FROM [dbo].[order_details]
    WHERE id=@id
END;



GO
/****** Object:  StoredProcedure [dbo].[FindUniquePayment]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniquePayment]
    @id INT = NULL,
    @order_id INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find a unique payment based on either `id` or `order_id`
    SELECT *
    FROM [dbo].[payments]
    WHERE (@id IS NOT NULL AND [id] = @id)
       OR (@order_id IS NOT NULL AND [order_id] = @order_id);
END;



GO
/****** Object:  StoredProcedure [dbo].[FindUniquePermission]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniquePermission]
    @id INT = NULL,
    @name NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find a unique permission based on either `id` or `name`
    SELECT *
    FROM [dbo].[permissions]
    WHERE (@id IS NOT NULL AND [id] = @id)
       OR (@name IS NOT NULL AND [name] = @name);
END;



GO
/****** Object:  StoredProcedure [dbo].[FindUniqueProduct]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueProduct]
    @id INT = NULL,                          -- Optional: product ID filter
    @sku NVARCHAR(100) = NULL,                -- Optional: SKU filter
    @column NVARCHAR(MAX) = '*'               -- Optional: dynamic column selection
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @sql NVARCHAR(MAX)

    -- Building the dynamic SQL query to select the columns based on @column input
    SET @sql = N'SELECT TOP 1 ' + @column + N' FROM [dbo].[products] WHERE (@id IS NULL OR [id] = @id) AND (@sku IS NULL OR [sku] = @sku);'

    -- Executing the dynamic SQL with the parameters passed
    EXEC sp_executesql @sql, N'@id INT, @sku NVARCHAR(100)', @id, @sku;
END;



GO
/****** Object:  StoredProcedure [dbo].[FindUniquePromotion]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniquePromotion]
    @id INT = NULL,
    @code NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query to find a unique promotion based on either `id` or `code`
    SELECT *
    FROM [dbo].[promotions]
    WHERE (@id IS NOT NULL AND [id] = @id)
       OR (@code IS NOT NULL AND [code] = @code);
END;



GO
/****** Object:  StoredProcedure [dbo].[FindUniqueReview]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueReview]
    @product_id INT,
    @user_id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Query for finding a unique review based on product_id and user_id
    SELECT TOP 1 *
    FROM [dbo].[reviews]
    WHERE [product_id] = @product_id
      AND [user_id] = @user_id
END;



GO
/****** Object:  StoredProcedure [dbo].[FindUniqueRole]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueRole]
    @role_id INT = NULL,
    @role_name NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query for finding a unique role based on role_id or role_name
    SELECT TOP 1 *
    FROM [dbo].[roles]
    WHERE (@role_id IS NULL OR [id] = @role_id)
      AND (@role_name IS NULL OR [name] = @role_name)
END;



GO
/****** Object:  StoredProcedure [dbo].[FindUniqueRolePermission]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueRolePermission]
    @role_id INT,
    @permission_id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Query for finding a unique role_permission based on role_id and permission_id
    SELECT TOP 1 *
    FROM [dbo].[role_permissions]
    WHERE [role_id] = @role_id
      AND [permission_id] = @permission_id
END;



GO
/****** Object:  StoredProcedure [dbo].[FindUniqueUser]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueUser]
    @username NVARCHAR(255) = NULL,          -- Optional: username filter
    @email NVARCHAR(255) = NULL,             -- Optional: email filter
    @id INT = NULL      ,
	@column nvarchar(max) = '*'                     -- Optional: user ID filter
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @sql NVARCHAR(MAX)
	SET @sql = N'SELECT TOP 1 '+ @column + N' FROM [dbo].[users] WHERE (@username IS NULL OR [username] = @username) AND (@email IS NULL OR [email] = @email) AND (@id IS NULL OR [id] = @id) ORDER BY [created_at] DESC;'
    EXEC sp_executesql @sql , N'@username nvarchar(255), @email nvarchar(255), @id int',@username,@email,@id;
END;


GO
/****** Object:  StoredProcedure [dbo].[FindUniqueWishList]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FindUniqueWishList]
    @wishlist_id INT = NULL,
    @user_id INT = NULL,
    @product_id INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Query for finding a unique wish list entry based on wishlist_id, user_id or product_id
    SELECT TOP 1 *
    FROM [dbo].[wish_lists]
    WHERE (@wishlist_id IS NULL OR id = @wishlist_id)
      AND (@user_id IS NULL OR [user_id] = @user_id)
      AND (@product_id IS NULL OR [product_id] = @product_id)
END;



GO
/****** Object:  StoredProcedure [dbo].[SortDeleteUser]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SortDeleteUser]
    @user_id INT
AS
BEGIN
    UPDATE users SET is_deleted = 1 WHERE id = @user_id

    -- Optionally, you could return a status message or number of rows affected
    SELECT 'User sort deleted successfully' AS Message;
END;







GO
/****** Object:  StoredProcedure [dbo].[UpdateProduct]    Script Date: 1/13/2025 4:21:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateProduct]
    @product_id INT,
    @name NVARCHAR(255) = null,
	@description NVARCHAR(255) = NULL,
	@price DECIMAL = null,
	@discount_price DECIMAL = null,
	@sku NVARCHAR(255) = NULL,
	@quantity_in_stock INT = null,
	@category_name NVARCHAR(255)=null,
	@rating DECIMAL=null,
	@image_url NVARCHAR(255) = NULL,
	@variants NVARCHAR(255) = NULL,
	@tags NVARCHAR(255) = NULL,
    @toggle_active bit = 0
AS
BEGIN
    DECLARE @sql nvarchar(max);
    DECLARE @category_id INT;
	 -- Initialize the SQL string
    SET @sql = 'UPDATE products SET';
    -- Check if the category exists
    IF (SELECT COUNT(id) FROM categories WHERE name = @category_name) > 0
    BEGIN
        -- If category exists, get the category_id
        SELECT @category_id = id FROM categories WHERE name = @category_name;
    END
    ELSE
    BEGIN
        -- If category doesn't exist, insert the new category and get the category_id
        INSERT INTO categories (name) VALUES (@category_name);
        SELECT @category_id = id FROM categories WHERE name = @category_name;
    END
	-- Conditionally append column updates based on parameters
    SET @sql = @sql + ' updated_at = GETDATE(),';
	IF @name is not null
        SET @sql = @sql + ' name = @name,';
	IF @description is not null
        SET @sql = @sql + ' description = @description,';
	IF @price is not null
		SET @sql = @sql + ' price = @price,';
	IF @discount_price is not null
		SET @sql = @sql + ' discount_price = @discount_price,';
	IF @sku is not null
        SET @sql = @sql + ' sku = @sku,';
	IF @quantity_in_stock is not null
        SET @sql = @sql + ' quantity_in_stock = @quantity_in_stock,';
	IF @category_name is not null
        SET @sql = @sql + ' category_id = @category_id,';
	IF @rating is not null
        SET @sql = @sql + ' rating = @rating,';
	IF @image_url is not null
        SET @sql = @sql + ' image_url = @image_url,';
	IF @variants is not null
        SET @sql = @sql + ' variants = @variants,';
	IF @tags is not null
        SET @sql = @sql + ' tags = @tags,';
        IF @toggle_active = 1
        SET @sql = @sql + ' is_active = is_active ^ 1,';
	 -- Remove the trailing comma
    SET @sql = LEFT(@sql, LEN(@sql) - 1);

    -- Add WHERE clause
    SET @sql = @sql + ' WHERE id = @product_id';

	-- Execute the dynamic SQL
	EXEC sp_executesql @sql,N' @product_id INT, @name NVARCHAR(255), @description NVARCHAR(255), @price DECIMAL, @discount_price DECIMAL, @sku NVARCHAR(255), @quantity_in_stock INT, @category_id int, @rating DECIMAL, @image_url NVARCHAR(255), @variants NVARCHAR(255), @tags NVARCHAR(255)
'                               , @product_id, @name, @description, @price, @discount_price, @sku, @quantity_in_stock, @category_id, @rating, @image_url, @variants, @tags;

-- Return the updated user
    SELECT * FROM products WHERE id = @product_id;
END;




GO
/****** Object:  StoredProcedure [dbo].[UpdateUser]    Script Date: 1/13/2025 4:21:16 PM ******/
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
USE [master]
GO
ALTER DATABASE [hasaki_db] SET  READ_WRITE 
GO
