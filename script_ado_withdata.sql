USE [master]
GO
/****** Object:  Database [ADO_EXAMPLE]    Script Date: 09/05/2022 2:54:14 ******/
CREATE DATABASE [ADO_EXAMPLE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ADO_EXAMPLE', FILENAME = N'D:\R&D\ASP.Net\CodeWithGopi\ADO_EXAMPLE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ADO_EXAMPLE_log', FILENAME = N'D:\R&D\ASP.Net\CodeWithGopi\ADO_EXAMPLE_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ADO_EXAMPLE] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ADO_EXAMPLE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ADO_EXAMPLE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ADO_EXAMPLE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ADO_EXAMPLE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ADO_EXAMPLE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ADO_EXAMPLE] SET ARITHABORT OFF 
GO
ALTER DATABASE [ADO_EXAMPLE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ADO_EXAMPLE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ADO_EXAMPLE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ADO_EXAMPLE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ADO_EXAMPLE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ADO_EXAMPLE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ADO_EXAMPLE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ADO_EXAMPLE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ADO_EXAMPLE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ADO_EXAMPLE] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ADO_EXAMPLE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ADO_EXAMPLE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ADO_EXAMPLE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ADO_EXAMPLE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ADO_EXAMPLE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ADO_EXAMPLE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ADO_EXAMPLE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ADO_EXAMPLE] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ADO_EXAMPLE] SET  MULTI_USER 
GO
ALTER DATABASE [ADO_EXAMPLE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ADO_EXAMPLE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ADO_EXAMPLE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ADO_EXAMPLE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ADO_EXAMPLE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ADO_EXAMPLE] SET QUERY_STORE = OFF
GO
USE [ADO_EXAMPLE]
GO
/****** Object:  Table [dbo].[tbl_ProductMaster]    Script Date: 09/05/2022 2:54:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ProductMaster](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[Price] [decimal](8, 0) NOT NULL,
	[Qty] [int] NOT NULL,
	[Remarks] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_ProductMaster] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_ProductMaster] ON 

INSERT [dbo].[tbl_ProductMaster] ([ProductID], [ProductName], [Price], [Qty], [Remarks]) VALUES (14, N'test', CAST(44 AS Decimal(8, 0)), 2, N'4')
INSERT [dbo].[tbl_ProductMaster] ([ProductID], [ProductName], [Price], [Qty], [Remarks]) VALUES (15, N'sdfr', CAST(3 AS Decimal(8, 0)), 33, N'34')
INSERT [dbo].[tbl_ProductMaster] ([ProductID], [ProductName], [Price], [Qty], [Remarks]) VALUES (16, N'dsfwe', CAST(33 AS Decimal(8, 0)), 34, N'34')
SET IDENTITY_INSERT [dbo].[tbl_ProductMaster] OFF
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteProduct]    Script Date: 09/05/2022 2:54:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_DeleteProduct]
(
@ProductID int, 
@ReturnMessage varchar(50) output
)

as

begin
    declare @rowcount int=0
    begin try
	    set @rowcount=(select COUNT(1) from dbo.tbl_ProductMaster where ProductID=@ProductID)
		if (@rowcount>0)
		    begin
				begin tran
				  delete from dbo.tbl_ProductMaster where ProductID=@ProductID
				  set @ReturnMessage='Product deleted succesfully.'
				commit tran
			end
         else
		    begin
			    set @ReturnMessage='Product not availeable with id ' + CONVERT(varchar, @ProductID)
			end
	end try

	begin catch
	    rollback tran
		set @ReturnMessage=ERROR_MESSAGE()
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllProduct]    Script Date: 09/05/2022 2:54:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_GetAllProduct]
as
begin

select ProductID,ProductName,Price,Qty,Remarks from dbo.tbl_ProductMaster with (nolock)

end;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProductByID]    Script Date: 09/05/2022 2:54:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE proc [dbo].[sp_GetProductByID]
(
@ProductID int
)
as 
begin
 
SELECT [ProductID]
      ,[ProductName]
      ,[Price]
      ,[Qty]
      ,[Remarks]
  FROM [dbo].[tbl_ProductMaster]
where [ProductID]=@ProductID   

end
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertProduct]    Script Date: 09/05/2022 2:54:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[sp_InsertProduct]
(
@ProductName nvarchar(50),
@Price decimal(8,2),
@Qty int,
@Remarks nvarchar(50)=null
)
as

begin
begin try
   begin tran
	   insert into dbo.tbl_ProductMaster(ProductName,Price,Qty,Remarks)
	   values(@ProductName,@Price,@Qty,@Remarks)
   commit tran
end try
begin catch
   rollback tran
   select   ERROR_MESSAGE()
end catch
end
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateProduct]    Script Date: 09/05/2022 2:54:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_UpdateProduct]
(
@ProductID int,
@ProductName nvarchar(50),
@Price bigint,
@Qty int,
@Remarks nvarchar(50)=null
)
as

begin
begin try
   begin tran
	   --insert into dbo.tbl_ProductMaster(ProductName,Price,Qty,Remarks)
	   --values(@ProductName,@Price,@Qty,@Remarks)

	   update dbo.tbl_ProductMaster  set
	          ProductName	=@ProductName,
	          Price			=@Price,
	          Qty			=@Qty,
	          Remarks		=@Remarks

       where ProductID=@ProductID   
   commit tran
end try
begin catch
   rollback tran
   select   ERROR_MESSAGE()
end catch
end
GO
USE [master]
GO
ALTER DATABASE [ADO_EXAMPLE] SET  READ_WRITE 
GO
