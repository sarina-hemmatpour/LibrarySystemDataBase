USE [master]
GO
/****** Object:  Database [Clothing Strore]    Script Date: 1/12/2022 9:50:49 PM ******/
CREATE DATABASE [Clothing Strore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Clothing Strore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Clothing Strore.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Clothing Strore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Clothing Strore_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Clothing Strore] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Clothing Strore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Clothing Strore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Clothing Strore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Clothing Strore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Clothing Strore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Clothing Strore] SET ARITHABORT OFF 
GO
ALTER DATABASE [Clothing Strore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Clothing Strore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Clothing Strore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Clothing Strore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Clothing Strore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Clothing Strore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Clothing Strore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Clothing Strore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Clothing Strore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Clothing Strore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Clothing Strore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Clothing Strore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Clothing Strore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Clothing Strore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Clothing Strore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Clothing Strore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Clothing Strore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Clothing Strore] SET RECOVERY FULL 
GO
ALTER DATABASE [Clothing Strore] SET  MULTI_USER 
GO
ALTER DATABASE [Clothing Strore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Clothing Strore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Clothing Strore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Clothing Strore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Clothing Strore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Clothing Strore] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Clothing Strore] SET QUERY_STORE = OFF
GO
USE [Clothing Strore]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 1/12/2022 9:50:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CUserName] [varchar](10) NOT NULL,
	[CPassword] [varchar](8) NOT NULL,
	[CName] [varchar](30) NOT NULL,
	[CLastname] [varchar](40) NOT NULL,
	[CPhoneNumber] [varchar](13) NOT NULL,
	[CAddress] [varchar](100) NOT NULL,
	[CPostalCode] [varchar](10) NOT NULL,
	[CEmail] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[CUserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[suportV]    Script Date: 1/12/2022 9:50:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--دید پشتیبان سایت
create view [dbo].[suportV] (CUserName ,CPassword,CName ,CLastname 
					,CPhoneNumber ,CAddress ,CPostalCode,CEmail)
	as select Customer.CUserName ,Customer.CPassword,CName 
				,Customer.CLastname ,Customer.CPhoneNumber ,Customer.CAddress
				,Customer.CPostalCode,Customer.CEmail
	from Customer
GO
/****** Object:  Table [dbo].[CP]    Script Date: 1/12/2022 9:50:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CP](
	[CUserName] [varchar](10) NOT NULL,
	[PId] [int] NOT NULL,
	[CPIsSent] [int] NOT NULL,
	[CPQuantity] [int] NOT NULL,
	[CPTotalAmount] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CUserName] ASC,
	[PId] ASC,
	[CPIsSent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[postV]    Script Date: 1/12/2022 9:50:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--مسئول ارسال
create view [dbo].[postV] (CName ,CLastname 
					,CPhoneNumber ,CAddress ,CPostalCode)
	as select CName ,CLastname ,CPhoneNumber 
				,CAddress ,CPostalCode
				from Customer
				where CUserName in (select distinct CUserName from CP
												where CPIsSent=0)
GO
/****** Object:  Table [dbo].[Category]    Script Date: 1/12/2022 9:50:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CatId] [int] NOT NULL,
	[CatTitle] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[CatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 1/12/2022 9:50:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[PId] [int] NOT NULL,
	[PName] [varchar](30) NOT NULL,
	[PPrice] [int] NOT NULL,
	[CatId] [int] NOT NULL,
	[SupId] [int] NOT NULL,
	[SRId] [int] NOT NULL,
	[PQuantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CustomerV]    Script Date: 1/12/2022 9:50:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[CustomerV] (PName,PPrice,CatTitle)
	as select Product.PName,Product.PPrice , Category.CatTitle
	from Product , Category
	where (Product.PQuantity>0) and Product.CatId=Category.CatId
GO
/****** Object:  Table [dbo].[Discount]    Script Date: 1/12/2022 9:50:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discount](
	[DCode] [int] NOT NULL,
	[DPercentage] [int] NOT NULL,
	[EId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 1/12/2022 9:50:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EId] [int] NOT NULL,
	[EName] [varchar](30) NOT NULL,
	[ELastname] [varchar](50) NOT NULL,
	[ENationalCode] [varchar](20) NOT NULL,
	[EPhoneNumber] [varchar](13) NOT NULL,
	[EAddress] [varchar](100) NOT NULL,
	[EEmail] [varchar](30) NOT NULL,
	[ESalary] [int] NOT NULL,
	[EType] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[EId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PreviousPrice]    Script Date: 1/12/2022 9:50:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PreviousPrice](
	[PId] [int] NOT NULL,
	[PPAmount] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PId] ASC,
	[PPAmount] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Receipt]    Script Date: 1/12/2022 9:50:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Receipt](
	[RecID] [int] NOT NULL,
	[RecTotalAmount] [int] NOT NULL,
	[DCode] [int] NOT NULL,
	[RecPayment] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RecID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StoreRoom]    Script Date: 1/12/2022 9:50:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StoreRoom](
	[SRId] [int] NOT NULL,
	[SRAddress] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SRId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 1/12/2022 9:50:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supplier](
	[SupId] [int] NOT NULL,
	[SupBrand] [varchar](50) NOT NULL,
	[SupAddress] [varchar](100) NOT NULL,
	[SupSite] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SupProduct]    Script Date: 1/12/2022 9:50:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SupProduct](
	[SupId] [int] NOT NULL,
	[SupPName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SupId] ASC,
	[SupPName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__5946F961B988E32D]    Script Date: 1/12/2022 9:50:49 PM ******/
ALTER TABLE [dbo].[Customer] ADD UNIQUE NONCLUSTERED 
(
	[CUserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CP] ADD  DEFAULT ((0)) FOR [CPIsSent]
GO
ALTER TABLE [dbo].[CP] ADD  DEFAULT ((1)) FOR [CPQuantity]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT ((0)) FOR [PQuantity]
GO
ALTER TABLE [dbo].[CP]  WITH CHECK ADD FOREIGN KEY([CUserName])
REFERENCES [dbo].[Customer] ([CUserName])
GO
ALTER TABLE [dbo].[CP]  WITH CHECK ADD FOREIGN KEY([PId])
REFERENCES [dbo].[Product] ([PId])
GO
ALTER TABLE [dbo].[Discount]  WITH CHECK ADD FOREIGN KEY([EId])
REFERENCES [dbo].[Employee] ([EId])
GO
ALTER TABLE [dbo].[PreviousPrice]  WITH CHECK ADD FOREIGN KEY([PId])
REFERENCES [dbo].[Product] ([PId])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([CatId])
REFERENCES [dbo].[Category] ([CatId])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([SRId])
REFERENCES [dbo].[StoreRoom] ([SRId])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([SupId])
REFERENCES [dbo].[Supplier] ([SupId])
GO
ALTER TABLE [dbo].[Receipt]  WITH CHECK ADD FOREIGN KEY([DCode])
REFERENCES [dbo].[Discount] ([DCode])
GO
ALTER TABLE [dbo].[SupProduct]  WITH CHECK ADD FOREIGN KEY([SupId])
REFERENCES [dbo].[Supplier] ([SupId])
GO
ALTER TABLE [dbo].[CP]  WITH CHECK ADD CHECK  ((([CPIsSent]=(1) OR [CPIsSent]=(0)) AND [CPQuantity]>=(1) AND [CPTotalAmount]>(0)))
GO
ALTER TABLE [dbo].[Discount]  WITH CHECK ADD CHECK  (((0)<[DPercentage] AND [DPercentage]<=(100)))
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD CHECK  ((([EType]='packaging' OR [EType]='post' OR [EType]='supporter' OR [EType]='admin') AND [ESalary]>(0)))
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD CHECK  (((0)<=[PPrice] AND (0)<=[PQuantity]))
GO
ALTER TABLE [dbo].[Receipt]  WITH CHECK ADD CHECK  (([RecTotalAmount]>(0) AND [RecPayment]>(0) AND [RecPayment]<[RecTotalAmount]))
GO
/****** Object:  StoredProcedure [dbo].[OrderList]    Script Date: 1/12/2022 9:50:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--رویه: لیست سفارشات ارسال نشده ی کاربر ورودی

create procedure [dbo].[OrderList] @CustomerId int
as 
	select table1.PId , PName , PQuantity
	from ((select PID , CPQuantity from CP
					where @CustomerId=CUserName and CPIsSent=0) as table1 
					inner join Product
					on table1.PId=Product.PId);
GO
USE [master]
GO
ALTER DATABASE [Clothing Strore] SET  READ_WRITE 
GO
