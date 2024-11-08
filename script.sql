USE [master]
GO
/****** Object:  Database [PhoneStore]    Script Date: 11/3/2024 9:53:30 AM ******/
CREATE DATABASE [PhoneStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PhoneStore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\PhoneStore.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PhoneStore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\PhoneStore_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [PhoneStore] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PhoneStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PhoneStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PhoneStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PhoneStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PhoneStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PhoneStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [PhoneStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PhoneStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PhoneStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PhoneStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PhoneStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PhoneStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PhoneStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PhoneStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PhoneStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PhoneStore] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PhoneStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PhoneStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PhoneStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PhoneStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PhoneStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PhoneStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PhoneStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PhoneStore] SET RECOVERY FULL 
GO
ALTER DATABASE [PhoneStore] SET  MULTI_USER 
GO
ALTER DATABASE [PhoneStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PhoneStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PhoneStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PhoneStore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PhoneStore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PhoneStore] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PhoneStore', N'ON'
GO
ALTER DATABASE [PhoneStore] SET QUERY_STORE = ON
GO
ALTER DATABASE [PhoneStore] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [PhoneStore]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 11/3/2024 9:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[cart_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cart_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order_Items]    Script Date: 11/3/2024 9:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_Items](
	[order_item_id] [int] NOT NULL,
	[order_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](15, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_item_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 11/3/2024 9:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[order_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[order_date] [datetime] NULL,
	[total_amount] [decimal](15, 2) NOT NULL,
	[status] [varchar](50) NULL,
	[shipping_address] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 11/3/2024 9:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[product_id] [int] NOT NULL,
	[product_name] [varchar](100) NOT NULL,
	[brand] [varchar](50) NOT NULL,
	[price] [decimal](15, 2) NOT NULL,
	[description] [text] NULL,
	[image_url] [varchar](255) NULL,
	[stock_quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 11/3/2024 9:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[review_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[user_id] [int] NULL,
	[rating] [int] NOT NULL,
	[comment] [text] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[review_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 11/3/2024 9:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[role_id] [int] NOT NULL,
	[name] [varchar](100) NOT NULL,
	[description] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/3/2024 9:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[user_id] [int] NOT NULL,
	[username] [varchar](100) NOT NULL,
	[email] [varchar](255) NOT NULL,
	[password_hash] [varchar](255) NOT NULL,
	[full_name] [varchar](255) NULL,
	[role_id] [int] NOT NULL,
	[phonenumber] [varchar](15) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (1, N'iPhone 12', N'Apple', CAST(20290000.00 AS Decimal(15, 2)), N'Màn hình 6.1 inch, chip A14 Bionic, camera 12MP kép, pin 2815 mAh, RAM 4GB, ROM 64GB.', N'https://product.hstatic.net/200000525189/product/iphone_12_trang_a6fcadf374044dcbb70861ad92e3c168.png', 50)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (2, N'iPhone 13', N'Apple', CAST(25290000.00 AS Decimal(15, 2)), N'Màn hình 6.1 inch, chip A15 Bionic, camera 12MP kép, pin 3240 mAh, RAM 4GB, ROM 128GB.', N'https://cdn2.cellphones.com.vn/x/media/catalog/product/1/3/13_4_8_1.jpg', 45)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (3, N'iPhone 14', N'Apple', CAST(27890000.00 AS Decimal(15, 2)), N'Màn hình 6.1 inch, chip A15 Bionic, camera 12MP kép, pin 3279 mAh, RAM 6GB, ROM 128GB.', N'https://mobileworld.com.vn/uploads/product/iPhone_14/iphone_14_black.jpg', 55)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (4, N'iPhone 14 Pro', N'Apple', CAST(32890000.00 AS Decimal(15, 2)), N'Màn hình 6.1 inch Super Retina XDR, chip A16 Bionic, camera 48MP, pin 3200 mAh, RAM 6GB, ROM 128GB.', N'https://quocvietapple.com/wp-content/uploads/2024/06/iphone-14-pro-deeppurple.jpg', 35)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (5, N'iPhone 14 Plus', N'Apple', CAST(30290000.00 AS Decimal(15, 2)), N'Màn hình 6.7 inch, chip A15 Bionic, camera 12MP kép, pin 4325 mAh, RAM 6GB, ROM 128GB.', N'https://vuasmartphone.vn/upload/product/161316497685.jpg', 30)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (6, N'Galaxy S21', N'Samsung', CAST(22790000.00 AS Decimal(15, 2)), N'Màn hình 6.2 inch, chip Exynos 2100, camera 12MP + 64MP + 12MP, pin 4000 mAh, RAM 8GB, ROM 128GB.', N'https://mobileworld.com.vn/uploads/product/11_2021/thumbs/galaxy-s21-5g-128gb-moi-99-like-new-ban-my-2sim-chip-snapdragon-888-fullbox-2.webp', 40)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (7, N'Galaxy Z Fold3', N'Samsung', CAST(45490000.00 AS Decimal(15, 2)), N'Màn hình 7.6 inch, chip Snapdragon 888, camera 12MP + 12MP + 12MP, pin 4400 mAh, RAM 12GB, ROM 256GB.', N'https://bizweb.dktcdn.net/100/450/634/products/1-jpeg.jpg?v=1665044193867', 20)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (8, N'Galaxy S22 Ultra', N'Samsung', CAST(30290000.00 AS Decimal(15, 2)), N'Màn hình 6.8 inch, chip Snapdragon 8 Gen 1, camera 108MP + 12MP + 10MP + 10MP, pin 5000 mAh, RAM 12GB, ROM 256GB.', N'https://product.hstatic.net/1000198144/product/s22_ultra_den_b0ef9e9bb56143b69b6046c324c9de2e_master.jpg', 40)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (9, N'Galaxy Z Fold4', N'Samsung', CAST(45490000.00 AS Decimal(15, 2)), N'Màn hình 7.6 inch, chip Snapdragon 8+ Gen 1, camera 50MP + 12MP + 10MP, pin 4400 mAh, RAM 12GB, ROM 512GB.', N'https://minmobile.net/media/cache/data/Samsung/Galaxy-Z4/samsung-galaxy-z-fold-4-gia-re-chinh-hang-copy-800x800.jpg', 15)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (10, N'Find X3 Pro', N'OPPO', CAST(25290000.00 AS Decimal(15, 2)), N'Màn hình 6.7 inch, chip Snapdragon 888, camera 50MP + 50MP + 13MP + 3MP, pin 4500 mAh, RAM 12GB, ROM 256GB.', N'https://www.mistermobile.com.sg/wp-content/uploads/2023/07/Oppo-Find-X3-Pro-Blue-1.png.webp', 30)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (11, N'Find X5 Pro', N'OPPO', CAST(32890000.00 AS Decimal(15, 2)), N'Màn hình 6.7 inch, chip Snapdragon 8 Gen 1, camera 50MP + 50MP + 13MP + 3MP, pin 5000 mAh, RAM 12GB, ROM 256GB.', N'https://shop.oppomobile.nz/cdn/shop/files/OPPOFindX5Pro5GSideProfile-1-_2.png?v=1716851415&width=2048', 25)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (12, N'Find X5', N'OPPO', CAST(8990000.00 AS Decimal(15, 2)), N'Màn hình 6.55 inch, chip Snapdragon 888, camera 50MP + 13MP + 2MP, pin 4800 mAh, RAM 8GB, ROM 128GB.', N'https://b2b.t-outlet.com/wp-content/uploads/2024/02/Oppo-Find-X5-Roxo.jpg', 35)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (13, N'V21 5G', N'Vivo', CAST(4990000.00 AS Decimal(15, 2)), N'Màn hình 6.44 inch, chip MediaTek Dimensity 800U, camera 64MP + 8MP + 2MP, pin 4000 mAh, RAM 8GB, ROM 128GB.', N'https://ae01.alicdn.com/kf/H2afc31e08e884608899ac89bbf9c28bcc.jpg_960x960.jpg', 60)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (14, N'V23 5G', N'Vivo', CAST(5990000.00 AS Decimal(15, 2)), N'Màn hình 6.44 inch, chip MediaTek Dimensity 920, camera 64MP + 8MP + 2MP, pin 4200 mAh, RAM 8GB, ROM 128GB.', N'https://cdn2.fptshop.com.vn/unsafe/800x0/filters:quality(80)/2021_12_31_637765553887781624_vivo-v23-5g-vang-dd.jpg', 55)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (15, N'X80 Pro', N'Vivo', CAST(10990000.00 AS Decimal(15, 2)), N'Màn hình 6.78 inch, chip Snapdragon 8 Gen 1, camera 50MP + 50MP + 12MP + 8MP, pin 4700 mAh, RAM 12GB, ROM 256GB.', N'https://cdn2.cellphones.com.vn/x/media/catalog/product/g/a/gallery-pc-img1_2.jpg', 25)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (16, N'X80', N'Vivo', CAST(7990000.00 AS Decimal(15, 2)), N'Màn hình 6.78 inch, chip MediaTek Dimensity 9000, camera 50MP + 12MP + 12MP, pin 4500 mAh, RAM 12GB, ROM 256GB.', N'https://cdn.mobilecity.vn/mobilecity-vn/images/2022/05/vivo-x80-xanh.jpg.webp', 45)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (17, N'Spark 7P', N'Tecno', CAST(1490000.00 AS Decimal(15, 2)), N'Màn hình 6.8 inch, chip MediaTek Helio G70, camera 16MP + 2MP + 2MP, pin 5000 mAh, RAM 4GB, ROM 64GB.', N'https://d3fyizz0b46qgr.cloudfront.net/global/phones/spark_7p/black.png', 80)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (18, N'Spark 8C', N'Tecno', CAST(1990000.00 AS Decimal(15, 2)), N'Màn hình 6.6 inch, chip Unisoc T606, camera 13MP + 2MP, pin 5000 mAh, RAM 4GB, ROM 64GB.', N'https://d3fyizz0b46qgr.cloudfront.net/global/phones/spark8/blue.png', 90)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (19, N'Camon 19 Pro', N'Tecno', CAST(2990000.00 AS Decimal(15, 2)), N'Màn hình 6.8 inch, chip MediaTek Helio G96, camera 64MP + 2MP + 0.3MP, pin 5000 mAh, RAM 8GB, ROM 128GB.', N'https://cdn2.cellphones.com.vn/x/media/catalog/product/c/a/camon--19pro_5g_lv.png', 60)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (20, N'Camon 19', N'Tecno', CAST(2490000.00 AS Decimal(15, 2)), N'Màn hình 6.8 inch, chip MediaTek Helio G85, camera 50MP + 2MP, pin 5000 mAh, RAM 6GB, ROM 128GB.', N'https://d3fyizz0b46qgr.cloudfront.net/global/phones/camon19pro/camon19--hei11.png', 70)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (21, N'Narzo 30A', N'Realme', CAST(1990000.00 AS Decimal(15, 2)), N'Màn hình 6.5 inch, chip MediaTek Helio G85, camera 13MP + 2MP, pin 5000 mAh, RAM 4GB, ROM 64GB.', N'https://cellphones.com.vn/media/catalog/product/1/6/1631776707007.png', 70)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (22, N'Narzo 50A', N'Realme', CAST(2490000.00 AS Decimal(15, 2)), N'Màn hình 6.5 inch, chip MediaTek Helio G85, camera 50MP + 2MP, pin 5000 mAh, RAM 4GB, ROM 128GB.', N'https://cdn2.cellphones.com.vn/insecure/plain/https://cellphones.com.vn/media/catalog/product//1/6/1631776707007.png', 65)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (23, N'Narzo 50i', N'Realme', CAST(1490000.00 AS Decimal(15, 2)), N'Màn hình 6.5 inch, chip Unisoc SC9863A, camera 8MP, pin 5000 mAh, RAM 4GB, ROM 64GB.', N'https://diamu.com.bd/wp-content/uploads/2022/01/Realme-Narzo-50i-Black.png', 80)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (24, N'Narzo 50', N'Realme', CAST(1990000.00 AS Decimal(15, 2)), N'Màn hình 6.6 inch, chip MediaTek Dimensity 810, camera 50MP + 2MP, pin 5000 mAh, RAM 6GB, ROM 128GB.', N'https://www.techdenbd.com/backend/img/product/realme-narzo-50-8gb128gb-full-specifications-buy-online-2022-09-27-6332bc8762e47.png', 60)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (25, N'Reno8 Pro', N'OPPO', CAST(18990000.00 AS Decimal(15, 2)), N'Màn hình 6.55 inch AMOLED, chip MediaTek Dimensity 8100-MAX, camera 50MP + 8MP + 2MP, pin 4500 mAh, RAM 12GB, ROM 256GB.', N'https://gmglobalenterprise.com/wp-content/uploads/2023/10/Untitled-design-2023-12-18T171636.775.png', 35)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (26, N'Reno8', N'OPPO', CAST(13990000.00 AS Decimal(15, 2)), N'Màn hình 6.43 inch AMOLED, chip MediaTek Dimensity 1300, camera 50MP + 8MP + 2MP, pin 4500 mAh, RAM 8GB, ROM 128GB.', N'https://cdn2.cellphones.com.vn/x/media/catalog/product/c/o/combo_product_-_reno8_4g_-_gold.png', 45)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (27, N'Reno7 Pro', N'OPPO', CAST(11990000.00 AS Decimal(15, 2)), N'Màn hình 6.55 inch AMOLED, chip MediaTek Dimensity 1200-MAX, camera 50MP + 8MP + 2MP, pin 4500 mAh, RAM 8GB, ROM 256GB.', N'https://staging.courtsmammouth.mu/78245-large_default/oppo-reno-7-pro-blue.jpg', 30)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (28, N'Reno7', N'OPPO', CAST(9990000.00 AS Decimal(15, 2)), N'Màn hình 6.43 inch AMOLED, chip MediaTek Dimensity 900, camera 64MP + 8MP + 2MP, pin 4500 mAh, RAM 8GB, ROM 128GB.', N'https://gadgetdepot.co.ke/550-large_default/oppo-reno-7-5g8gb-256gb.jpg', 40)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (29, N'Reno6 Pro', N'OPPO', CAST(13990000.00 AS Decimal(15, 2)), N'Màn hình 6.55 inch AMOLED, chip MediaTek Dimensity 1200, camera 64MP + 8MP + 2MP + 2MP, pin 4500 mAh, RAM 12GB, ROM 256GB.', N'https://cdn2.cellphones.com.vn/x/media/catalog/product/o/p/opp-ren6-fro-5g-12gb-256gb-xd-99_1_.png', 25)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (30, N'Reno6', N'OPPO', CAST(9990000.00 AS Decimal(15, 2)), N'Màn hình 6.43 inch AMOLED, chip MediaTek Dimensity 900, camera 64MP + 8MP + 2MP, pin 4300 mAh, RAM 8GB, ROM 128GB.', N'https://images.tokopedia.net/img/cache/700/VqbcmM/2021/9/17/2c538729-22f3-453e-ba14-f3911d334250.jpg', 35)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (31, N'Mi 11 Ultra', N'Xiaomi', CAST(27990000.00 AS Decimal(15, 2)), N'Màn hình 6.81 inch AMOLED, chip Snapdragon 888, camera 50MP + 48MP + 48MP, pin 5000 mAh, RAM 12GB, ROM 256GB.', N'https://mobileworld.com.vn/uploads/product/04_2021/xiaomi-mi-11-ultra-12gb512gb-moi-fullbox-1.png', 20)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (32, N'Mi 11', N'Xiaomi', CAST(14990000.00 AS Decimal(15, 2)), N'Màn hình 6.55 inch AMOLED, chip Snapdragon 888, camera 108MP + 13MP + 5MP, pin 4600 mAh, RAM 8GB, ROM 128GB.', N'https://i01.appmifile.com/v1/MI_18455B3E4DA706226CF7535A58E875F0267/pms_1666344667.93946102.png', 35)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (33, N'Mi 10T Pro', N'Xiaomi', CAST(11990000.00 AS Decimal(15, 2)), N'Màn hình 6.67 inch LCD, chip Snapdragon 865, camera 108MP + 13MP + 5MP, pin 5000 mAh, RAM 8GB, ROM 128GB.', N'https://fundamental.in/wp-content/uploads/2021/01/F687C3BD-EAC8-03B0-4C34-823281D6F1D8.png', 30)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (34, N'Mi 10T', N'Xiaomi', CAST(8990000.00 AS Decimal(15, 2)), N'Màn hình 6.67 inch LCD, chip Snapdragon 865, camera 64MP + 13MP + 5MP, pin 5000 mAh, RAM 6GB, ROM 128GB.', N'https://www.store4u.pk/wp-content/uploads/2021/02/10-t-silver.png', 40)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (35, N'Redmi Note 11 Pro', N'Xiaomi', CAST(7990000.00 AS Decimal(15, 2)), N'Màn hình 6.67 inch AMOLED, chip MediaTek Helio G96, camera 108MP + 8MP + 2MP + 2MP, pin 5000 mAh, RAM 6GB, ROM 128GB.', N'https://didongthongminh.vn/images/products/2024/09/20/original/redmi-note-11-pro-6g-128gb-2.jpg', 35)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (36, N'Redmi Note 11', N'Xiaomi', CAST(4990000.00 AS Decimal(15, 2)), N'Màn hình 6.43 inch AMOLED, chip MediaTek Helio G88, camera 50MP + 8MP + 2MP + 2MP, pin 5000 mAh, RAM 4GB, ROM 64GB.', N'https://www.halomobile.com.vn/images_upload/files/hkhkhk.png', 50)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (37, N'Poco X4 Pro 5G', N'Xiaomi', CAST(6990000.00 AS Decimal(15, 2)), N'Màn hình 6.67 inch AMOLED, chip Snapdragon 695, camera 108MP + 8MP + 2MP, pin 5000 mAh, RAM 8GB, ROM 128GB.', N'https://xiaomi.dstore.vn/storage/product/958/zywjXTKwlwqCjbRVRerxSnf6P8LtBK4JPZoRaoxq.jpg', 30)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (38, N'Poco M4 Pro 5G', N'Xiaomi', CAST(5990000.00 AS Decimal(15, 2)), N'Màn hình 6.43 inch AMOLED, chip MediaTek Dimensity 810, camera 64MP + 8MP + 2MP, pin 5000 mAh, RAM 6GB, ROM 128GB.', N'https://i01.appmifile.com/v1/MI_18455B3E4DA706226CF7535A58E875F0267/pms_1647598279.53174684.png', 40)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (39, N'Poco M3 Pro 5G', N'Xiaomi', CAST(4990000.00 AS Decimal(15, 2)), N'Màn hình 6.5 inch IPS LCD, chip MediaTek Dimensity 700, camera 48MP + 2MP + 2MP, pin 5000 mAh, RAM 4GB, ROM 128GB.', N'https://i01.appmifile.com/webfile/globalimg/POCOpic/M3pro-blue!800x800!85.png', 35)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (40, N'Redmi 10', N'Xiaomi', CAST(3990000.00 AS Decimal(15, 2)), N'Màn hình 6.5 inch IPS LCD, chip MediaTek Helio G88, camera 50MP + 8MP + 2MP + 2MP, pin 5000 mAh, RAM 4GB, ROM 64GB.', N'https://i0.wp.com/www.xiaomi.ie/wp-content/uploads/2021/11/Redmi-10-White.png?fit=800%2C800&ssl=1', 50)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (41, N'Redmi 9T', N'Xiaomi', CAST(3490000.00 AS Decimal(15, 2)), N'Màn hình 6.53 inch IPS LCD, chip Snapdragon 662, camera 48MP + 8MP + 2MP + 2MP, pin 6000 mAh, RAM 4GB, ROM 64GB.', N'https://fonesmart.com.vn/images/products/2021/04/10/large/xiaomi-redmi-note-9t-xanh-la_1618044917.png', 45)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (42, N'Redmi 9A', N'Xiaomi', CAST(1990000.00 AS Decimal(15, 2)), N'Màn hình 6.53 inch IPS LCD, chip MediaTek Helio G25, camera 13MP, pin 5000 mAh, RAM 2GB, ROM 32GB.', N'https://dienmaygiasi.vn/public/uploads/products/2020-07/xiaomi-redmi-9a-2gb-32gb-xanh-la.png', 60)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (43, N'Redmi 9C', N'Xiaomi', CAST(2490000.00 AS Decimal(15, 2)), N'Màn hình 6.53 inch IPS LCD, chip MediaTek Helio G35, camera 13MP + 2MP + 2MP, pin 5000 mAh, RAM 3GB, ROM 64GB.', N'https://daidoangia.vn/Images/product/2008210517-xiaomi-redmi-9c-cam-1.png', 55)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (44, N'Redmi Note 11S', N'Xiaomi', CAST(5990000.00 AS Decimal(15, 2)), N'Màn hình 6.43 inch AMOLED, chip MediaTek Helio G96, camera 108MP + 8MP + 2MP + 2MP, pin 5000 mAh, RAM 6GB, ROM 128GB.', N'https://i01.appmifile.com/v1/MI_18455B3E4DA706226CF7535A58E875F0267/pms_1663749567.48319834.png', 40)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (45, N'Redmi Note 10 Pro', N'Xiaomi', CAST(6990000.00 AS Decimal(15, 2)), N'Màn hình 6.67 inch AMOLED, chip Snapdragon 732G, camera 108MP + 8MP + 5MP + 2MP, pin 5020 mAh, RAM 6GB, ROM 128GB.', N'https://i02.appmifile.com/979_operator_in/12/08/2021/6e2a99cf7decf70d9e58a2871c1f19c0.png', 35)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (46, N'Redmi Note 10', N'Xiaomi', CAST(4990000.00 AS Decimal(15, 2)), N'Màn hình 6.43 inch AMOLED, chip Snapdragon 678, camera 48MP + 8MP + 2MP + 2MP, pin 5000 mAh, RAM 4GB, ROM 64GB.', N'https://i01.appmifile.com/v1/MI_18455B3E4DA706226CF7535A58E875F0267/pms_1615358768.62316673.png', 45)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (47, N'Redmi 10 Prime', N'Xiaomi', CAST(5990000.00 AS Decimal(15, 2)), N'Màn hình 6.5 inch IPS LCD, chip MediaTek Helio G88, camera 50MP + 8MP + 2MP + 2MP, pin 6000 mAh, RAM 6GB, ROM 128GB.', N'https://cdn2.cellphones.com.vn/x/media/catalog/product/p/m/pms_1630575866.41989059.png', 40)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (48, N'Redmi 10C', N'Xiaomi', CAST(2990000.00 AS Decimal(15, 2)), N'Màn hình 6.71 inch IPS LCD, chip Snapdragon 680, camera 13MP + 2MP, pin 5000 mAh, RAM 4GB, ROM 64GB.', N'https://synnexfpt.com/wp-content/uploads/2022/03/xiaomi_redmi_note_10c_azul_02_ad_l.jpg', 50)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (49, N'Redmi Note 11 Pro+', N'Xiaomi', CAST(9990000.00 AS Decimal(15, 2)), N'Màn hình 6.67 inch AMOLED, chip MediaTek Helio G96, camera 108MP + 8MP + 2MP + 2MP, pin 5000 mAh, RAM 8GB, ROM 256GB.', N'https://www.dimprice.co.uk/image/cache/catalog/Xiaomi/redmi-note-11-pro+blue-1-800x800.png', 30)
INSERT [dbo].[Products] ([product_id], [product_name], [brand], [price], [description], [image_url], [stock_quantity]) VALUES (50, N'Galaxy Z Fold4', N'Samsung', CAST(49990000.00 AS Decimal(15, 2)), N'Màn hình chính 7.6 inch, màn hình ngoài 6.2 inch, chip Snapdragon 8+ Gen 1, camera 50MP + 12MP + 10MP, pin 4400 mAh, RAM 12GB, ROM 256GB.', N'https://cellularinc.co.za/wp-content/uploads/2024/01/Samsung-Galaxy-Z-Fold4GG.png', 20)
GO
INSERT [dbo].[Role] ([role_id], [name], [description]) VALUES (1, N'User', N'Regular user')
INSERT [dbo].[Role] ([role_id], [name], [description]) VALUES (2, N'Admin', N'Administrator')
GO
INSERT [dbo].[Users] ([user_id], [username], [email], [password_hash], [full_name], [role_id], [phonenumber], [created_at]) VALUES (1, N'user1', N'user1@example.com', N'password1', N'User One', 1, N'1234567890', CAST(N'2024-11-02T20:26:47.703' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [email], [password_hash], [full_name], [role_id], [phonenumber], [created_at]) VALUES (2, N'user2', N'user2@example.com', N'password2', N'User Two', 1, N'0987654321', CAST(N'2024-11-02T20:26:47.703' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [email], [password_hash], [full_name], [role_id], [phonenumber], [created_at]) VALUES (3, N'user3', N'user3@example.com', N'password3', N'User Three', 1, N'1122334455', CAST(N'2024-11-02T20:26:47.703' AS DateTime))
INSERT [dbo].[Users] ([user_id], [username], [email], [password_hash], [full_name], [role_id], [phonenumber], [created_at]) VALUES (4, N'admin1', N'admin1@example.com', N'adminpassword', N'Admin One', 2, N'5566778899', CAST(N'2024-11-02T20:26:47.703' AS DateTime))
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__AB6E6164495FD8F1]    Script Date: 11/3/2024 9:53:31 AM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__F3DBC572241BD7B9]    Script Date: 11/3/2024 9:53:31 AM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [order_date]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ('Pending') FOR [status]
GO
ALTER TABLE [dbo].[Reviews] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Order_Items]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([order_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Order_Items]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[Users] ([user_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[Role] ([role_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD CHECK  (([quantity]>(0)))
GO
ALTER TABLE [dbo].[Order_Items]  WITH CHECK ADD CHECK  (([price]>=(0)))
GO
ALTER TABLE [dbo].[Order_Items]  WITH CHECK ADD CHECK  (([quantity]>(0)))
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD CHECK  (([total_amount]>=(0)))
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD CHECK  (([price]>=(0)))
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD CHECK  (([stock_quantity]>=(0)))
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD CHECK  (([rating]>=(1) AND [rating]<=(5)))
GO
USE [master]
GO
ALTER DATABASE [PhoneStore] SET  READ_WRITE 
GO
