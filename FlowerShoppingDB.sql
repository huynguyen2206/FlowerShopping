USE [master]
GO
/****** Object:  Database [FlowerShopping]    Script Date: 11/19/2018 8:42:08 AM ******/
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
/****** Object:  Table [dbo].[Banners]    Script Date: 11/19/2018 8:42:08 AM ******/
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
/****** Object:  Table [dbo].[Categories]    Script Date: 11/19/2018 8:42:08 AM ******/
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
/****** Object:  Table [dbo].[Comments]    Script Date: 11/19/2018 8:42:08 AM ******/
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
/****** Object:  Table [dbo].[Coupons]    Script Date: 11/19/2018 8:42:08 AM ******/
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
/****** Object:  Table [dbo].[Customers]    Script Date: 11/19/2018 8:42:08 AM ******/
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
	[Password] [varchar](50) NOT NULL,
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
/****** Object:  Table [dbo].[Disables]    Script Date: 11/19/2018 8:42:08 AM ******/
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
/****** Object:  Table [dbo].[Employees]    Script Date: 11/19/2018 8:42:08 AM ******/
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
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LevelPermissions]    Script Date: 11/19/2018 8:42:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LevelPermissions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LevelId] [int] NOT NULL,
	[TableName] [nvarchar](50) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[AllowAdd] [bit] NOT NULL,
	[AllowEdit] [bit] NOT NULL,
	[AllowDelete] [bit] NOT NULL,
	[AllowView] [bit] NOT NULL,
	[AllowFullList] [bit] NOT NULL,
 CONSTRAINT [PK_LevelPermissions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Levels]    Script Date: 11/19/2018 8:42:08 AM ******/
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
/****** Object:  Table [dbo].[Likes]    Script Date: 11/19/2018 8:42:08 AM ******/
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
/****** Object:  Table [dbo].[Log_Types]    Script Date: 11/19/2018 8:42:08 AM ******/
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
/****** Object:  Table [dbo].[LoginLogs]    Script Date: 11/19/2018 8:42:08 AM ******/
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
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 11/19/2018 8:42:08 AM ******/
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
/****** Object:  Table [dbo].[Orders]    Script Date: 11/19/2018 8:42:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderCode] [nvarchar](20) NULL,
	[OrderDate] [datetime] NOT NULL,
	[CustomerId] [int] NOT NULL,
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
/****** Object:  Table [dbo].[PaymentMethods]    Script Date: 11/19/2018 8:42:08 AM ******/
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
/****** Object:  Table [dbo].[Pictures]    Script Date: 11/19/2018 8:42:08 AM ******/
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
/****** Object:  Table [dbo].[Product_Logs]    Script Date: 11/19/2018 8:42:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Logs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RegisterDate] [datetime] NOT NULL,
	[ProductId] [int] NOT NULL,
	[ProductQuantity] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
 CONSTRAINT [PK_ProductLogs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Products]    Script Date: 11/19/2018 8:42:08 AM ******/
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
/****** Object:  Table [dbo].[Products_Categories_Mapping]    Script Date: 11/19/2018 8:42:08 AM ******/
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
/****** Object:  Table [dbo].[Shippings]    Script Date: 11/19/2018 8:42:08 AM ******/
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
 CONSTRAINT [PK_Shippings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Statuses]    Script Date: 11/19/2018 8:42:08 AM ******/
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
/****** Object:  Table [dbo].[System_Logs]    Script Date: 11/19/2018 8:42:08 AM ******/
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
/****** Object:  Table [dbo].[Topics]    Script Date: 11/19/2018 8:42:08 AM ******/
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
/****** Object:  Table [dbo].[Vendors]    Script Date: 11/19/2018 8:42:08 AM ******/
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

INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (1, N'Hoa Hồng', 3, 0, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (2, N'Hoa Cẩm Chướng', 3, 0, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (3, N'Mới Yêu', 2, 0, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (4, N'Sắp Chia Tay', 2, 0, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (5, N'Bạn Xã Giao', 1, 0, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (6, N'Bạn Tri Kỉ', 1, 0, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (7, N'Gần Ra Đi', 4, 0, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (8, N'Đã Ra Đi', 4, 0, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (9, N'Cây để bàn', 5, 0, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (10, N'Cây Thủy Sinh', 5, 0, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Categories] ([Id], [CategoryName], [TopicId], [ShowHomePage], [CreateDate], [IsActive]) VALUES (11, N'Cây Phong Thủy', 5, 0, CAST(N'2001-01-01 00:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[Coupons] ON 

INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (1, N'0', CAST(0 AS Decimal(18, 0)), 0, 0, CAST(N'2001-01-01 00:00:00.000' AS DateTime), CAST(N'2001-01-01 00:00:00.000' AS DateTime), CAST(N'2001-01-01 00:00:00.000' AS DateTime), CAST(N'2001-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (5, N'RBVCEYPYDL', CAST(200000 AS Decimal(18, 0)), 0, 1, CAST(N'2018-11-15 15:28:29.790' AS DateTime), CAST(N'2018-11-15 15:28:29.790' AS DateTime), CAST(N'2018-11-15 15:28:29.790' AS DateTime), CAST(N'2018-11-15 15:28:29.790' AS DateTime))
INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (6, N'QSQTICMORZ', CAST(50000 AS Decimal(18, 0)), 0, 1, CAST(N'2018-11-15 15:29:21.480' AS DateTime), CAST(N'2018-11-15 15:29:21.480' AS DateTime), CAST(N'2018-11-15 15:29:21.480' AS DateTime), CAST(N'2018-11-15 15:29:21.480' AS DateTime))
INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (7, N'BKZZROBQOG', CAST(50000 AS Decimal(18, 0)), 1, 1, CAST(N'2018-11-15 15:29:21.483' AS DateTime), CAST(N'2018-11-15 15:29:21.483' AS DateTime), CAST(N'2018-11-15 15:29:21.483' AS DateTime), CAST(N'2018-11-15 15:29:21.483' AS DateTime))
INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (8, N'AALNMDMXPH', CAST(50000 AS Decimal(18, 0)), 1, 1, CAST(N'2018-11-15 15:29:21.483' AS DateTime), CAST(N'2018-11-15 15:29:21.483' AS DateTime), CAST(N'2018-11-15 15:29:21.483' AS DateTime), CAST(N'2018-11-15 15:29:21.483' AS DateTime))
INSERT [dbo].[Coupons] ([Id], [CouponCode], [Price], [IsActive], [Quantity], [RegisterDate], [InitDate], [FinishDate], [UseDate]) VALUES (10, N'FKPHLIYVWQ', CAST(10 AS Decimal(18, 0)), 0, 1, CAST(N'2018-11-16 16:16:17.257' AS DateTime), CAST(N'2018-11-16 16:16:17.257' AS DateTime), CAST(N'2018-11-16 16:16:17.257' AS DateTime), CAST(N'2018-11-16 16:16:17.257' AS DateTime))
SET IDENTITY_INSERT [dbo].[Coupons] OFF
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([Id], [CustomerName], [Email], [Password], [Phone], [Address], [ImageUrl], [VIP], [RegisterToten], [RegisterDate], [IsActive]) VALUES (1, N'Nguyễn Quốc Huy', N'fireangel.huy@gmail.com', N'123123123', N'01214724', N'Đà Nẵng', N'product11.jpg', 0, NULL, CAST(N'2018-10-25 15:28:29.893' AS DateTime), 1)
INSERT [dbo].[Customers] ([Id], [CustomerName], [Email], [Password], [Phone], [Address], [ImageUrl], [VIP], [RegisterToten], [RegisterDate], [IsActive]) VALUES (2, N'Nguyễn Văn A', N'abc@gmail.com', N'12345678', N'01214724', N'Đà Nẵng', N'product1.jpg', 0, NULL, CAST(N'2018-11-07 08:39:24.797' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Customers] OFF
SET IDENTITY_INSERT [dbo].[Disables] ON 

INSERT [dbo].[Disables] ([Id], [DisableName], [IsActive]) VALUES (1, N'ProductDiscounted', 0)
INSERT [dbo].[Disables] ([Id], [DisableName], [IsActive]) VALUES (2, N'Categories', 0)
INSERT [dbo].[Disables] ([Id], [DisableName], [IsActive]) VALUES (3, N'ProductNew', 0)
SET IDENTITY_INSERT [dbo].[Disables] OFF
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([Id], [LoginName], [Password], [EmployeeName], [Phone], [Gender], [Email], [Address], [PictureUrl], [LevelId], [LastLogin], [RegisterDate]) VALUES (4, N'admin', N'123123', N'Nguyễn Quốc Huy', N'025644115', NULL, N'abc@gmail.com', N'da nang', N'11111', 1, CAST(N'2001-01-01 00:00:00.000' AS DateTime), CAST(N'2001-01-01 00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Employees] OFF
SET IDENTITY_INSERT [dbo].[Levels] ON 

INSERT [dbo].[Levels] ([Id], [LevelName]) VALUES (1, N'Admin')
INSERT [dbo].[Levels] ([Id], [LevelName]) VALUES (2, N'Seller')
SET IDENTITY_INSERT [dbo].[Levels] OFF
SET IDENTITY_INSERT [dbo].[Log_Types] ON 

INSERT [dbo].[Log_Types] ([Id], [Log_Type_Name]) VALUES (1, N'Create')
INSERT [dbo].[Log_Types] ([Id], [Log_Type_Name]) VALUES (2, N'Edit')
INSERT [dbo].[Log_Types] ([Id], [Log_Type_Name]) VALUES (3, N'Delete')
SET IDENTITY_INSERT [dbo].[Log_Types] OFF
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (1, 1, 1, N'Lãng', CAST(400000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product2.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (2, 1, 2, N'Lãng', CAST(700000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(200000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product17.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (3, 2, 1, N'Lãng', CAST(400000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product2.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (4, 3, 1, N'Lãng', CAST(400000 AS Decimal(18, 0)), CAST(3 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product2.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (5, 4, 1, N'Lãng', CAST(400000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product2.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (6, 4, 2, N'Lãng', CAST(700000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(200000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product17.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (7, 5, 1, N'Lãng', CAST(400000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product2.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (8, 6, 2, N'Lãng', CAST(700000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(200000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product17.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (9, 8, 4, N'Lãng', CAST(2550000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product11.jpg')
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [ProductId], [Unit], [UnitPrice], [Quantity], [Discount], [Tax], [DescriptionLong], [ImageUrl]) VALUES (11, 8, 1, N'Lãng', CAST(400000 AS Decimal(18, 0)), CAST(1 AS Decimal(18, 0)), CAST(50000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), NULL, N'product2.jpg')
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (1, NULL, CAST(N'2018-11-13 14:30:48.360' AS DateTime), 1, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, NULL, N'Trương Tam Phong', N'Núi Võ Đang', N'025146153', 4, 10)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (2, NULL, CAST(N'2018-11-13 14:32:21.920' AS DateTime), 1, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, NULL, N'Dương Quá', N'Cổ Mộ', N'051498465', 2, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (3, NULL, CAST(N'2018-11-13 18:10:25.690' AS DateTime), 1, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, NULL, N'Quách Tĩnh', N'Tương Dương', N'0614684165', 3, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (4, NULL, CAST(N'2018-11-16 21:45:34.680' AS DateTime), 1, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, NULL, N'Đoàn Dự', N'Đại Lý', N'02548651354', 4, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (5, NULL, CAST(N'2018-11-16 22:28:50.497' AS DateTime), 1, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, NULL, N'Tiểu Long Nữ', N'Cổ Mộ', N'02147413', 1, 1)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (6, NULL, CAST(N'2018-11-17 00:47:21.727' AS DateTime), 1, NULL, CAST(100000 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, NULL, N'Trương Vô Kị', N'Ma Giáo', N'025147654', 1, 6)
INSERT [dbo].[Orders] ([Id], [OrderCode], [OrderDate], [CustomerId], [ShippingId], [Discount], [Tax], [ShippingFee], [PaymentMethodId], [EmployeeId], [Receiver], [Address], [PhoneNumber], [StatusId], [CouponId]) VALUES (8, NULL, CAST(N'2018-11-17 11:10:01.990' AS DateTime), 1, NULL, CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), 1, NULL, N'Hoàng Dược Sư', N'Đào Hoa Đảo', N'0214754115', 1, 5)
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[PaymentMethods] ON 

INSERT [dbo].[PaymentMethods] ([Id], [MethodName]) VALUES (1, N'Method 1')
INSERT [dbo].[PaymentMethods] ([Id], [MethodName]) VALUES (2, N'Method 2')
SET IDENTITY_INSERT [dbo].[PaymentMethods] OFF
SET IDENTITY_INSERT [dbo].[Pictures] ON 

INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (3, 1, N'product2.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (4, 1, N'product3.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (5, 2, N'product17.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (6, 2, N'product18.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (8, 2, N'product9.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (10, 2, N'product1.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (11, 4, N'product11.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (38, 3, N'product1.jpg')
INSERT [dbo].[Pictures] ([Id], [ProductId], [PictureUrl]) VALUES (39, 3, N'product2.jpg')
SET IDENTITY_INSERT [dbo].[Pictures] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [ProductCode], [ProductName], [Unit], [UnitPrice], [SalePrice], [Tax], [QuantityAvailable], [DescriptionShort], [DescriptionLong], [Height], [ShowHomePage], [VendorId], [View], [PictureUrl], [CreateDate], [IsActive]) VALUES (1, N'TY_01', N'HOA TÌNH YÊU - MY DREAM', N'lãng', 400000, 50000, 0, 10, N'Màu tím là màu của sự mộng mơ, những giấc mơ chứa đựng nhiều điều tốt đẹp mà chúng ta đang cố gắng xây dựng trong đời thực. Có nhiều dạng giấc mơ nhưng giấc mơ của anh là được thấy em mỗi ngày với nụ cười hạnh phúc trên môi là đủ rồi. My dream - my love', N'<p><strong>Giỏ hoa tươi&nbsp;</strong>My Dream gồm c&aacute;c loại hoa tươi:</p>

<p>- 8 hoa hồng t&iacute;m</p>

<p>- Hoa hồng da</p>

<p>- C&aacute;t tường trắng</p>

<p>- Cẩm chướng hồng</p>

<p>- Cỏ n&uacute;t ( theo m&ugrave;a ) / baby</p>

<p>- Hoa l&aacute; phụ kh&aacute;c</p>
', NULL, 0, 1, 1, N'product2.jpg', CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Products] ([Id], [ProductCode], [ProductName], [Unit], [UnitPrice], [SalePrice], [Tax], [QuantityAvailable], [DescriptionShort], [DescriptionLong], [Height], [ShowHomePage], [VendorId], [View], [PictureUrl], [CreateDate], [IsActive]) VALUES (2, N'TY_02', N'HOA TÌNH YÊU - TÌNH YÊU DIỆU KỲ', N'lãng', 700000, 200000, 0, 8, N'Tình yêu là thứ cảm xúc đẹp đẽ và mạnh mẽ nhất. Tình yêu cho chúng ta sống giữa mộng mơ và thực tại, cho chúng ta nếm trải đầy đủ cung bậc cảm xúc: Hỉ - nộ - ái - ố. Phức tạp là vậy nhưng nào có ai trách vì mình được yêu quá nhiều bao giờ, người ta chỉ buồn vì chưa tìm ra tình yêu của đời mình mà thôi. Giỏ hoa là lời chúc, là sự tôn vinh cho sự diệu kỳ của tình yêu.', N'<p><strong>Giỏ hoa tươi&nbsp;</strong>T&igrave;nh Y&ecirc;u Diệu Kỳ gồm c&aacute;c loại hoa:</p>

<p>- 20 hồng v&agrave;ng</p>

<p>- Hoa thủy ti&ecirc;n v&agrave;ng</p>

<p>- Salem/ thạch thảo/ mimi trắng</p>

<p>- Hoa l&aacute; phụ kh&aacute;c</p>
', NULL, 0, 1, 0, N'product17.jpg', CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Products] ([Id], [ProductCode], [ProductName], [Unit], [UnitPrice], [SalePrice], [Tax], [QuantityAvailable], [DescriptionShort], [DescriptionLong], [Height], [ShowHomePage], [VendorId], [View], [PictureUrl], [CreateDate], [IsActive]) VALUES (3, N'TY_03', N'HOA TÌNH YÊU - NGƯỜI TÔI THƯƠNG', N'lãng', 400000, 0, 0, 5, N'Trong cuộc sống anh trải qua rất nhiều áp lực nhưng em có biết không, niềm vui anh có được chính là có em. Có nhiều niềm vui giản đơn là mỗi sớm mai có em trong vòng tay, được ngắm nhìn nụ cười của em cũng đủ xóa tan mệt mỏi trong anh và đó là " Người Tôi Thương "', N'<p><strong>Giỏ hoa tươi&nbsp;</strong>Người T&ocirc;i Thương gồm c&aacute;c loại hoa:</p>

<p>- Hoa hồng trắng</p>

<p>- Hoa hồng da</p>

<p>- C&aacute;t tường trắng</p>

<p>- Hoa baby</p>

<p>- Hoa l&aacute; phụ kh&aacute;c</p>
', NULL, 0, 3, 0, N'product1.jpg', CAST(N'2001-01-01 00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Products] ([Id], [ProductCode], [ProductName], [Unit], [UnitPrice], [SalePrice], [Tax], [QuantityAvailable], [DescriptionShort], [DescriptionLong], [Height], [ShowHomePage], [VendorId], [View], [PictureUrl], [CreateDate], [IsActive]) VALUES (4, N'CB_01', N'HOA CHIA BUỒN - KIẾP VÔ THƯỜNG', N'Kệ', 2550000, 50000, 0, 3, N'Cuộc sống sinh lão bệnh tử là điều không ai có thể tránh khỏi. Tất cả rồi sẽ trở về với cát bụi mọi thứ đều vô thường. Kệ hoa như sự chia sẽ với nỗi buồn mất mát khi người thân ra đi. Mong người ra đi được thanh thản không còn vương vấn bụi trần.', N'<p><strong>Kệ chia buồn&nbsp;</strong>Kiếp V&ocirc; Thường gồm c&aacute;c loại hoa tươi:</p>

<p>- Hoa hồng trắng</p>

<p>- Hoa hồng da</p>

<p>- C&aacute;t tường trắng</p>

<p>- Đồng tiền trắng</p>

<p>- Hoa l&aacute; phụ kh&aacute;c</p>
', NULL, 0, 2, 0, N'product11.jpg', CAST(N'2018-11-10 10:58:15.243' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Products] OFF
SET IDENTITY_INSERT [dbo].[Products_Categories_Mapping] ON 

INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (12, 1, 3)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (13, 2, 3)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (14, 2, 6)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (31, 3, 2)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (32, 3, 3)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (33, 3, 6)
INSERT [dbo].[Products_Categories_Mapping] ([Id], [ProductId], [CategoryId]) VALUES (35, 4, 8)
SET IDENTITY_INSERT [dbo].[Products_Categories_Mapping] OFF
SET IDENTITY_INSERT [dbo].[Shippings] ON 

INSERT [dbo].[Shippings] ([Id], [ShippingName], [Email], [Phone], [Address]) VALUES (1, N'Trần 2 cử', N'2cu@gmail.com', N'0214756414', N'Đà Nẵng')
INSERT [dbo].[Shippings] ([Id], [ShippingName], [Email], [Phone], [Address]) VALUES (2, N'Nguyễn 62', N'62@gmail.com', N'0215489465', N'Nam Cao')
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
SET IDENTITY_INSERT [dbo].[System_Logs] OFF
SET IDENTITY_INSERT [dbo].[Topics] ON 

INSERT [dbo].[Topics] ([Id], [TopicName], [CreateDate], [IsActive]) VALUES (1, N'Hoa Sinh Nhật', CAST(N'2001-01-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Topics] ([Id], [TopicName], [CreateDate], [IsActive]) VALUES (2, N'Hoa Tình Yêu', CAST(N'2001-01-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Topics] ([Id], [TopicName], [CreateDate], [IsActive]) VALUES (3, N'Hoa Tươi', CAST(N'2001-01-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Topics] ([Id], [TopicName], [CreateDate], [IsActive]) VALUES (4, N'Hoa Chia Buồn', CAST(N'2001-01-01 00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Topics] ([Id], [TopicName], [CreateDate], [IsActive]) VALUES (5, N'Cây Cảnh', CAST(N'2001-01-01 00:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Topics] OFF
SET IDENTITY_INSERT [dbo].[Vendors] ON 

INSERT [dbo].[Vendors] ([Id], [VendorName]) VALUES (1, N'Vendor1')
INSERT [dbo].[Vendors] ([Id], [VendorName]) VALUES (2, N'Vendor2')
INSERT [dbo].[Vendors] ([Id], [VendorName]) VALUES (3, N'Vendor3')
SET IDENTITY_INSERT [dbo].[Vendors] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Products]    Script Date: 11/19/2018 8:42:08 AM ******/
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [IX_Products] UNIQUE NONCLUSTERED 
(
	[ProductCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LevelPermissions] ADD  CONSTRAINT [DF_LevelPermissions_AllowAdd]  DEFAULT ((0)) FOR [AllowAdd]
GO
ALTER TABLE [dbo].[LevelPermissions] ADD  CONSTRAINT [DF_LevelPermissions_AllowEdit]  DEFAULT ((0)) FOR [AllowEdit]
GO
ALTER TABLE [dbo].[LevelPermissions] ADD  CONSTRAINT [DF_LevelPermissions_AllowDelete]  DEFAULT ((0)) FOR [AllowDelete]
GO
ALTER TABLE [dbo].[LevelPermissions] ADD  CONSTRAINT [DF_LevelPermissions_AllowView]  DEFAULT ((0)) FOR [AllowView]
GO
ALTER TABLE [dbo].[LevelPermissions] ADD  CONSTRAINT [DF_LevelPermissions_AllowFullList]  DEFAULT ((0)) FOR [AllowFullList]
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
