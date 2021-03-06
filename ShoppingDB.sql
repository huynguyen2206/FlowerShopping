USE [master]
GO
/****** Object:  Database [FlowerShopping]    Script Date: 12/29/2018 10:00:45 AM ******/
CREATE DATABASE [FlowerShopping]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FlowerShopping', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\FlowerShopping.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'FlowerShopping_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\FlowerShopping_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [FlowerShopping] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FlowerShopping].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FlowerShopping] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FlowerShopping] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FlowerShopping] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FlowerShopping] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FlowerShopping] SET ARITHABORT OFF 
GO
ALTER DATABASE [FlowerShopping] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FlowerShopping] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FlowerShopping] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FlowerShopping] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FlowerShopping] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FlowerShopping] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FlowerShopping] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FlowerShopping] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FlowerShopping] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FlowerShopping] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FlowerShopping] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FlowerShopping] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FlowerShopping] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FlowerShopping] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FlowerShopping] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FlowerShopping] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FlowerShopping] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FlowerShopping] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [FlowerShopping] SET  MULTI_USER 
GO
ALTER DATABASE [FlowerShopping] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FlowerShopping] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FlowerShopping] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FlowerShopping] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [FlowerShopping]
GO
/****** Object:  Table [dbo].[Banners]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Banners](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Tittle] [nvarchar](200) NOT NULL,
	[PictureUrl] [varchar](250) NOT NULL,
 CONSTRAINT [PK_Banners] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[TopicId] [int] NOT NULL,
	[ShowHomePage] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Comments]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Comment] [nvarchar](100) NOT NULL,
	[CommentDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Coupons]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Coupons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CouponCode] [varchar](50) NOT NULL,
	[Price] [decimal](18, 0) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Quantity] [int] NOT NULL,
	[RegisterDate] [datetime] NOT NULL,
	[InitDate] [datetime] NOT NULL,
	[FinishDate] [datetime] NOT NULL,
	[UseDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Coupons] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[Phone] [nvarchar](30) NOT NULL,
	[Address] [nvarchar](150) NOT NULL,
	[ImageUrl] [varchar](250) NULL,
	[VIP] [bit] NOT NULL,
	[RegisterToten] [nvarchar](100) NULL,
	[RegisterDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Disables]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Disables](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DisableName] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Disables] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Employees]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employees](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LoginName] [nvarchar](100) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[EmployeeName] [nvarchar](100) NOT NULL,
	[Phone] [varchar](30) NOT NULL,
	[Gender] [nvarchar](50) NULL,
	[Email] [nvarchar](200) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[PictureUrl] [varchar](250) NOT NULL,
	[LevelId] [int] NOT NULL,
	[LastLogin] [datetime] NOT NULL,
	[RegisterDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LevelPermissions]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LevelPermissions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LevelId] [int] NOT NULL,
	[TableName] [nvarchar](50) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[Total] [int] NOT NULL,
 CONSTRAINT [PK_LevelPermissions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Levels]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Levels](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LevelName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Levels] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Likes]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Likes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[IsLike] [bit] NOT NULL,
 CONSTRAINT [PK_Likes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Log_Types]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log_Types](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Log_Type_Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Log_Types] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LoginLogs]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[TimeLogin] [datetime] NOT NULL,
	[IsLogin] [bit] NOT NULL,
 CONSTRAINT [PK_LoginLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Unit] [nvarchar](20) NOT NULL,
	[UnitPrice] [decimal](18, 0) NOT NULL,
	[Quantity] [decimal](18, 0) NOT NULL,
	[Discount] [decimal](18, 0) NOT NULL,
	[Tax] [decimal](18, 0) NOT NULL,
	[DescriptionLong] [ntext] NULL,
	[ImageUrl] [nvarchar](50) NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderCode] [nvarchar](20) NULL,
	[OrderDate] [datetime] NOT NULL,
	[CustomerId] [int] NULL,
	[ShippingId] [int] NULL,
	[Discount] [decimal](18, 0) NOT NULL CONSTRAINT [DF_Orders_Discount_1]  DEFAULT ((0)),
	[Tax] [decimal](18, 0) NOT NULL CONSTRAINT [DF_Orders_Tax_1]  DEFAULT ((0)),
	[ShippingFee] [decimal](18, 0) NOT NULL CONSTRAINT [DF_Orders_ShippingFee_1]  DEFAULT ((0)),
	[PaymentMethodId] [int] NULL,
	[EmployeeId] [int] NULL,
	[Receiver] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[PhoneNumber] [nvarchar](50) NULL,
	[StatusId] [int] NOT NULL,
	[CouponId] [int] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PaymentMethods]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMethods](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MethodName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PaymentMethods] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pictures]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pictures](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[PictureUrl] [varchar](250) NOT NULL,
 CONSTRAINT [PK_Pictures] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product_Logs]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Logs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RegisterDate] [datetime] NOT NULL,
	[ProductId] [int] NOT NULL,
	[ProductPrice] [int] NOT NULL,
	[ProductQuantity] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
 CONSTRAINT [PK_ProductLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Products]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductCode] [varchar](15) NOT NULL,
	[ProductName] [nvarchar](150) NOT NULL,
	[Unit] [nvarchar](20) NOT NULL,
	[UnitPrice] [int] NOT NULL,
	[SalePrice] [int] NOT NULL,
	[Tax] [int] NOT NULL,
	[QuantityAvailable] [int] NOT NULL,
	[DescriptionShort] [ntext] NULL,
	[DescriptionLong] [ntext] NULL,
	[Height] [int] NULL,
	[ShowHomePage] [bit] NOT NULL,
	[VendorId] [int] NOT NULL,
	[View] [int] NOT NULL,
	[PictureUrl] [nvarchar](50) NULL,
	[CreateDate] [datetime] NOT NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Products_Categories_Mapping]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products_Categories_Mapping](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
 CONSTRAINT [PK_Products_Categories_Mapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Shippings]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shippings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ShippingName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](150) NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Shippings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Statuses]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Statuses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Statuses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[System_Logs]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[System_Logs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Log_Type_Id] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[Message] [nvarchar](150) NOT NULL,
	[RegisterDate] [datetime] NOT NULL,
 CONSTRAINT [PK_System_Logs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Topics]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Topics](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TopicName] [nvarchar](80) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Topics] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vendors]    Script Date: 12/29/2018 10:00:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vendors](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[VendorName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Vendors] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (1, N'Hoa Hồng', 3, 1, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (2, N'Hoa Cẩm Chướng', 3, 1, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (3, N'Mới Yêu', 2, 0, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (4, N'Sắp Chia Tay', 2, 0, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (5, N'Bạn Xã Giao', 1, 0, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (6, N'Bạn Tri Kỉ', 1, 1, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (7, N'Gần Ra Đi', 4, 0, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (8, N'Đã Ra Đi', 4, 1, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (9, N'Cây để bàn', 5, 0, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (10, N'Cây Thủy Sinh', 5, 0, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (11, N'Cây Phong Thủy', 5, 1, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[Coupons] ON 

INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (1, N'0', CAST(0 AS Decimal(18, 0)), 0, 0, CAST(N'2001-01-01 00:00:00.000' AS DateTime), CAST(N'2001-01-01 00:00:00.000' AS DateTime), CAST(N'2001-01-01 00:00:00.000' AS DateTime), CAST(N'2001-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (5, N'RBVCEYPYDL', CAST(200000 AS Decimal(18, 0)), 0, 1, CAST(N'2018-11-15 15:28:29.790' AS DateTime), CAST(N'2018-11-15 15:28:29.790' AS DateTime), CAST(N'2018-11-15 15:28:29.790' AS DateTime), CAST(N'2018-11-15 15:28:29.790' AS DateTime))
INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (6, N'QSQTICMORZ', CAST(50000 AS Decimal(18, 0)), 0, 1, CAST(N'2018-11-15 15:29:21.480' AS DateTime), CAST(N'2018-11-15 15:29:21.480' AS DateTime), CAST(N'2018-11-15 15:29:21.480' AS DateTime), CAST(N'2018-11-15 15:29:21.480' AS DateTime))
INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (8, N'AALNMDMXPH', CAST(50000 AS Decimal(18, 0)), 1, 1, CAST(N'2018-11-15 15:29:21.483' AS DateTime), CAST(N'2018-11-15 15:29:21.483' AS DateTime), CAST(N'2018-11-15 15:29:21.483' AS DateTime), CAST(N'2018-11-15 15:29:21.483' AS DateTime))
INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (10, N'FKPHLIYVWQ', CAST(15 AS Decimal(18, 0)), 0, 1, CAST(N'2018-11-16 16:16:17.257' AS DateTime), CAST(N'2018-11-16 16:16:17.257' AS DateTime), CAST(N'2018-11-16 16:16:17.257' AS DateTime), CAST(N'2018-11-16 16:16:17.257' AS DateTime))
INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (11, N'OHJJHRGJUJ', CAST(15 AS Decimal(18, 0)), 1, 1, CAST(N'2018-11-22 19:22:00.897' AS DateTime), CAST(N'2018-11-22 19:22:00.897' AS DateTime), CAST(N'2018-11-22 19:22:00.897' AS DateTime), CAST(N'2018-11-22 19:22:00.897' AS DateTime))
INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (12, N'OZAQVHWMVL', CAST(150000 AS Decimal(18, 0)), 0, 1, CAST(N'2018-11-22 19:22:45.500' AS DateTime), CAST(N'2018-11-22 19:22:45.500' AS DateTime), CAST(N'2018-11-22 19:22:45.500' AS DateTime), CAST(N'2018-11-22 19:22:45.500' AS DateTime))
INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (1019, N'QYQXOUHIUA', CAST(100000 AS Decimal(18, 0)), 1, 1, CAST(N'2018-11-30 17:02:35.020' AS DateTime), CAST(N'2018-11-30 17:02:35.020' AS DateTime), CAST(N'2018-11-30 17:02:35.020' AS DateTime), CAST(N'2018-11-30 17:02:35.020' AS DateTime))
INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (1020, N'FKBZQEQLMO', CAST(100000 AS Decimal(18, 0)), 1, 1, CAST(N'2018-11-30 17:02:35.023' AS DateTime), CAST(N'2018-11-30 17:02:35.023' AS DateTime), CAST(N'2018-11-30 17:02:35.023' AS DateTime), CAST(N'2018-11-30 17:02:35.023' AS DateTime))
INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (1024, N'MSKSJUCUCS', CAST(5 AS Decimal(18, 0)), 1, 1, CAST(N'2018-12-10 10:04:22.937' AS DateTime), CAST(N'2018-12-10 10:04:22.937' AS DateTime), CAST(N'2018-12-10 10:04:22.937' AS DateTime), CAST(N'2018-12-10 10:04:22.937' AS DateTime))
INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (1025, N'ABWLHGWWIV', CAST(5 AS Decimal(18, 0)), 1, 1, CAST(N'2018-12-10 10:04:22.940' AS DateTime), CAST(N'2018-12-10 10:04:22.940' AS DateTime), CAST(N'2018-12-10 10:04:22.940' AS DateTime), CAST(N'2018-12-10 10:04:22.940' AS DateTime))
INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (1026, N'NOVYVYMFYR', CAST(5 AS Decimal(18, 0)), 1, 1, CAST(N'2018-12-10 10:04:22.940' AS DateTime), CAST(N'2018-12-10 10:04:22.940' AS DateTime), CAST(N'2018-12-10 10:04:22.940' AS DateTime), CAST(N'2018-12-10 10:04:22.940' AS DateTime))
INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (1027, N'OYIJZQLIIJ', CAST(5 AS Decimal(18, 0)), 1, 1, CAST(N'2018-12-10 10:04:22.940' AS DateTime), CAST(N'2018-12-10 10:04:22.940' AS DateTime), CAST(N'2018-12-10 10:04:22.940' AS DateTime), CAST(N'2018-12-10 10:04:22.940' AS DateTime))
INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (1028, N'ADIFQAMOOO', CAST(5 AS Decimal(18, 0)), 1, 1, CAST(N'2018-12-10 10:04:22.940' AS DateTime), CAST(N'2018-12-10 10:04:22.940' AS DateTime), CAST(N'2018-12-10 10:04:22.940' AS DateTime), CAST(N'2018-12-10 10:04:22.940' AS DateTime))
SET IDENTITY_INSERT [dbo].[Coupons] OFF
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([Id], [CustomerName], [Email], [Password], [Phone], [Address], [ImageUrl], [VIP], [RegisterToten], [RegisterDate], [IsActive]) VALUES (1, N'Nguyễn Quốc Huy', N'fireangel.huy@gmail.com', N'932f3c1b56257ce8539ac269d7aab42550dacf8818d075f0bdf1990562aae3ef', N'012147241', N'Đà Nẵng', N'product3.jpg', 0, N'44a49d18003a6a25cca60b124ba46815f62f084f1c440bfbee810075b4359f79', CAST(N'2018-10-25 15:28:29.893' AS DateTime), 1)
INSERT [dbo].[Customers] ([Id], [CustomerName], [Email], [Password], [Phone], [Address], [ImageUrl], [VIP], [RegisterToten], [RegisterDate], [IsActive]) VALUES (2, N'Nguyễn Văn A', N'abc@gmail.com', N'932f3c1b56257ce8539ac269d7aab42550dacf8818d075f0bdf1990562aae3ef', N'01214724', N'Đà Nẵng', N'product23.jpg', 0, NULL, CAST(N'2018-11-07 08:39:24.797' AS DateTime), 1)
INSERT [dbo].[Customers] ([Id], [CustomerName], [Email], [Password], [Phone], [Address], [ImageUrl], [VIP], [RegisterToten], [RegisterDate], [IsActive]) VALUES (3, N'Một Ai Đó', N'aido@gmail.com', N'932f3c1b56257ce8539ac269d7aab42550dacf8818d075f0bdf1990562aae3ef', N'0214897456', N'Đà Nẵng', N'product15.jpg', 0, NULL, CAST(N'2018-11-20 09:23:10.997' AS DateTime), 1)
INSERT [dbo].[Customers] ([Id], [CustomerName], [Email], [Password], [Phone], [Address], [ImageUrl], [VIP], [RegisterToten], [RegisterDate], [IsActive]) VALUES (10, N'Âu Dương Phong', N'phongca@gmail.com', N'932f3c1b56257ce8539ac269d7aab42550dacf8818d075f0bdf1990562aae3ef', N'0121472411', N'Tàu', N'product12.jpg', 0, NULL, CAST(N'2018-11-27 10:12:29.813' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Customers] OFF
SET IDENTITY_INSERT [dbo].[Disables] ON 

INSERT [dbo].[Disables] ([Id], [DisableName], [IsActive]) VALUES (1, N'ProductDiscounted', 0)
INSERT [dbo].[Disables] ([Id], [DisableName], [IsActive]) VALUES (2, N'Categories', 0)
INSERT [dbo].[Disables] ([Id], [DisableName], [IsActive]) VALUES (3, N'ProductNew', 0)
INSERT [dbo].[Disables] ([Id], [DisableName], [IsActive]) VALUES (4, N'ProductShowHomePage', 0)
INSERT [dbo].[Disables] ([Id], [DisableName], [IsActive]) VALUES (5, N'ProductOrder', 1)
SET IDENTITY_INSERT [dbo].[Disables] OFF
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([Id], [LoginName], [Password], [EmployeeName], [Phone], [Gender], [Email], [Address], [PictureUrl], [LevelId], [LastLogin], [RegisterDate], [IsActive]) VALUES (4, N'admin', N'admin', N'Nguyễn Quốc Huy', N'025644115', NULL, N'abc@gmail.com', N'da nang', N'product4.jpg', 1, CAST(N'2001-01-01 00:00:00.000' AS DateTime), CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Employees] ([Id], [LoginName], [Password], [EmployeeName], [Phone], [Gender], [Email], [Address], [PictureUrl], [LevelId], [LastLogin], [RegisterDate], [IsActive]) VALUES (5, N'manager', N'manager', N'mot ai do', N'064113412', N'nam', N'aido@gmail.com', N'da nang', N'product12.jpg', 2, CAST(N'2018-12-06 14:05:18.077' AS DateTime), CAST(N'2018-12-06 14:05:18.077' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Employees] OFF
SET IDENTITY_INSERT [dbo].[LevelPermissions] ON 

INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (1, 1, N'Orders', N'Orders Manager', 15)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (2, 1, N'Coupons', N'Coupons Manager', 15)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (4, 1, N'Products', N'Products Manager', 15)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (5, 1, N'Employees', N'Employees Manager', 15)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (6, 1, N'Customers', N'Customers Manager', 15)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (8, 1, N'Categories', N'Categories manager', 15)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (9, 1, N'Shippers', N'Shippers Manager', 15)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (10, 2, N'Orders', N'Orders Manager', 15)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (11, 2, N'Coupons', N'Coupons Manager', 1)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (12, 2, N'Products', N'Products Manager', 7)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (13, 2, N'Employees', N'Employees Manager', 1)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (14, 2, N'Customers', N'Customers Manager', 7)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (15, 2, N'Categories', N'Categories manager', 7)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (16, 2, N'Shippers', N'Shippers Manager', 7)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (17, 3, N'Orders', N'Orders Manager', 3)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (18, 3, N'Coupons', N'Coupons Manager', 0)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (19, 3, N'Products', N'Products Manager', 3)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (20, 3, N'Employees', N'Employees Manager', 0)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (21, 3, N'Customers', N'Customers Manager', 1)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (22, 3, N'Categories', N'Categories manager', 2)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (23, 3, N'Shippers', N'Shippers Manager', 1)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (24, 1, N'Topics', N'Topic Manager', 15)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (25, 2, N'Topics', N'Topic Manager', 7)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (26, 3, N'Topics', N'Topic Manager', 2)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (29, 6, N'Orders', N'Orders Manager', 7)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (30, 6, N'Coupons', N'Coupons Manager', 7)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (31, 6, N'Products', N'Products Manager', 7)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (32, 6, N'Employees', N'Employees Manager', 7)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (33, 6, N'Customers', N'Customers Manager', 7)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (34, 6, N'Categories', N'Categories manager', 7)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (35, 6, N'Shippers', N'Shipper Manager', 7)
INSERT [dbo].[LevelPermissions] ([Id], [LevelId], [TableName], [DisplayName], [Total]) VALUES (36, 6, N'Topics', N'Topics Manager', 7)
SET IDENTITY_INSERT [dbo].[LevelPermissions] OFF
SET IDENTITY_INSERT [dbo].[Levels] ON 

INSERT [dbo].[Levels] ([Id], [LevelName]) VALUES (1, N'Admin')
INSERT [dbo].[Levels] ([Id], [LevelName]) VALUES (2, N'Manager')
INSERT [dbo].[Levels] ([Id], [LevelName]) VALUES (3, N'Seller')
INSERT [dbo].[Levels] ([Id], [LevelName]) VALUES (6, N'chi do')
SET IDENTITY_INSERT [dbo].[Levels] OFF
SET IDENTITY_INSERT [dbo].[Likes] ON 

INSERT [dbo].[Likes] ([Id], [CustomerId], [ProductId], [IsLike]) VALUES (1, 1, 1, 1)
INSERT [dbo].[Likes] ([Id], [CustomerId], [ProductId], [IsLike]) VALUES (2, 2, 1, 1)
INSERT [dbo].[Likes] ([Id], [CustomerId], [ProductId], [IsLike]) VALUES (3, 2, 2, 1)
INSERT [dbo].[Likes] ([Id], [CustomerId], [ProductId], [IsLike]) VALUES (4, 1, 4, 1)
INSERT [dbo].[Likes] ([Id], [CustomerId], [ProductId], [IsLike]) VALUES (5, 1, 2, 1)
INSERT [dbo].[Likes] ([Id], [CustomerId], [ProductId], [IsLike]) VALUES (6, 1, 9, 1)
INSERT [dbo].[Likes] ([Id], [CustomerId], [ProductId], [IsLike]) VALUES (7, 1, 3, 1)
SET IDENTITY_INSERT [dbo].[Likes] OFF
SET IDENTITY_INSERT [dbo].[Log_Types] ON 

INSERT [dbo].[Log_Types] ([Id], [Log_Type_Name]) VALUES (1, N'Create')
INSERT [dbo].[Log_Types] ([Id], [Log_Type_Name]) VALUES (2, N'Edit')
INSERT [dbo].[Log_Types] ([Id], [Log_Type_Name]) VALUES (3, N'Delete')
SET IDENTITY_INSERT [dbo].[Log_Types] OFF
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (1, 1, 1, N'Lãng', CAST(400000 AS Decimal(18, 0)), CAST(2 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product2.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (2, 1, 2, N'Lãng', CAST(700000 AS Decimal(18, 0)), CAST(2 AS Decimal(18, 0)), CAST(200000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product17.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (3, 2, 1, N'Lãng', CAST(400000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product2.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (4, 3, 1, N'Lãng', CAST(400000 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product2.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (5, 4, 1, N'Lãng', CAST(400000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product2.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (6, 4, 2, N'Lãng', CAST(700000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(200000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product17.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (7, 5, 1, N'Lãng', CAST(400000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product2.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (8, 6, 2, N'Lãng', CAST(700000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(200000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product17.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (9, 8, 4, N'Lãng', CAST(2550000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product11.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (11, 8, 1, N'Lãng', CAST(400000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product2.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (12, 10, 2, N'Lãng', CAST(700000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(200000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product1.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (13, 10, 1, N'Lãng', CAST(400000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product3.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (14, 11, 4, N'Lãng', CAST(2550000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product11.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (15, 12, 1, N'Lãng', CAST(400000 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product3.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (16, 13, 4, N'Lãng', CAST(2550000 AS Decimal(18, 0)), CAST(2 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), N'Cuộc sống sinh lão bệnh tử là điều không ai có thể tránh khỏi. Tất cả rồi sẽ trở về với cát bụi mọi thứ đều vô thường. Kệ hoa như sự chia sẽ với nỗi buồn mất mát khi người thân ra đi. Mong người ra đi được thanh thản không còn vương vấn bụi trần.', N'product11.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (17, 14, 2, N'Lãng', CAST(700000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(200000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), N'Tình yêu là thứ cảm xúc đẹp đẽ và mạnh mẽ nhất. Tình yêu cho chúng ta sống giữa mộng mơ và thực tại, cho chúng ta nếm trải đầy đủ cung bậc cảm xúc: Hỉ - nộ - ái - ố. Phức tạp là vậy nhưng nào có ai trách vì mình được yêu quá nhiều bao giờ, người ta chỉ buồn vì chưa tìm ra tình yêu của đời mình mà thôi. Giỏ hoa là lời chúc, là sự tôn vinh cho sự diệu kỳ của tình yêu.', N'product1.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (18, 15, 2, N'Lãng', CAST(700000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(200000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), N'Tình yêu là thứ cảm xúc đẹp đẽ và mạnh mẽ nhất. Tình yêu cho chúng ta sống giữa mộng mơ và thực tại, cho chúng ta nếm trải đầy đủ cung bậc cảm xúc: Hỉ - nộ - ái - ố. Phức tạp là vậy nhưng nào có ai trách vì mình được yêu quá nhiều bao giờ, người ta chỉ buồn vì chưa tìm ra tình yêu của đời mình mà thôi. Giỏ hoa là lời chúc, là sự tôn vinh cho sự diệu kỳ của tình yêu.', N'product1.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (19, 15, 1, N'Lãng', CAST(400000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), N'Màu tím là màu của sự mộng mơ, những giấc mơ chứa đựng nhiều điều tốt đẹp mà chúng ta đang cố gắng xây dựng trong đời thực. Có nhiều dạng giấc mơ nhưng giấc mơ của anh là được thấy em mỗi ngày với nụ cười hạnh phúc trên môi là đủ rồi. My dream - my love', N'product3.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (20, 16, 5, N'Lãng', CAST(600000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), N'Hạnh phúc nhất là khi hai con tim cùng nhịp đâp. Sự trọn vẹn trong tình yêu chỉ có thể xảy ra khi mỗi bên phải biết nhường nhịn nhau. Đừng vì cái tôi của bản thân để rồi hai ta rời xa nhau. Hãy cùng nhau bước đến trọn vẹn yêu thương bên nhau.', N'product20.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (21, 16, 9, N'Lãng', CAST(400000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), N'“Thanh thuần và dịu ngọt, nụ cười của em luôn làm trái tim tôi loạn nhịp.” Người ta vẫn thường nói: tặng hoa cho người yêu thì phải tặng hoa hồng đỏ, vì nó mang ý niệm về một tình yêu nóng bỏng mãnh liệt. Nhưng tôi lại thích tặng em hoa hồng trắng, vì nó gợi nhắc tới nụ cười của em, người làm tôi hạnh phúc mỗi khi nghĩ về. Giỏ hoa “nụ cười của em” là món quà đặc biệt giành tặng riêng em, giành tặng người con gái đáng yêu và trong sáng của tôi.', N'product13.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (1020, 30, 5, N'Lãng', CAST(600000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), N'Hạnh phúc nhất là khi hai con tim cùng nhịp đâp. Sự trọn vẹn trong tình yêu chỉ có thể xảy ra khi mỗi bên phải biết nhường nhịn nhau. Đừng vì cái tôi của bản thân để rồi hai ta rời xa nhau. Hãy cùng nhau bước đến trọn vẹn yêu thương bên nhau.', N'product20.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (1021, 31, 5, N'Lãng', CAST(600000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), N'Hạnh phúc nhất là khi hai con tim cùng nhịp đâp. Sự trọn vẹn trong tình yêu chỉ có thể xảy ra khi mỗi bên phải biết nhường nhịn nhau. Đừng vì cái tôi của bản thân để rồi hai ta rời xa nhau. Hãy cùng nhau bước đến trọn vẹn yêu thương bên nhau.', N'product20.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (1022, 32, 5, N'Lãng', CAST(600000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), N'Hạnh phúc nhất là khi hai con tim cùng nhịp đâp. Sự trọn vẹn trong tình yêu chỉ có thể xảy ra khi mỗi bên phải biết nhường nhịn nhau. Đừng vì cái tôi của bản thân để rồi hai ta rời xa nhau. Hãy cùng nhau bước đến trọn vẹn yêu thương bên nhau.', N'product20.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (1023, 33, 5, N'Lãng', CAST(600000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), N'Hạnh phúc nhất là khi hai con tim cùng nhịp đâp. Sự trọn vẹn trong tình yêu chỉ có thể xảy ra khi mỗi bên phải biết nhường nhịn nhau. Đừng vì cái tôi của bản thân để rồi hai ta rời xa nhau. Hãy cùng nhau bước đến trọn vẹn yêu thương bên nhau.', N'product20.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (2023, 1033, 3, N'Lãng', CAST(400000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), N'Trong cuộc sống anh trải qua rất nhiều áp lực nhưng em có biết không, niềm vui anh có được chính là có em. Có nhiều niềm vui giản đơn là mỗi sớm mai có em trong vòng tay, được ngắm nhìn nụ cười của em cũng đủ xóa tan mệt mỏi trong anh và đó là " Người Tôi Thương "', N'product2.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (2024, 1034, 5, N'Lãng', CAST(600000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), N'Hạnh phúc nhất là khi hai con tim cùng nhịp đâp. Sự trọn vẹn trong tình yêu chỉ có thể xảy ra khi mỗi bên phải biết nhường nhịn nhau. Đừng vì cái tôi của bản thân để rồi hai ta rời xa nhau. Hãy cùng nhau bước đến trọn vẹn yêu thương bên nhau.', N'product20.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (2025, 1035, 12, N'Lãng', CAST(200000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), N'"Memory" với sắc hồng dịu dàng của những đóa cẩm chướng cùng nét chấm phá tinh khôi của những cụm hoa bi trắng ngần, thêm một ít màu xanh của lá. Chỉ vậy thôi, nhưng "Memory" gợi lên biết bao hoài niệm và thương nhớ, những nỗi niềm và cả lòng cảm kích. Và dường như "Memory" là lời cám ơn về những kí ức tốt đẹp. Hoa thích hợp để dành tặng mẹ, tặng những người phụ nữ bạn thương yêu, kính trọng.', N'product14.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (2026, 1036, 5, N'Lãng', CAST(600000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), N'Hạnh phúc nhất là khi hai con tim cùng nhịp đâp. Sự trọn vẹn trong tình yêu chỉ có thể xảy ra khi mỗi bên phải biết nhường nhịn nhau. Đừng vì cái tôi của bản thân để rồi hai ta rời xa nhau. Hãy cùng nhau bước đến trọn vẹn yêu thương bên nhau.', N'product20.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (3026, 2036, 7, N'Lãng', CAST(2000000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(100000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product16.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (3027, 2036, 3, N'Lãng', CAST(400000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product2.jpg')
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (1, N'1856497524', CAST(N'2018-11-01 14:30:48.360' AS DateTime), 1, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, 4, N'Trương Tam Phong', N'Núi Võ Đang', N'025146153', 3, 10)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (2, N'5986472154', CAST(N'2018-11-01 14:32:21.920' AS DateTime), 10, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, 5, N'Dương Quá', N'Cổ Mộ', N'051498465', 3, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (3, N'5599864248', CAST(N'2018-12-02 18:10:25.690' AS DateTime), 1, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, 4, N'Quách Tĩnh', N'Tương Dương', N'0614684165', 4, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (4, N'6597871456', CAST(N'2018-12-04 21:45:34.680' AS DateTime), 3, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, 4, N'Đoàn Dự', N'Đại Lý', N'02548651354', 3, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (5, N'9845613288', CAST(N'2018-12-04 22:28:50.497' AS DateTime), 2, 1, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, 4, N'Tiểu Long Nữ', N'Cổ Mộ', N'02147413', 3, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (6, N'5349864198', CAST(N'2018-12-04 00:47:21.727' AS DateTime), 2, 1, CAST(100000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, 5, N'Trương Vô Kị', N'Ma Giáo', N'025147654', 3, 6)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (8, N'9846153148', CAST(N'2018-12-04 11:10:01.990' AS DateTime), 2, 2, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, 5, N'Hoàng Dược Sư', N'Đào Hoa Đảo', N'0214754115', 3, 5)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (10, N'5684968415', CAST(N'2018-12-05 09:27:15.247' AS DateTime), 3, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, 5, N'Một Ai Đó', N'Đà Nẵng', N'015464153', 3, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (11, N'2584966416', CAST(N'2018-12-05 10:39:30.007' AS DateTime), 3, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, 4, N'dsa', N'đấ', N'sdsa', 3, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (12, N'5496846487', CAST(N'2018-12-06 10:45:34.700' AS DateTime), 1, 2, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, 5, N'dsad', N'ầda', N'1231312', 3, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (13, N'4974861515', CAST(N'2018-12-06 10:57:34.357' AS DateTime), 2, 1, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, 4, N'dsad', N'sadaf', N'sadada', 3, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (14, N'5486941651', CAST(N'2018-12-06 10:59:51.957' AS DateTime), 10, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, 4, N'dfasd', N'ada', N'12313123', 3, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (15, N'9846515635', CAST(N'2018-12-07 11:02:02.913' AS DateTime), 2, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, 5, N'ai do', N'dau do', N'khong biet', 3, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (16, N'6841313155', CAST(N'2018-12-09 19:27:51.173' AS DateTime), 10, 1, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, 5, N'ddsadsa', N'dsa', N'1231', 3, 12)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (30, N'6549845315', CAST(N'2018-12-09 10:37:44.273' AS DateTime), 10, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, 4, N'dsadas', N'dsaf', N'asda', 4, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (31, N'6849842351', CAST(N'2018-12-10 10:39:46.373' AS DateTime), NULL, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, 5, N'ai do', N'khong biet', N'123213131231', 1, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (32, N'3547851945', CAST(N'2018-12-10 16:28:17.220' AS DateTime), 1, 2, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, 4, N'wdq', N'dasd', N'12312', 2, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (33, N'8498416515', CAST(N'2018-12-11 16:25:36.163' AS DateTime), NULL, 1, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, 4, N'dsa', N'dsa', N'12313131', 2, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (1033, N'6113516844', CAST(N'2018-12-11 13:59:33.480' AS DateTime), 1, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, NULL, N'ai do', N'dau do', N'056465163', 1, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (1034, N'2154678416', CAST(N'2018-12-11 14:00:12.200' AS DateTime), NULL, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, NULL, N'khong biet', N'dau do', N'05645124', 1, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (1035, N'7481551654', CAST(N'2018-12-12 17:08:42.800' AS DateTime), 1, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, NULL, N'chịu', N'đâu  đó', N'0251465132', 1, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (1036, N'8965131215', CAST(N'2018-12-13 17:00:27.987' AS DateTime), NULL, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, NULL, N'ai do', N'dau do', N'221321312312', 1, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (2036, N'2218273583', CAST(N'2018-12-26 14:13:06.393' AS DateTime), NULL, 2, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, 4, N'ai do', N'dau do', N'0146841535', 3, 1)
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[PaymentMethods] ON 

INSERT [dbo].[PaymentMethods] ([Id], [MethodName]) VALUES (1, N'Method 1')
INSERT [dbo].[PaymentMethods] ([Id], [MethodName]) VALUES (2, N'Method 2')
SET IDENTITY_INSERT [dbo].[PaymentMethods] OFF
SET IDENTITY_INSERT [dbo].[Pictures] ON 

INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (3, 1, N'product2.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (5, 2, N'product17.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (6, 2, N'product18.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (8, 2, N'product9.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (10, 2, N'product1.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (11, 4, N'product11.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (38, 3, N'product1.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (39, 3, N'product2.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (40, 5, N'product19.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (41, 5, N'product20.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (42, 5, N'product21.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (43, 6, N'product23.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (44, 6, N'product24.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (45, 7, N'product15.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (46, 7, N'product16.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (47, 8, N'product8.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (48, 8, N'product3.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (50, 8, N'product17.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (51, 9, N'product12.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (52, 9, N'product13.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (53, 10, N'product4.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (54, 10, N'product5.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (55, 11, N'product18.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (56, 12, N'product14.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (57, 13, N'product4.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (58, 13, N'product5.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (59, 14, N'product15.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (61, 1, N'product4.jpg')
SET IDENTITY_INSERT [dbo].[Pictures] OFF
SET IDENTITY_INSERT [dbo].[Product_Logs] ON 

INSERT [dbo].[Product_Logs] ([Id], [RegisterDate], [ProductId], [ProductPrice], [ProductQuantity], [EmployeeId]) VALUES (1, CAST(N'2018-11-04 10:37:13.260' AS DateTime), 1, 300000, 10, 4)
INSERT [dbo].[Product_Logs] ([Id], [RegisterDate], [ProductId], [ProductPrice], [ProductQuantity], [EmployeeId]) VALUES (2, CAST(N'2018-11-04 10:37:27.227' AS DateTime), 1, 300000, 5, 4)
INSERT [dbo].[Product_Logs] ([Id], [RegisterDate], [ProductId], [ProductPrice], [ProductQuantity], [EmployeeId]) VALUES (3, CAST(N'2018-12-04 10:37:44.027' AS DateTime), 2, 550000, 7, 4)
INSERT [dbo].[Product_Logs] ([Id], [RegisterDate], [ProductId], [ProductPrice], [ProductQuantity], [EmployeeId]) VALUES (4, CAST(N'2018-12-04 10:37:57.670' AS DateTime), 2, 550000, 5, 4)
INSERT [dbo].[Product_Logs] ([Id], [RegisterDate], [ProductId], [ProductPrice], [ProductQuantity], [EmployeeId]) VALUES (6, CAST(N'2018-12-04 11:23:17.253' AS DateTime), 1, 300000, 5, 4)
INSERT [dbo].[Product_Logs] ([Id], [RegisterDate], [ProductId], [ProductPrice], [ProductQuantity], [EmployeeId]) VALUES (7, CAST(N'2018-12-10 16:07:48.827' AS DateTime), 3, 350000, 10, 4)
INSERT [dbo].[Product_Logs] ([Id], [RegisterDate], [ProductId], [ProductPrice], [ProductQuantity], [EmployeeId]) VALUES (8, CAST(N'2018-12-10 16:55:35.553' AS DateTime), 6, 1000000, 10, 4)
INSERT [dbo].[Product_Logs] ([Id], [RegisterDate], [ProductId], [ProductPrice], [ProductQuantity], [EmployeeId]) VALUES (9, CAST(N'2018-12-12 16:19:36.527' AS DateTime), 4, 2000000, 10, 4)
INSERT [dbo].[Product_Logs] ([Id], [RegisterDate], [ProductId], [ProductPrice], [ProductQuantity], [EmployeeId]) VALUES (10, CAST(N'2018-12-12 16:19:56.813' AS DateTime), 5, 450000, 10, 4)
INSERT [dbo].[Product_Logs] ([Id], [RegisterDate], [ProductId], [ProductPrice], [ProductQuantity], [EmployeeId]) VALUES (11, CAST(N'2018-12-12 16:20:22.807' AS DateTime), 9, 350000, 15, 4)
INSERT [dbo].[Product_Logs] ([Id], [RegisterDate], [ProductId], [ProductPrice], [ProductQuantity], [EmployeeId]) VALUES (12, CAST(N'2018-12-13 11:38:09.037' AS DateTime), 8, 1200000, 5, 4)
SET IDENTITY_INSERT [dbo].[Product_Logs] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [ProductCode], [ProductName], [Unit], [UnitPrice], [SalePrice], [Tax], [QuantityAvailable], [DescriptionShort], [DescriptionLong], [Height], [ShowHomePage], [VendorId], [View], [PictureUrl], [CreateDate], [IsActive]) VALUES (1, N'TY_01', N'HOA TÌNH YÊU - MY DREAM', N'lãng', 400000, 50000, 0, 5, N'Màu tím là màu của sự mộng mơ, những giấc mơ chứa đựng nhiều điều tốt đẹp mà chúng ta đang cố gắng xây dựng trong đời thực. Có nhiều dạng giấc mơ nhưng giấc mơ của anh là được thấy em mỗi ngày với nụ cười hạnh phúc trên môi là đủ rồi. My dream - my love', N'<p><strong>Giỏ hoa tươi&nbsp;</strong>My Dream gồm c&aacute;c loại hoa tươi:</p>

<p>- 8 hoa hồng t&iacute;m</p>

<p>- Hoa hồng da</p>

<p>- C&aacute;t tường trắng</p>

<p>- Cẩm chướng hồng</p>

<p>- Cỏ n&uacute;t ( theo m&ugrave;a ) / baby</p>

<p>- Hoa l&aacute; phụ kh&aacute;c</p>
', NULL, 0, 1, 3, N'product4.jpg', CAST(N'2001-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Products] ([Id], [ProductCode], [ProductName], [Unit], [UnitPrice], [SalePrice], [Tax], [QuantityAvailable], [DescriptionShort], [DescriptionLong], [Height], [ShowHomePage], [VendorId], [View], [PictureUrl], [CreateDate], [IsActive]) VALUES (2, N'TY_02', N'HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', N'lãng', 700000, 200000, 0, 8, N'Tình yêu là thứ cảm xúc đẹp đẽ và mạnh mẽ nhất. Tình yêu cho chúng ta sống giữa mộng mơ và thực tại, cho chúng ta nếm trải đầy đủ cung bậc cảm xúc: Hỉ - nộ - ái - ố. Phức tạp là vậy nhưng nào có ai trách vì mình được yêu quá nhiều bao giờ, người ta chỉ buồn vì chưa tìm ra tình yêu của đời mình mà thôi. Giỏ hoa là lời chúc, là sự tôn vinh cho sự diệu kỳ của tình yêu.', N'<p><strong>Giỏ hoa tươi&nbsp;</strong>T&igrave;nh Y&ecirc;u Diệu Kỳ gồm c&aacute;c loại hoa:</p>

<p>- 20 hồng v&agrave;ng</p>

<p>- Hoa thủy ti&ecirc;n v&agrave;ng</p>

<p>- Salem/ thạch thảo/ mimi trắng</p>

<p>- Hoa l&aacute; phụ kh&aacute;c</p>
', NULL, 1, 1, 0, N'product9.jpg', CAST(N'2001-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Products] ([Id], [ProductCode], [ProductName], [Unit], [UnitPrice], [SalePrice], [Tax], [QuantityAvailable], [DescriptionShort], [DescriptionLong], [Height], [ShowHomePage], [VendorId], [View], [PictureUrl], [CreateDate], [IsActive]) VALUES (3, N'TY_03', N'HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', N'lãng', 400000, 0, 0, 5, N'Trong cuộc sống anh trải qua rất nhiều áp lực nhưng em có biết không, niềm vui anh có được chính là có em. Có nhiều niềm vui giản đơn là mỗi sớm mai có em trong vòng tay, được ngắm nhìn nụ cười của em cũng đủ xóa tan mệt mỏi trong anh và đó là " Người Tôi Thương "', N'<p><strong>Giỏ hoa tươi&nbsp;</strong>Người T&ocirc;i Thương gồm c&aacute;c loại hoa:</p>

<p>- Hoa hồng trắng</p>

<p>- Hoa hồng da</p>

<p>- C&aacute;t tường trắng</p>

<p>- Hoa baby</p>

<p>- Hoa l&aacute; phụ kh&aacute;c</p>
', NULL, 1, 3, 4, N'product2.jpg', CAST(N'2001-01-01 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Products] ([Id], [ProductCode], [ProductName], [Unit], [UnitPrice], [SalePrice], [Tax], [QuantityAvailable], [DescriptionShort], [DescriptionLong], [Height], [ShowHomePage], [VendorId], [View], [PictureUrl], [CreateDate], [IsActive]) VALUES (4, N'CB_01', N'HOA CHIA BUỒN - KIẾP VÔ THƯỜNG', N'Kệ', 2550000, 50000, 0, 3, N'Cuộc sống sinh lão bệnh tử là điều không ai có thể tránh khỏi. Tất cả rồi sẽ trở về với cát bụi mọi thứ đều vô thường. Kệ hoa như sự chia sẽ với nỗi buồn mất mát khi người thân ra đi. Mong người ra đi được thanh thản không còn vương vấn bụi trần.', N'<p><strong>Kệ chia buồn&nbsp;</strong>Kiếp V&ocirc; Thường gồm c&aacute;c loại hoa tươi:</p>

<p>- Hoa hồng trắng</p>

<p>- Hoa hồng da</p>

<p>- C&aacute;t tường trắng</p>

<p>- Đồng tiền trắng</p>

<p>- Hoa l&aacute; phụ kh&aacute;c</p>
', NULL, 0, 2, 0, N'product11.jpg', CAST(N'2018-11-10 10:58:15.000' AS DateTime), NULL)
INSERT [dbo].[Products] ([Id], [ProductCode], [ProductName], [Unit], [UnitPrice], [SalePrice], [Tax], [QuantityAvailable], [DescriptionShort], [DescriptionLong], [Height], [ShowHomePage], [VendorId], [View], [PictureUrl], [CreateDate], [IsActive]) VALUES (5, N'HH-01', N'HOA HỒNG - TRỌN VẸN BÊN NHAU', N'lãng', 600000, 0, 0, 15, N'Hạnh phúc nhất là khi hai con tim cùng nhịp đâp. Sự trọn vẹn trong tình yêu chỉ có thể xảy ra khi mỗi bên phải biết nhường nhịn nhau. Đừng vì cái tôi của bản thân để rồi hai ta rời xa nhau. Hãy cùng nhau bước đến trọn vẹn yêu thương bên nhau.', N'<p><strong>Hộp hoa&nbsp;</strong>Trọn Vẹn B&ecirc;n Nhau gồm c&aacute;c loại hoa tươi:</p>

<p>- Hoa hồng trứng g&agrave;</p>

<p>- Hoa hồng da</p>

<p>- C&aacute;t tường xanh</p>

<p>- Cẩm chướng trắng</p>

<p>- Hoa l&aacute; phụ kh&aacute;c</p>
', NULL, 1, 2, 10, N'product20.jpg', CAST(N'2018-11-20 22:03:00.000' AS DateTime), NULL)
INSERT [dbo].[Products] ([Id], [ProductCode], [ProductName], [Unit], [UnitPrice], [SalePrice], [Tax], [QuantityAvailable], [DescriptionShort], [DescriptionLong], [Height], [ShowHomePage], [VendorId], [View], [PictureUrl], [CreateDate], [IsActive]) VALUES (6, N'HH-02', N'HOA HỒNG - YÊU THƯƠNG DỊU DÀNG', N'Giỏ', 1200000, 150000, 0, 8, N'Trên thế gian này chẳng có gì là hoàn mỹ, càng không tồn tại một người thực sự hoàn hảo, thế nhưng, dưới đôi mắt bao dung của một trái tim yêu thương chân thành, mọi khiếm khuyết đều trở nên toàn vẹn đến kỳ lạ. Chẳng có tình yêu nào vĩnh cửu chỉ có những giây phút vĩnh cửu của tình yêu. Hãy trân trọng những giây phút đó nhé.', N'<p><strong>Hộp hoa&nbsp;</strong>Y&ecirc;u Thương Dịu D&agrave;ng gồm c&aacute;c loại hoa tươi:</p>

<p>- 20 Hoa hồng t&iacute;m</p>

<p>- 20 Hoa hồng sen</p>

<p>- 20 Hoa hồng da</p>

<p>- 20 b&ocirc;ng C&aacute;t tường hồng viền</p>

<p>- Cẩm chướng hồng v&agrave; hoa l&aacute; phụ kh&aacute;c</p>
', NULL, 0, 3, 0, N'product24.jpg', CAST(N'2018-11-20 22:07:11.000' AS DateTime), NULL)
INSERT [dbo].[Products] ([Id], [ProductCode], [ProductName], [Unit], [UnitPrice], [SalePrice], [Tax], [QuantityAvailable], [DescriptionShort], [DescriptionLong], [Height], [ShowHomePage], [VendorId], [View], [PictureUrl], [CreateDate], [IsActive]) VALUES (7, N'HH-03', N'HOA HỒNG - KHÚC CA KHẢI HOÀN', N'Kệ', 2000000, 100000, 0, 10, N'Khúc ca dùng để hát mừng chiến thắng khi đạt được những thành công nhất định. Kệ hoa tone vàng rực rỡ càng tôn lên thêm giá trị của sự thành công đó. Ngày mà bạn được ăn mừng chiến thắng với những người bạn đồng hành cùng với những người thân yêu cùng chúc cho mình', N'<p><strong>Kệ ch&uacute;c mừng&nbsp;</strong>Kh&uacute;c Ca Khải Ho&agrave;n gồm c&aacute;c loại hoa tươi:</p>

<p>- Hoa ly v&agrave;ng</p>

<p>- Hoa hồng v&agrave;ng</p>

<p>- Hoa hồng trứng g&agrave;</p>

<p>- Hoa m&otilde;m s&oacute;i</p>

<p>- Hoa lan v&agrave;ng</p>

<p>- Lan vũ nữ</p>

<p>- Hoa l&aacute; phụ kh&aacute;c</p>
', NULL, 1, 2, 0, N'product16.jpg', CAST(N'2018-11-21 22:10:37.690' AS DateTime), 1)
INSERT [dbo].[Products] ([Id], [ProductCode], [ProductName], [Unit], [UnitPrice], [SalePrice], [Tax], [QuantityAvailable], [DescriptionShort], [DescriptionLong], [Height], [ShowHomePage], [VendorId], [View], [PictureUrl], [CreateDate], [IsActive]) VALUES (8, N'HH-04', N'HOA HỒNG - BELIVE YOURSELF', N'Kệ', 1500000, 100000, 0, 5, N'Bất cứ bạn làm việc gì thì cũng cần có sự tự tin. Tin vào bản thân mình sẽ là điều đầu tiên cần phải làm. Tin vào bạn bè, tin vào đồng nghiệp, tin vào những người thân yên. Chỉ vậy thì bạn mới có thể phát triển sự nghiệp ngày càng phát triển được', N'<p><strong>Kệ ch&uacute;c mừng&nbsp;</strong>Belive YourSelf gồm c&aacute;c loại hoa tươi:</p>

<p>- Hoa đồng tiền v&agrave;ng - đỏ</p>

<p>- Hoa hồng v&agrave;ng - đỏ</p>

<p>- Hoa hạnh ph&uacute;c</p>

<p>- Hoa lan v&agrave;ng</p>

<p>- Hoa l&aacute; phụ kh&aacute;c</p>
', NULL, 0, 2, 0, N'product8.jpg', CAST(N'2018-11-21 22:12:11.000' AS DateTime), NULL)
INSERT [dbo].[Products] ([Id], [ProductCode], [ProductName], [Unit], [UnitPrice], [SalePrice], [Tax], [QuantityAvailable], [DescriptionShort], [DescriptionLong], [Height], [ShowHomePage], [VendorId], [View], [PictureUrl], [CreateDate], [IsActive]) VALUES (9, N'HH_05', N'HOA HỒNG - NỤ CƯỜI CỦA EM', N'lãng', 500000, 50000, 0, 12, N'“Thanh thuần và dịu ngọt, nụ cười của em luôn làm trái tim tôi loạn nhịp.” Người ta vẫn thường nói: tặng hoa cho người yêu thì phải tặng hoa hồng đỏ, vì nó mang ý niệm về một tình yêu nóng bỏng mãnh liệt. Nhưng tôi lại thích tặng em hoa hồng trắng, vì nó gợi nhắc tới nụ cười của em, người làm tôi hạnh phúc mỗi khi nghĩ về. Giỏ hoa “nụ cười của em” là món quà đặc biệt giành tặng riêng em, giành tặng người con gái đáng yêu và trong sáng của tôi.', N'<p>Giỏ hoa &quot;Nụ cười của em&quot; được thiết kế từ c&aacute;c loại hoa:</p>

<p>- Hoa hồng trắng</p>

<p>- Hoa c&uacute;c trắng</p>

<p>- C&aacute;c loại hoa l&aacute; phụ kh&aacute;c</p>

<p>- Giỏ m&acirc;y, k&iacute;ch thước: ngang 20cm, cao 35cm (tay cầm)</p>
', NULL, 1, 2, 0, N'product13.jpg', CAST(N'2018-11-21 22:43:14.000' AS DateTime), NULL)
INSERT [dbo].[Products] ([Id], [ProductCode], [ProductName], [Unit], [UnitPrice], [SalePrice], [Tax], [QuantityAvailable], [DescriptionShort], [DescriptionLong], [Height], [ShowHomePage], [VendorId], [View], [PictureUrl], [CreateDate], [IsActive]) VALUES (10, N'CC-01', N'HOA CẨM CHƯỚNG - TUỔI HỒNG', N'Bó', 1000000, 0, 0, 10, N'"Tuổi hồng" mang đến cho người nhìn với biết bao cảm nhận về sự ngây thơ, dịu dàng và tươi mới của thời thanh xuân thiếu nữ. Hệt như những giấc mơ ngọt ngào và đầy lãng mạn, sáng trong.', N'<p>B&igrave;nh hoa &quot;Tuổi hồng&quot; được thiết kế từ:</p>

<p>- Hoa hồng da&nbsp;</p>

<p>- C&aacute;c loại hoa l&aacute; phụ c&oacute; sẵn tại shop.&nbsp;</p>

<p>- B&igrave;nh thủy tinh.</p>
', NULL, 1, 3, 0, N'product4.jpg', CAST(N'2018-11-22 22:50:15.953' AS DateTime), 1)
INSERT [dbo].[Products] ([Id], [ProductCode], [ProductName], [Unit], [UnitPrice], [SalePrice], [Tax], [QuantityAvailable], [DescriptionShort], [DescriptionLong], [Height], [ShowHomePage], [VendorId], [View], [PictureUrl], [CreateDate], [IsActive]) VALUES (11, N'CC-02', N'HOA CẨM CHƯỚNG - NHỮNG NGÀY MỘNG MƠ', N'Bó', 500000, 0, 0, 16, N'Mang màu tím hồng dịu dàng, bó hoa như gợi ta nhớ đến những ngày mộng mơ, ta đợi chờ nhau trên đường về. Một chiều mùa hạ ta chở nhau, nụ cười trên môi hòa với nắng. Bó hoa thích hợp dành tặng sinh nhật, kỉ niệm, v.v…', N'<p>B&oacute; hoa được thiết kế từ:</p>

<p>-&nbsp;Hoa hồng t&iacute;m</p>

<p>- Hoa hồng da</p>

<p>- Hoa cẩm chướng</p>

<p>- Hoa l&aacute; phụ kh&aacute;c</p>
', NULL, 0, 2, 0, N'product18.jpg', CAST(N'2018-11-22 22:52:01.587' AS DateTime), 1)
INSERT [dbo].[Products] ([Id], [ProductCode], [ProductName], [Unit], [UnitPrice], [SalePrice], [Tax], [QuantityAvailable], [DescriptionShort], [DescriptionLong], [Height], [ShowHomePage], [VendorId], [View], [PictureUrl], [CreateDate], [IsActive]) VALUES (12, N'CC-03', N'HOA CẨM CHƯỚNG - SWEET MEMORY', N'Bó', 200000, 0, 0, 8, N'"Memory" với sắc hồng dịu dàng của những đóa cẩm chướng cùng nét chấm phá tinh khôi của những cụm hoa bi trắng ngần, thêm một ít màu xanh của lá. Chỉ vậy thôi, nhưng "Memory" gợi lên biết bao hoài niệm và thương nhớ, những nỗi niềm và cả lòng cảm kích. Và dường như "Memory" là lời cám ơn về những kí ức tốt đẹp. Hoa thích hợp để dành tặng mẹ, tặng những người phụ nữ bạn thương yêu, kính trọng.', N'<p>- Hoa cẩm chướng hồng</p>

<p>- Hoa bi trắng</p>

<p>- L&aacute; phụ</p>

<p>- Phụ liệu kh&aacute;c</p>
', NULL, 0, 3, 0, N'product14.jpg', CAST(N'2018-11-23 22:53:10.573' AS DateTime), 1)
INSERT [dbo].[Products] ([Id], [ProductCode], [ProductName], [Unit], [UnitPrice], [SalePrice], [Tax], [QuantityAvailable], [DescriptionShort], [DescriptionLong], [Height], [ShowHomePage], [VendorId], [View], [PictureUrl], [CreateDate], [IsActive]) VALUES (13, N'CC-04', N'HOA CẨM CHƯỚNG - CHÂN TRỜI XANH', N'Chậu', 500000, 0, 0, 10, N'Ta muốn bay cao, ta muốn bay xa, bay đến nơi chân trời xanh nơi chứa đựng niềm hy vọng và niềm tin vào những thành công trong tương lai mà ta đã từng mong ước. Màu xanh của sự tươi mới, của năm tháng tuổi trẻ bay nhảy, vây vùng tìm đến thành công ở những chân trời mới', N'<p><strong>Chậu hoa tươi&nbsp;</strong>Ch&acirc;n Trời Xanh gồm c&aacute;c loại hoa:</p>

<p>- C&aacute;t tường xanh</p>

<p>- Cẩm chướng v&agrave;ng</p>

<p>- Hoa m&otilde;m s&oacute;i</p>

<p>- Lan vũ nữ</p>

<p>- Hoa l&aacute; phụ kh&aacute;c</p>

<p>- Chậu gốm cao cấp</p>
', NULL, 1, 2, 0, N'product5.jpg', CAST(N'2018-11-23 22:56:14.990' AS DateTime), 1)
INSERT [dbo].[Products] ([Id], [ProductCode], [ProductName], [Unit], [UnitPrice], [SalePrice], [Tax], [QuantityAvailable], [DescriptionShort], [DescriptionLong], [Height], [ShowHomePage], [VendorId], [View], [PictureUrl], [CreateDate], [IsActive]) VALUES (14, N'CC-05', N'HOA CẨM CHƯỚNG - GIỌT NẮNG BÊN THỀM', N'Bình', 1100000, 100000, 0, 10, N'Được thiết kế với tông màu vàng chủ đạo, bình hoa "Giọt nắng bên thềm" mang đến vẻ đẹp lung linh và tràn đầy sức sống. Kết hợp từ hoa hướng dương, cẩm chướng và lan vũ nữ, mẫu hoa sẽ là món quà tuyệt vời dành tặng những người thân yêu của bạn.', N'<p>B&igrave;nh hoa &quot;Giọt nắng b&ecirc;n thềm&quot; gồm:</p>

<p>- Hoa hướng dương</p>

<p>- Hoa cẩm chướng</p>

<p>- Hoa lan vũ nữ</p>

<p>- Hoa l&aacute; phụ</p>

<p>- B&igrave;nh thủy tinh</p>
', NULL, 1, 3, 0, N'product15.jpg', CAST(N'2018-11-23 22:59:28.283' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Products] OFF
SET IDENTITY_INSERT [dbo].[Products_Categories_Mapping] ON 

INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (35, 4, 8)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (40, 5, 1)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (43, 7, 1)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (44, 8, 1)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (47, 10, 2)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (48, 11, 2)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (49, 12, 2)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (50, 13, 2)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (51, 14, 2)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (55, 3, 6)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (2080, 2, 3)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (2081, 6, 1)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (2082, 9, 1)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (2083, 9, 3)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (2084, 1, 3)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (2085, 1, 6)
SET IDENTITY_INSERT [dbo].[Products_Categories_Mapping] OFF
SET IDENTITY_INSERT [dbo].[Shippings] ON 

INSERT [dbo].[Shippings] ([Id], [ShippingName], [Email], [Phone], [Address], [IsActive]) VALUES (1, N'Trần 2 cử', N'2cu@gmail.com', N'0214756414', N'Đà Nẵng', 0)
INSERT [dbo].[Shippings] ([Id], [ShippingName], [Email], [Phone], [Address], [IsActive]) VALUES (2, N'Nguyễn Văn Sáu Hai', N'62@gmail.com', N'0215489465', N'Nam Cao', 1)
SET IDENTITY_INSERT [dbo].[Shippings] OFF
SET IDENTITY_INSERT [dbo].[Statuses] ON 

INSERT [dbo].[Statuses] ([Id], [StatusName]) VALUES (1, N'Đang Chờ')
INSERT [dbo].[Statuses] ([Id], [StatusName]) VALUES (2, N'Đang Vận Chuyển')
INSERT [dbo].[Statuses] ([Id], [StatusName]) VALUES (3, N'Đã Xong')
INSERT [dbo].[Statuses] ([Id], [StatusName]) VALUES (4, N'Đã Hủy')
SET IDENTITY_INSERT [dbo].[Statuses] OFF
SET IDENTITY_INSERT [dbo].[System_Logs] ON 

INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1, 1, 4, N'Create new product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-09 11:08:32.617' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (2, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-11-09 15:36:40.167' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (3, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-09 15:49:42.600' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (4, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-11-09 16:02:07.140' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (5, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-09 16:02:10.603' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (6, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-11-09 16:08:52.403' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (7, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-09 16:11:56.007' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (8, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-09 16:18:38.750' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (9, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-09 16:18:44.437' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (10, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-09 16:38:18.797' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (11, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-09 16:38:34.537' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (12, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-09 16:38:42.680' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (13, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-09 16:38:47.000' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (14, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-09 16:38:49.017' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (15, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-09 16:39:04.367' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (16, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-09 16:39:10.877' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (17, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-09 16:40:13.127' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (18, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-09 16:40:28.257' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (19, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-09 16:41:00.023' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (20, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-09 16:45:19.843' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (21, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-09 16:45:33.133' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (22, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-09 16:48:19.507' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (23, 2, 4, N'Edit a product: dasda', CAST(N'2018-11-09 16:56:06.407' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (24, 2, 4, N'Edit a product: dasda', CAST(N'2018-11-09 16:56:12.047' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (25, 3, 4, N'Delete a product: dasda', CAST(N'2018-11-09 17:02:22.970' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (26, 1, 4, N'Create new product: HOA CHIA BUỒN - KIẾP VÔ THƯỜNG', CAST(N'2018-11-10 10:58:15.760' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (27, 1, 4, N'Create new product: chi do', CAST(N'2018-11-13 18:07:38.997' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (28, 3, 4, N'Delete a product: chi do', CAST(N'2018-11-13 18:19:11.120' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (29, 1, 4, N'Create new product: dsadưqqwd', CAST(N'2018-11-16 00:16:51.950' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (30, 2, 4, N'Edit a product: dsadưqqwd', CAST(N'2018-11-16 00:29:15.030' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (31, 2, 4, N'Edit a product: dsadưqqwd', CAST(N'2018-11-16 09:05:36.053' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (32, 2, 4, N'Edit a product: dsadưqqwd', CAST(N'2018-11-16 09:07:21.910' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (33, 2, 4, N'Edit a product: dsadưqqwd', CAST(N'2018-11-16 09:10:18.713' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (34, 2, 4, N'Edit a product: dsadưqqwd', CAST(N'2018-11-16 09:14:08.927' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (35, 2, 4, N'Edit a product: dsadưqqwd', CAST(N'2018-11-16 09:14:24.207' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (36, 2, 4, N'Edit a product: dsadưqqwd', CAST(N'2018-11-16 09:14:29.580' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (37, 2, 4, N'Edit a product: dsadưqqwd', CAST(N'2018-11-16 09:16:01.753' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (38, 2, 4, N'Edit a product: dsadưqqwd', CAST(N'2018-11-16 09:29:33.513' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (39, 2, 4, N'Edit a product: dsadưqqwd', CAST(N'2018-11-16 09:29:41.750' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (40, 2, 4, N'Edit a product: dsadưqqwd', CAST(N'2018-11-16 09:29:58.967' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (41, 2, 4, N'Edit a product: dsadưqqwd', CAST(N'2018-11-16 09:30:29.633' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (42, 2, 4, N'Edit a product: dsadưqqwd', CAST(N'2018-11-16 09:30:34.560' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (43, 3, 4, N'Delete a product: dsadưqqwd', CAST(N'2018-11-16 09:34:03.063' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (44, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-16 09:44:56.250' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (45, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-16 09:48:16.410' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (46, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-16 09:48:56.867' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (47, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-16 09:49:15.990' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (48, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-16 09:51:33.997' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (49, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-16 09:57:18.550' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (50, 1, 4, N'Create new Category: chi do', CAST(N'2018-11-19 14:59:39.360' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (51, 1, 4, N'Create new product: HOA HỒNG - TRỌN VẸN BÊN NHAU', CAST(N'2018-11-21 22:03:01.463' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (52, 1, 4, N'Create new product: HOA HỒNG - YÊU THƯƠNG DỊU DÀNG', CAST(N'2018-11-21 22:07:11.233' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (53, 1, 4, N'Create new product: HOA HỒNG - KHÚC CA KHẢI HOÀN', CAST(N'2018-11-21 22:10:37.697' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (54, 1, 4, N'Create new product: HOA HỒNG - BELIVE YOURSELF', CAST(N'2018-11-21 22:12:11.950' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (55, 2, 4, N'Edit a product: HOA HỒNG - BELIVE YOURSELF', CAST(N'2018-11-21 22:12:52.710' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (56, 2, 4, N'Edit a product: HOA HỒNG - BELIVE YOURSELF', CAST(N'2018-11-21 22:13:34.503' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (57, 2, 4, N'Edit a product: HOA HỒNG - BELIVE YOURSELF', CAST(N'2018-11-21 22:21:18.187' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (58, 2, 4, N'Edit a product: HOA HỒNG - BELIVE YOURSELF', CAST(N'2018-11-21 22:25:12.870' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (59, 2, 4, N'Edit a product: HOA HỒNG - BELIVE YOURSELF', CAST(N'2018-11-21 22:25:26.350' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (60, 2, 4, N'Edit a product: HOA HỒNG - BELIVE YOURSELF', CAST(N'2018-11-21 22:25:34.537' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (61, 2, 4, N'Edit a product: HOA TÌNH YÊU - MY DREAM', CAST(N'2018-11-21 22:30:14.367' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (62, 1, 4, N'Create new product: HOA HỒNG - NỤ CƯỜI CỦA EM', CAST(N'2018-11-21 22:43:14.567' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (63, 1, 4, N'Create new Category: Sinh Nhật Người Yêu', CAST(N'2018-11-21 22:45:34.490' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (64, 1, 4, N'Create new product: HOA CẨM CHƯỚNG - TUỔI HỒNG', CAST(N'2018-11-21 22:50:15.987' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (65, 1, 4, N'Create new product: HOA CẨM CHƯỚNG - NHỮNG NGÀY MỘNG MƠ', CAST(N'2018-11-21 22:52:01.623' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (66, 1, 4, N'Create new product: HOA CẨM CHƯỚNG - SWEET MEMORY', CAST(N'2018-11-21 22:53:10.627' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (67, 1, 4, N'Create new product: HOA CẨM CHƯỚNG - CHÂN TRỜI XANH', CAST(N'2018-11-21 22:56:15.017' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (68, 1, 4, N'Create new product: HOA CẨM CHƯỚNG - GIỌT NẮNG BÊN THỀM', CAST(N'2018-11-21 22:59:28.350' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (69, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-22 15:00:08.787' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (70, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-22 15:00:21.597' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (71, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-22 15:00:27.263' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (72, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-22 15:00:42.020' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (73, 2, 4, N'Edit a product: HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', CAST(N'2018-11-22 15:01:44.267' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (74, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-11-22 15:05:36.183' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (75, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-11-22 15:05:45.377' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (76, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-11-22 15:05:59.717' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (77, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-11-22 15:06:05.297' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (78, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-11-22 15:06:08.630' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (79, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-11-22 15:06:21.057' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (80, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-11-22 15:07:59.000' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (81, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-11-22 15:08:05.317' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (82, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-11-22 15:08:08.883' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (83, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-11-22 15:08:46.093' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (84, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-11-22 15:08:52.530' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (85, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-11-22 15:09:30.307' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (86, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-11-22 15:14:02.127' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (87, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-11-22 15:14:06.307' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (88, 1, 4, N'Create new product: chi do', CAST(N'2018-11-22 15:45:46.667' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (89, 3, 4, N'Delete a product: chi do', CAST(N'2018-11-22 15:46:54.897' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (90, 2, 4, N'Edit a product: HOA TÌNH YÊU - MY DREAM', CAST(N'2018-11-22 19:18:21.840' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (91, 2, 4, N'Edit a product: HOA TÌNH YÊU - MY DREAM', CAST(N'2018-11-22 23:30:10.637' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1091, 2, 4, N'Edit a product: HOA HỒNG - NỤ CƯỜI CỦA EM', CAST(N'2018-11-28 16:23:03.557' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1092, 2, 4, N'Edit a product: HOA TÌNH YÊU - MY DREAM', CAST(N'2018-12-04 10:37:13.237' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1093, 2, 4, N'Edit a product: HOA TÌNH YÊU - MY DREAM', CAST(N'2018-12-04 10:37:27.227' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1094, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-12-04 10:37:44.027' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1095, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-12-04 10:37:57.670' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1096, 1, 4, N'Create new product: dwq', CAST(N'2018-12-04 11:02:01.470' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1097, 3, 4, N'Delete a product: dwq', CAST(N'2018-12-04 11:02:07.330' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1098, 2, 4, N'Edit a product: HOA TÌNH YÊU - MY DREAM', CAST(N'2018-12-04 11:22:15.010' AS DateTime))
GO
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1099, 2, 4, N'Edit a product: HOA TÌNH YÊU - MY DREAM', CAST(N'2018-12-04 11:22:21.650' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1100, 2, 4, N'Edit a product: HOA TÌNH YÊU - MY DREAM', CAST(N'2018-12-04 11:23:17.253' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1101, 2, 4, N'Edit a product: HOA TÌNH YÊU - MY DREAM', CAST(N'2018-12-04 11:23:26.320' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1102, 2, 4, N'Edit a product: HOA TÌNH YÊU - MY DREAM', CAST(N'2018-12-07 14:50:43.683' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1103, 2, 4, N'Edit a product: HOA TÌNH YÊU - MY DREAM', CAST(N'2018-12-07 14:50:55.007' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1104, 2, 4, N'Edit a product: HOA TÌNH YÊU - MY DREAM', CAST(N'2018-12-07 14:53:14.277' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1105, 2, 4, N'Edit a product: HOA TÌNH YÊU - MY DREAM', CAST(N'2018-12-07 14:58:14.657' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1106, 2, 4, N'Edit a product: HOA TÌNH YÊU - MY DREAM', CAST(N'2018-12-07 14:58:24.217' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1107, 2, 4, N'Edit a product: HOA TÌNH YÊU - MY DREAM', CAST(N'2018-12-07 14:59:53.310' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1108, 2, 4, N'Edit a product: HOA TÌNH YÊU - MY DREAM', CAST(N'2018-12-07 14:59:56.647' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1109, 2, 4, N'Edit a product: HOA TÌNH YÊU - MY DREAM', CAST(N'2018-12-07 15:00:00.177' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1110, 2, 4, N'Edit a product: HOA TÌNH YÊU - MY DREAM', CAST(N'2018-12-07 15:00:05.907' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1111, 2, 4, N'Edit a product: HOA TÌNH YÊU - MY DREAM', CAST(N'2018-12-07 15:00:10.347' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1112, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-12-07 15:18:08.913' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1113, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-12-07 15:18:12.977' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1114, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-12-07 15:18:18.057' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1115, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-12-07 15:19:53.243' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1116, 2, 4, N'Edit a product: HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', CAST(N'2018-12-07 15:19:57.307' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1117, 2, 4, N'Edit a product: HOA HỒNG - YÊU THƯƠNG DỊU DÀNG', CAST(N'2018-12-07 15:20:23.590' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1118, 2, 4, N'Edit a product: HOA HỒNG - NỤ CƯỜI CỦA EM', CAST(N'2018-12-07 15:21:12.367' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1119, 2, 4, N'Edit a product: HOA HỒNG - NỤ CƯỜI CỦA EM', CAST(N'2018-12-07 15:21:18.697' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (1120, 2, 4, N'Edit a product: HOA HỒNG - NỤ CƯỜI CỦA EM', CAST(N'2018-12-07 15:21:28.650' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (2102, 1, 4, N'Create new Category: dsadas', CAST(N'2018-12-26 15:56:58.683' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (2103, 2, 4, N'Edit new customer: Nguyễn Quốc Huy', CAST(N'2018-12-28 16:10:34.287' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (2104, 2, 4, N'Edit new customer: Nguyễn Văn A', CAST(N'2018-12-28 16:10:38.380' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (2105, 3, 4, N'Delete Category: test', CAST(N'2018-12-29 09:51:46.233' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (2106, 1, 4, N'Create new Category: test', CAST(N'2018-12-29 09:52:07.093' AS DateTime))
INSERT [dbo].[System_Logs] ([Id], [Log_Type_Id], [EmployeeId], [Message], [RegisterDate]) VALUES (2107, 3, 4, N'Delete Category: test', CAST(N'2018-12-29 09:52:09.550' AS DateTime))
SET IDENTITY_INSERT [dbo].[System_Logs] OFF
SET IDENTITY_INSERT [dbo].[Topics] ON 

INSERT [dbo].[Topics] ([Id], [TopicName], [CreateDate], [IsActive]) VALUES (1, N'Hoa Sinh Nhật', CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Topics] ([Id], [TopicName], [CreateDate], [IsActive]) VALUES (2, N'Hoa Tình Yêu', CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Topics] ([Id], [TopicName], [CreateDate], [IsActive]) VALUES (3, N'Hoa Tươi', CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Topics] ([Id], [TopicName], [CreateDate], [IsActive]) VALUES (4, N'Hoa Chia Buồn', CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Topics] ([Id], [TopicName], [CreateDate], [IsActive]) VALUES (5, N'Cây Cảnh', CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Topics] OFF
SET IDENTITY_INSERT [dbo].[Vendors] ON 

INSERT [dbo].[Vendors] ([Id], [VendorName]) VALUES (1, N'Vendor1')
INSERT [dbo].[Vendors] ([Id], [VendorName]) VALUES (2, N'Vendor2')
INSERT [dbo].[Vendors] ([Id], [VendorName]) VALUES (3, N'Vendor3')
SET IDENTITY_INSERT [dbo].[Vendors] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Products]    Script Date: 12/29/2018 10:00:45 AM ******/
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [IX_Products] UNIQUE NONCLUSTERED 
(
	[ProductCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD  CONSTRAINT [FK_Categories_Topics] FOREIGN KEY([TopicId])
REFERENCES [dbo].[Topics] ([Id])
GO
ALTER TABLE [dbo].[Categories] CHECK CONSTRAINT [FK_Categories_Topics]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Customers]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Products]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Levels] FOREIGN KEY([LevelId])
REFERENCES [dbo].[Levels] ([Id])
GO
ALTER TABLE [dbo].[Employees] CHECK CONSTRAINT [FK_Employees_Levels]
GO
ALTER TABLE [dbo].[LevelPermissions]  WITH CHECK ADD  CONSTRAINT [FK_LevelPermissions_Levels] FOREIGN KEY([LevelId])
REFERENCES [dbo].[Levels] ([Id])
GO
ALTER TABLE [dbo].[LevelPermissions] CHECK CONSTRAINT [FK_LevelPermissions_Levels]
GO
ALTER TABLE [dbo].[Likes]  WITH CHECK ADD  CONSTRAINT [FK_Likes_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Likes] CHECK CONSTRAINT [FK_Likes_Customers]
GO
ALTER TABLE [dbo].[Likes]  WITH CHECK ADD  CONSTRAINT [FK_Likes_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Likes] CHECK CONSTRAINT [FK_Likes_Products]
GO
ALTER TABLE [dbo].[LoginLogs]  WITH CHECK ADD  CONSTRAINT [FK_LoginLogs_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[LoginLogs] CHECK CONSTRAINT [FK_LoginLogs_Customers]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Coupons] FOREIGN KEY([CouponId])
REFERENCES [dbo].[Coupons] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Coupons]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Employees] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Employees]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_PaymentMethods] FOREIGN KEY([PaymentMethodId])
REFERENCES [dbo].[PaymentMethods] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_PaymentMethods]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Shippings] FOREIGN KEY([ShippingId])
REFERENCES [dbo].[Shippings] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Shippings]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Statuses] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Statuses] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Statuses]
GO
ALTER TABLE [dbo].[Pictures]  WITH CHECK ADD  CONSTRAINT [FK_Pictures_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Pictures] CHECK CONSTRAINT [FK_Pictures_Products]
GO
ALTER TABLE [dbo].[Product_Logs]  WITH CHECK ADD  CONSTRAINT [FK_Product_Logs_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Product_Logs] CHECK CONSTRAINT [FK_Product_Logs_Products]
GO
ALTER TABLE [dbo].[Product_Logs]  WITH CHECK ADD  CONSTRAINT [FK_ProductLogs_Employees] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([Id])
GO
ALTER TABLE [dbo].[Product_Logs] CHECK CONSTRAINT [FK_ProductLogs_Employees]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Vendors] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendors] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Vendors]
GO
ALTER TABLE [dbo].[Products_Categories_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories_Mapping_Categories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Products_Categories_Mapping] CHECK CONSTRAINT [FK_Products_Categories_Mapping_Categories]
GO
ALTER TABLE [dbo].[Products_Categories_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories_Mapping_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Products_Categories_Mapping] CHECK CONSTRAINT [FK_Products_Categories_Mapping_Products]
GO
ALTER TABLE [dbo].[System_Logs]  WITH CHECK ADD  CONSTRAINT [FK_System_Logs_Employees] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([Id])
GO
ALTER TABLE [dbo].[System_Logs] CHECK CONSTRAINT [FK_System_Logs_Employees]
GO
ALTER TABLE [dbo].[System_Logs]  WITH CHECK ADD  CONSTRAINT [FK_System_Logs_Log_Types] FOREIGN KEY([Log_Type_Id])
REFERENCES [dbo].[Log_Types] ([Id])
GO
ALTER TABLE [dbo].[System_Logs] CHECK CONSTRAINT [FK_System_Logs_Log_Types]
GO
USE [master]
GO
ALTER DATABASE [FlowerShopping] SET  READ_WRITE 
GO
