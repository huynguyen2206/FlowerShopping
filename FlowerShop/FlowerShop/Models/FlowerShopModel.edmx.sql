
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 11/15/2018 11:16:47
-- Generated from EDMX file: D:\Project Github\FlowerShopingProject\FlowerShop\FlowerShop\Models\FlowerShopModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [FlowerShopping];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_Categories_Topics]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Categories] DROP CONSTRAINT [FK_Categories_Topics];
GO
IF OBJECT_ID(N'[dbo].[FK_Comments_Customers]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Comments] DROP CONSTRAINT [FK_Comments_Customers];
GO
IF OBJECT_ID(N'[dbo].[FK_Comments_Products]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Comments] DROP CONSTRAINT [FK_Comments_Products];
GO
IF OBJECT_ID(N'[dbo].[FK_Employees_Levels]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Employees] DROP CONSTRAINT [FK_Employees_Levels];
GO
IF OBJECT_ID(N'[dbo].[FK_LevelPermissions_Levels]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[LevelPermissions] DROP CONSTRAINT [FK_LevelPermissions_Levels];
GO
IF OBJECT_ID(N'[dbo].[FK_Likes_Customers]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Likes] DROP CONSTRAINT [FK_Likes_Customers];
GO
IF OBJECT_ID(N'[dbo].[FK_Likes_Products]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Likes] DROP CONSTRAINT [FK_Likes_Products];
GO
IF OBJECT_ID(N'[dbo].[FK_LoginLogs_Customers]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[LoginLogs] DROP CONSTRAINT [FK_LoginLogs_Customers];
GO
IF OBJECT_ID(N'[dbo].[FK_OrderDetails_Orders]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[OrderDetails] DROP CONSTRAINT [FK_OrderDetails_Orders];
GO
IF OBJECT_ID(N'[dbo].[FK_OrderDetails_Products]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[OrderDetails] DROP CONSTRAINT [FK_OrderDetails_Products];
GO
IF OBJECT_ID(N'[dbo].[FK_Orders_Coupons]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_Orders_Coupons];
GO
IF OBJECT_ID(N'[dbo].[FK_Orders_Customers]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_Orders_Customers];
GO
IF OBJECT_ID(N'[dbo].[FK_Orders_Employees]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_Orders_Employees];
GO
IF OBJECT_ID(N'[dbo].[FK_Orders_PaymentMethods]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_Orders_PaymentMethods];
GO
IF OBJECT_ID(N'[dbo].[FK_Orders_Shippings]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_Orders_Shippings];
GO
IF OBJECT_ID(N'[dbo].[FK_Orders_Statuses]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_Orders_Statuses];
GO
IF OBJECT_ID(N'[dbo].[FK_Pictures_Products]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Pictures] DROP CONSTRAINT [FK_Pictures_Products];
GO
IF OBJECT_ID(N'[dbo].[FK_Product_Logs_Products]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Product_Logs] DROP CONSTRAINT [FK_Product_Logs_Products];
GO
IF OBJECT_ID(N'[dbo].[FK_ProductLogs_Employees]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Product_Logs] DROP CONSTRAINT [FK_ProductLogs_Employees];
GO
IF OBJECT_ID(N'[dbo].[FK_Products_Categories_Mapping_Categories]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Products_Categories_Mapping] DROP CONSTRAINT [FK_Products_Categories_Mapping_Categories];
GO
IF OBJECT_ID(N'[dbo].[FK_Products_Categories_Mapping_Products]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Products_Categories_Mapping] DROP CONSTRAINT [FK_Products_Categories_Mapping_Products];
GO
IF OBJECT_ID(N'[dbo].[FK_Products_Pictures]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Products] DROP CONSTRAINT [FK_Products_Pictures];
GO
IF OBJECT_ID(N'[dbo].[FK_Products_Vendors]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Products] DROP CONSTRAINT [FK_Products_Vendors];
GO
IF OBJECT_ID(N'[dbo].[FK_System_Logs_Employees]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[System_Logs] DROP CONSTRAINT [FK_System_Logs_Employees];
GO
IF OBJECT_ID(N'[dbo].[FK_System_Logs_Log_Types]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[System_Logs] DROP CONSTRAINT [FK_System_Logs_Log_Types];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Banners]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Banners];
GO
IF OBJECT_ID(N'[dbo].[Categories]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Categories];
GO
IF OBJECT_ID(N'[dbo].[Comments]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Comments];
GO
IF OBJECT_ID(N'[dbo].[Coupons]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Coupons];
GO
IF OBJECT_ID(N'[dbo].[Customers]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Customers];
GO
IF OBJECT_ID(N'[dbo].[Disables]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Disables];
GO
IF OBJECT_ID(N'[dbo].[Employees]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Employees];
GO
IF OBJECT_ID(N'[dbo].[LevelPermissions]', 'U') IS NOT NULL
    DROP TABLE [dbo].[LevelPermissions];
GO
IF OBJECT_ID(N'[dbo].[Levels]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Levels];
GO
IF OBJECT_ID(N'[dbo].[Likes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Likes];
GO
IF OBJECT_ID(N'[dbo].[Log_Types]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Log_Types];
GO
IF OBJECT_ID(N'[dbo].[LoginLogs]', 'U') IS NOT NULL
    DROP TABLE [dbo].[LoginLogs];
GO
IF OBJECT_ID(N'[dbo].[OrderDetails]', 'U') IS NOT NULL
    DROP TABLE [dbo].[OrderDetails];
GO
IF OBJECT_ID(N'[dbo].[Orders]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Orders];
GO
IF OBJECT_ID(N'[dbo].[PaymentMethods]', 'U') IS NOT NULL
    DROP TABLE [dbo].[PaymentMethods];
GO
IF OBJECT_ID(N'[dbo].[Pictures]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Pictures];
GO
IF OBJECT_ID(N'[dbo].[Product_Logs]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Product_Logs];
GO
IF OBJECT_ID(N'[dbo].[Products]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Products];
GO
IF OBJECT_ID(N'[dbo].[Products_Categories_Mapping]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Products_Categories_Mapping];
GO
IF OBJECT_ID(N'[dbo].[Shippings]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Shippings];
GO
IF OBJECT_ID(N'[dbo].[Statuses]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Statuses];
GO
IF OBJECT_ID(N'[dbo].[System_Logs]', 'U') IS NOT NULL
    DROP TABLE [dbo].[System_Logs];
GO
IF OBJECT_ID(N'[dbo].[Topics]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Topics];
GO
IF OBJECT_ID(N'[dbo].[Vendors]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Vendors];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Banners'
CREATE TABLE [dbo].[Banners] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Tittle] nvarchar(200)  NOT NULL,
    [PictureUrl] varchar(250)  NOT NULL
);
GO

-- Creating table 'Comments'
CREATE TABLE [dbo].[Comments] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [CustomerId] int  NOT NULL,
    [ProductId] int  NOT NULL,
    [Comment1] nvarchar(100)  NOT NULL,
    [CommentDate] datetime  NOT NULL
);
GO

-- Creating table 'Coupons'
CREATE TABLE [dbo].[Coupons] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [CouponCode] varchar(50)  NOT NULL,
    [Price] decimal(18,0)  NOT NULL,
    [IsActive] bit  NOT NULL,
    [Quantity] int  NOT NULL,
    [RegisterDate] datetime  NOT NULL,
    [InitDate] datetime  NOT NULL,
    [FinishDate] datetime  NOT NULL,
    [UseDate] datetime  NOT NULL
);
GO

-- Creating table 'Customers'
CREATE TABLE [dbo].[Customers] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [CustomerName] nvarchar(50)  NOT NULL,
    [Email] nvarchar(100)  NOT NULL,
    [Password] varchar(50)  NOT NULL,
    [Phone] nvarchar(30)  NOT NULL,
    [Address] nvarchar(150)  NOT NULL,
    [ImageUrl] varchar(250)  NULL,
    [VIP] bit  NOT NULL,
    [RegisterToten] nvarchar(100)  NULL,
    [RegisterDate] datetime  NOT NULL,
    [IsActive] bit  NOT NULL
);
GO

-- Creating table 'Employees'
CREATE TABLE [dbo].[Employees] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [LoginName] nvarchar(100)  NOT NULL,
    [Password] varchar(50)  NOT NULL,
    [EmployeeName] nvarchar(100)  NOT NULL,
    [Phone] varchar(30)  NOT NULL,
    [Email] nvarchar(200)  NOT NULL,
    [Address] nvarchar(200)  NOT NULL,
    [PictureUrl] varchar(250)  NOT NULL,
    [LevelId] int  NOT NULL,
    [LastLogin] datetime  NOT NULL,
    [RegisterDate] datetime  NOT NULL,
    [Gender] nvarchar(50)  NULL
);
GO

-- Creating table 'LevelPermissions'
CREATE TABLE [dbo].[LevelPermissions] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [LevelId] int  NOT NULL,
    [TableName] nvarchar(50)  NOT NULL,
    [DisplayName] nvarchar(100)  NOT NULL,
    [AllowAdd] bit  NOT NULL,
    [AllowEdit] bit  NOT NULL,
    [AllowDelete] bit  NOT NULL,
    [AllowView] bit  NOT NULL,
    [AllowFullList] bit  NOT NULL
);
GO

-- Creating table 'Levels'
CREATE TABLE [dbo].[Levels] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [LevelName] nvarchar(100)  NOT NULL
);
GO

-- Creating table 'Likes'
CREATE TABLE [dbo].[Likes] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [CustomerId] int  NOT NULL,
    [ProductId] int  NOT NULL,
    [IsLike] bit  NOT NULL
);
GO

-- Creating table 'OrderDetails'
CREATE TABLE [dbo].[OrderDetails] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [OrderId] int  NOT NULL,
    [ProductId] int  NOT NULL,
    [Unit] nvarchar(20)  NOT NULL,
    [UnitPrice] decimal(18,0)  NOT NULL,
    [Quantity] decimal(18,0)  NOT NULL,
    [Discount] decimal(18,0)  NOT NULL,
    [Tax] decimal(18,0)  NOT NULL
);
GO

-- Creating table 'PaymentMethods'
CREATE TABLE [dbo].[PaymentMethods] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [MethodName] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'Pictures'
CREATE TABLE [dbo].[Pictures] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [ProductId] int  NOT NULL,
    [PictureUrl] varchar(250)  NOT NULL
);
GO

-- Creating table 'Products_Categories_Mapping'
CREATE TABLE [dbo].[Products_Categories_Mapping] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [ProductId] int  NOT NULL,
    [CategoryId] int  NOT NULL
);
GO

-- Creating table 'Shippings'
CREATE TABLE [dbo].[Shippings] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [ShippingName] nvarchar(50)  NOT NULL,
    [Email] nvarchar(150)  NULL,
    [Phone] nvarchar(50)  NOT NULL,
    [Address] nvarchar(200)  NOT NULL
);
GO

-- Creating table 'Statuses'
CREATE TABLE [dbo].[Statuses] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [StatusName] nvarchar(100)  NOT NULL
);
GO

-- Creating table 'Vendors'
CREATE TABLE [dbo].[Vendors] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [VendorName] nvarchar(100)  NOT NULL
);
GO

-- Creating table 'Log_Types'
CREATE TABLE [dbo].[Log_Types] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Log_Type_Name] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'LoginLogs'
CREATE TABLE [dbo].[LoginLogs] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [CustomerId] int  NOT NULL,
    [TimeLogin] datetime  NOT NULL,
    [IsLogin] bit  NOT NULL
);
GO

-- Creating table 'Product_Logs'
CREATE TABLE [dbo].[Product_Logs] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [RegisterDate] datetime  NOT NULL,
    [ProductId] int  NOT NULL,
    [ProductQuantity] int  NOT NULL,
    [EmployeeId] int  NOT NULL
);
GO

-- Creating table 'System_Logs'
CREATE TABLE [dbo].[System_Logs] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Log_Type_Id] int  NOT NULL,
    [EmployeeId] int  NOT NULL,
    [Message] nvarchar(150)  NOT NULL,
    [RegisterDate] datetime  NOT NULL
);
GO

-- Creating table 'Products'
CREATE TABLE [dbo].[Products] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [ProductCode] varchar(15)  NOT NULL,
    [ProductName] nvarchar(150)  NOT NULL,
    [Unit] nvarchar(20)  NOT NULL,
    [UnitPrice] int  NOT NULL,
    [SalePrice] int  NOT NULL,
    [Tax] int  NOT NULL,
    [QuantityAvailable] int  NOT NULL,
    [DescriptionShort] nvarchar(max)  NULL,
    [DescriptionLong] nvarchar(max)  NULL,
    [ShowHomePage] bit  NULL,
    [VendorId] int  NOT NULL,
    [View] int  NOT NULL,
    [PictureId] int  NULL,
    [CreateDate] datetime  NOT NULL
);
GO

-- Creating table 'Disables'
CREATE TABLE [dbo].[Disables] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [DisableName] nvarchar(100)  NOT NULL,
    [IsActive] bit  NOT NULL
);
GO

-- Creating table 'Topics'
CREATE TABLE [dbo].[Topics] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [TopicName] nvarchar(80)  NOT NULL,
    [CreateDate] datetime  NULL
);
GO

-- Creating table 'Categories'
CREATE TABLE [dbo].[Categories] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [CategoryName] nvarchar(100)  NOT NULL,
    [TopicId] int  NOT NULL,
    [ShowHomePage] bit  NOT NULL,
    [CreateDate] datetime  NOT NULL
);
GO

-- Creating table 'Orders'
CREATE TABLE [dbo].[Orders] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [OrderCode] nvarchar(20)  NULL,
    [OrderDate] datetime  NOT NULL,
    [CustomerId] int  NOT NULL,
    [ShippingId] int  NULL,
    [Discount] decimal(18,0)  NOT NULL,
    [Tax] decimal(18,0)  NOT NULL,
    [ShippingFee] decimal(18,0)  NOT NULL,
    [PaymentMethodId] int  NULL,
    [EmployeeId] int  NULL,
    [StatusId] int  NOT NULL,
    [CouponId] int  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Banners'
ALTER TABLE [dbo].[Banners]
ADD CONSTRAINT [PK_Banners]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Comments'
ALTER TABLE [dbo].[Comments]
ADD CONSTRAINT [PK_Comments]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Coupons'
ALTER TABLE [dbo].[Coupons]
ADD CONSTRAINT [PK_Coupons]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Customers'
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [PK_Customers]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Employees'
ALTER TABLE [dbo].[Employees]
ADD CONSTRAINT [PK_Employees]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'LevelPermissions'
ALTER TABLE [dbo].[LevelPermissions]
ADD CONSTRAINT [PK_LevelPermissions]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Levels'
ALTER TABLE [dbo].[Levels]
ADD CONSTRAINT [PK_Levels]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Likes'
ALTER TABLE [dbo].[Likes]
ADD CONSTRAINT [PK_Likes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'OrderDetails'
ALTER TABLE [dbo].[OrderDetails]
ADD CONSTRAINT [PK_OrderDetails]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'PaymentMethods'
ALTER TABLE [dbo].[PaymentMethods]
ADD CONSTRAINT [PK_PaymentMethods]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Pictures'
ALTER TABLE [dbo].[Pictures]
ADD CONSTRAINT [PK_Pictures]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Products_Categories_Mapping'
ALTER TABLE [dbo].[Products_Categories_Mapping]
ADD CONSTRAINT [PK_Products_Categories_Mapping]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Shippings'
ALTER TABLE [dbo].[Shippings]
ADD CONSTRAINT [PK_Shippings]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Statuses'
ALTER TABLE [dbo].[Statuses]
ADD CONSTRAINT [PK_Statuses]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Vendors'
ALTER TABLE [dbo].[Vendors]
ADD CONSTRAINT [PK_Vendors]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Log_Types'
ALTER TABLE [dbo].[Log_Types]
ADD CONSTRAINT [PK_Log_Types]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'LoginLogs'
ALTER TABLE [dbo].[LoginLogs]
ADD CONSTRAINT [PK_LoginLogs]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Product_Logs'
ALTER TABLE [dbo].[Product_Logs]
ADD CONSTRAINT [PK_Product_Logs]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'System_Logs'
ALTER TABLE [dbo].[System_Logs]
ADD CONSTRAINT [PK_System_Logs]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Products'
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [PK_Products]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Disables'
ALTER TABLE [dbo].[Disables]
ADD CONSTRAINT [PK_Disables]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Topics'
ALTER TABLE [dbo].[Topics]
ADD CONSTRAINT [PK_Topics]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Categories'
ALTER TABLE [dbo].[Categories]
ADD CONSTRAINT [PK_Categories]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [PK_Orders]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [CustomerId] in table 'Comments'
ALTER TABLE [dbo].[Comments]
ADD CONSTRAINT [FK_Comments_Customers]
    FOREIGN KEY ([CustomerId])
    REFERENCES [dbo].[Customers]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Comments_Customers'
CREATE INDEX [IX_FK_Comments_Customers]
ON [dbo].[Comments]
    ([CustomerId]);
GO

-- Creating foreign key on [CustomerId] in table 'Likes'
ALTER TABLE [dbo].[Likes]
ADD CONSTRAINT [FK_Likes_Customers]
    FOREIGN KEY ([CustomerId])
    REFERENCES [dbo].[Customers]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Likes_Customers'
CREATE INDEX [IX_FK_Likes_Customers]
ON [dbo].[Likes]
    ([CustomerId]);
GO

-- Creating foreign key on [LevelId] in table 'Employees'
ALTER TABLE [dbo].[Employees]
ADD CONSTRAINT [FK_Employees_Levels]
    FOREIGN KEY ([LevelId])
    REFERENCES [dbo].[Levels]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Employees_Levels'
CREATE INDEX [IX_FK_Employees_Levels]
ON [dbo].[Employees]
    ([LevelId]);
GO

-- Creating foreign key on [LevelId] in table 'LevelPermissions'
ALTER TABLE [dbo].[LevelPermissions]
ADD CONSTRAINT [FK_LevelPermissions_Levels]
    FOREIGN KEY ([LevelId])
    REFERENCES [dbo].[Levels]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_LevelPermissions_Levels'
CREATE INDEX [IX_FK_LevelPermissions_Levels]
ON [dbo].[LevelPermissions]
    ([LevelId]);
GO

-- Creating foreign key on [CustomerId] in table 'LoginLogs'
ALTER TABLE [dbo].[LoginLogs]
ADD CONSTRAINT [FK_LoginLogs_Customers]
    FOREIGN KEY ([CustomerId])
    REFERENCES [dbo].[Customers]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_LoginLogs_Customers'
CREATE INDEX [IX_FK_LoginLogs_Customers]
ON [dbo].[LoginLogs]
    ([CustomerId]);
GO

-- Creating foreign key on [EmployeeId] in table 'Product_Logs'
ALTER TABLE [dbo].[Product_Logs]
ADD CONSTRAINT [FK_ProductLogs_Employees]
    FOREIGN KEY ([EmployeeId])
    REFERENCES [dbo].[Employees]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProductLogs_Employees'
CREATE INDEX [IX_FK_ProductLogs_Employees]
ON [dbo].[Product_Logs]
    ([EmployeeId]);
GO

-- Creating foreign key on [EmployeeId] in table 'System_Logs'
ALTER TABLE [dbo].[System_Logs]
ADD CONSTRAINT [FK_System_Logs_Employees]
    FOREIGN KEY ([EmployeeId])
    REFERENCES [dbo].[Employees]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_System_Logs_Employees'
CREATE INDEX [IX_FK_System_Logs_Employees]
ON [dbo].[System_Logs]
    ([EmployeeId]);
GO

-- Creating foreign key on [Log_Type_Id] in table 'System_Logs'
ALTER TABLE [dbo].[System_Logs]
ADD CONSTRAINT [FK_System_Logs_Log_Types]
    FOREIGN KEY ([Log_Type_Id])
    REFERENCES [dbo].[Log_Types]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_System_Logs_Log_Types'
CREATE INDEX [IX_FK_System_Logs_Log_Types]
ON [dbo].[System_Logs]
    ([Log_Type_Id]);
GO

-- Creating foreign key on [ProductId] in table 'Comments'
ALTER TABLE [dbo].[Comments]
ADD CONSTRAINT [FK_Comments_Products]
    FOREIGN KEY ([ProductId])
    REFERENCES [dbo].[Products]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Comments_Products'
CREATE INDEX [IX_FK_Comments_Products]
ON [dbo].[Comments]
    ([ProductId]);
GO

-- Creating foreign key on [ProductId] in table 'Likes'
ALTER TABLE [dbo].[Likes]
ADD CONSTRAINT [FK_Likes_Products]
    FOREIGN KEY ([ProductId])
    REFERENCES [dbo].[Products]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Likes_Products'
CREATE INDEX [IX_FK_Likes_Products]
ON [dbo].[Likes]
    ([ProductId]);
GO

-- Creating foreign key on [ProductId] in table 'OrderDetails'
ALTER TABLE [dbo].[OrderDetails]
ADD CONSTRAINT [FK_OrderDetails_Products]
    FOREIGN KEY ([ProductId])
    REFERENCES [dbo].[Products]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_OrderDetails_Products'
CREATE INDEX [IX_FK_OrderDetails_Products]
ON [dbo].[OrderDetails]
    ([ProductId]);
GO

-- Creating foreign key on [ProductId] in table 'Pictures'
ALTER TABLE [dbo].[Pictures]
ADD CONSTRAINT [FK_Pictures_Products]
    FOREIGN KEY ([ProductId])
    REFERENCES [dbo].[Products]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Pictures_Products'
CREATE INDEX [IX_FK_Pictures_Products]
ON [dbo].[Pictures]
    ([ProductId]);
GO

-- Creating foreign key on [PictureId] in table 'Products'
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [FK_Products_Pictures]
    FOREIGN KEY ([PictureId])
    REFERENCES [dbo].[Pictures]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Products_Pictures'
CREATE INDEX [IX_FK_Products_Pictures]
ON [dbo].[Products]
    ([PictureId]);
GO

-- Creating foreign key on [ProductId] in table 'Product_Logs'
ALTER TABLE [dbo].[Product_Logs]
ADD CONSTRAINT [FK_Product_Logs_Products]
    FOREIGN KEY ([ProductId])
    REFERENCES [dbo].[Products]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Product_Logs_Products'
CREATE INDEX [IX_FK_Product_Logs_Products]
ON [dbo].[Product_Logs]
    ([ProductId]);
GO

-- Creating foreign key on [ProductId] in table 'Products_Categories_Mapping'
ALTER TABLE [dbo].[Products_Categories_Mapping]
ADD CONSTRAINT [FK_Products_Categories_Mapping_Products]
    FOREIGN KEY ([ProductId])
    REFERENCES [dbo].[Products]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Products_Categories_Mapping_Products'
CREATE INDEX [IX_FK_Products_Categories_Mapping_Products]
ON [dbo].[Products_Categories_Mapping]
    ([ProductId]);
GO

-- Creating foreign key on [VendorId] in table 'Products'
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [FK_Products_Vendors]
    FOREIGN KEY ([VendorId])
    REFERENCES [dbo].[Vendors]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Products_Vendors'
CREATE INDEX [IX_FK_Products_Vendors]
ON [dbo].[Products]
    ([VendorId]);
GO

-- Creating foreign key on [TopicId] in table 'Categories'
ALTER TABLE [dbo].[Categories]
ADD CONSTRAINT [FK_Categories_Topics]
    FOREIGN KEY ([TopicId])
    REFERENCES [dbo].[Topics]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Categories_Topics'
CREATE INDEX [IX_FK_Categories_Topics]
ON [dbo].[Categories]
    ([TopicId]);
GO

-- Creating foreign key on [CategoryId] in table 'Products_Categories_Mapping'
ALTER TABLE [dbo].[Products_Categories_Mapping]
ADD CONSTRAINT [FK_Products_Categories_Mapping_Categories]
    FOREIGN KEY ([CategoryId])
    REFERENCES [dbo].[Categories]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Products_Categories_Mapping_Categories'
CREATE INDEX [IX_FK_Products_Categories_Mapping_Categories]
ON [dbo].[Products_Categories_Mapping]
    ([CategoryId]);
GO

-- Creating foreign key on [CouponId] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [FK_Orders_Coupons]
    FOREIGN KEY ([CouponId])
    REFERENCES [dbo].[Coupons]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Orders_Coupons'
CREATE INDEX [IX_FK_Orders_Coupons]
ON [dbo].[Orders]
    ([CouponId]);
GO

-- Creating foreign key on [CustomerId] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [FK_Orders_Customers]
    FOREIGN KEY ([CustomerId])
    REFERENCES [dbo].[Customers]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Orders_Customers'
CREATE INDEX [IX_FK_Orders_Customers]
ON [dbo].[Orders]
    ([CustomerId]);
GO

-- Creating foreign key on [EmployeeId] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [FK_Orders_Employees]
    FOREIGN KEY ([EmployeeId])
    REFERENCES [dbo].[Employees]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Orders_Employees'
CREATE INDEX [IX_FK_Orders_Employees]
ON [dbo].[Orders]
    ([EmployeeId]);
GO

-- Creating foreign key on [OrderId] in table 'OrderDetails'
ALTER TABLE [dbo].[OrderDetails]
ADD CONSTRAINT [FK_OrderDetails_Orders]
    FOREIGN KEY ([OrderId])
    REFERENCES [dbo].[Orders]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_OrderDetails_Orders'
CREATE INDEX [IX_FK_OrderDetails_Orders]
ON [dbo].[OrderDetails]
    ([OrderId]);
GO

-- Creating foreign key on [PaymentMethodId] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [FK_Orders_PaymentMethods]
    FOREIGN KEY ([PaymentMethodId])
    REFERENCES [dbo].[PaymentMethods]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Orders_PaymentMethods'
CREATE INDEX [IX_FK_Orders_PaymentMethods]
ON [dbo].[Orders]
    ([PaymentMethodId]);
GO

-- Creating foreign key on [ShippingId] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [FK_Orders_Shippings]
    FOREIGN KEY ([ShippingId])
    REFERENCES [dbo].[Shippings]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Orders_Shippings'
CREATE INDEX [IX_FK_Orders_Shippings]
ON [dbo].[Orders]
    ([ShippingId]);
GO

-- Creating foreign key on [StatusId] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [FK_Orders_Statuses]
    FOREIGN KEY ([StatusId])
    REFERENCES [dbo].[Statuses]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Orders_Statuses'
CREATE INDEX [IX_FK_Orders_Statuses]
ON [dbo].[Orders]
    ([StatusId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------