USE [master]
GO
/****** Object:  Database [productos_demo]    Script Date: 25/03/2025 06:59:16 p. m. ******/
CREATE DATABASE [productos_demo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'productos_demo', FILENAME = N'D:\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\productos_demo.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'productos_demo_log', FILENAME = N'D:\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\productos_demo_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [productos_demo] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [productos_demo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [productos_demo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [productos_demo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [productos_demo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [productos_demo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [productos_demo] SET ARITHABORT OFF 
GO
ALTER DATABASE [productos_demo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [productos_demo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [productos_demo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [productos_demo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [productos_demo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [productos_demo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [productos_demo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [productos_demo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [productos_demo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [productos_demo] SET  DISABLE_BROKER 
GO
ALTER DATABASE [productos_demo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [productos_demo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [productos_demo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [productos_demo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [productos_demo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [productos_demo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [productos_demo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [productos_demo] SET RECOVERY FULL 
GO
ALTER DATABASE [productos_demo] SET  MULTI_USER 
GO
ALTER DATABASE [productos_demo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [productos_demo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [productos_demo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [productos_demo] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [productos_demo] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [productos_demo] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'productos_demo', N'ON'
GO
ALTER DATABASE [productos_demo] SET QUERY_STORE = ON
GO
ALTER DATABASE [productos_demo] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [productos_demo]
GO
/****** Object:  User [IIS APPPOOL\DefaultAppPool]    Script Date: 25/03/2025 06:59:16 p. m. ******/
CREATE USER [IIS APPPOOL\DefaultAppPool] FOR LOGIN [IIS APPPOOL\DefaultAppPool] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [IIS APPPOOL\DefaultAppPool]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [IIS APPPOOL\DefaultAppPool]
GO
/****** Object:  Table [dbo].[catProducts]    Script Date: 25/03/2025 06:59:16 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[catProducts](
	[idCat] [int] IDENTITY(1,1) NOT NULL,
	[nameCat] [varchar](150) NULL,
	[statusCat] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[idCat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 25/03/2025 06:59:16 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[idProduct] [int] IDENTITY(1,1) NOT NULL,
	[nameProduct] [varchar](150) NOT NULL,
	[priceProduct] [float] NULL,
	[categoryProduct] [int] NULL,
	[statusProduct] [int] NULL,
 CONSTRAINT [PK__products__5EEC79D15C8264E8] PRIMARY KEY CLUSTERED 
(
	[idProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[catProducts] ADD  DEFAULT ((1)) FOR [statusCat]
GO
ALTER TABLE [dbo].[products] ADD  CONSTRAINT [DF__products__status__37A5467C]  DEFAULT ((1)) FOR [statusProduct]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD FOREIGN KEY([categoryProduct])
REFERENCES [dbo].[catProducts] ([idCat])
GO
/****** Object:  StoredProcedure [dbo].[spC_getCategories]    Script Date: 25/03/2025 06:59:16 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Valdez
-- Create date: 25/03/2025
-- Description:	Consulta las categorias activas
-- =============================================
CREATE PROCEDURE [dbo].[spC_getCategories]
AS
BEGIN
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		idCat,
		nameCat
	FROM catProducts WHERE statusCat = 1
END
GO
/****** Object:  StoredProcedure [dbo].[spC_getProductById]    Script Date: 25/03/2025 06:59:16 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Valdez
-- Create date: 25/03/2025
-- Description:	Consulta un producto especifico
-- =============================================
CREATE PROCEDURE [dbo].[spC_getProductById] 
	@idProduct INT
AS
BEGIN
	SET NOCOUNT ON;

    SELECT 
		nameProduct,
		priceProduct,
		categoryProduct
	FROM products WHERE idProduct = @idProduct
END
GO
/****** Object:  StoredProcedure [dbo].[spC_getProducts]    Script Date: 25/03/2025 06:59:16 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Valdez
-- Create date: 25/03/2025
-- Description:	Consulta los productos activos
-- =============================================
CREATE PROCEDURE [dbo].[spC_getProducts]
AS
BEGIN
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		p.idProduct,
		p.nameProduct,
		p.priceProduct,
		c.nameCat AS categoryProduct
	FROM products p
	INNER JOIN catProducts c
	ON p.categoryProduct = c.idCat
	WHERE statusProduct = 1
END
GO
/****** Object:  StoredProcedure [dbo].[spI_insertProduct]    Script Date: 25/03/2025 06:59:16 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Valdez
-- Create date: 25/03/2025
-- Description:	Inserta información básica de un producto
-- =============================================
CREATE PROCEDURE [dbo].[spI_insertProduct] 
	@nameProduct VARCHAR(150), 
	@priceProduct FLOAT,
	@catProduct INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @newProductId INT
    -- Insert statements for procedure here
	INSERT INTO products( nameProduct, priceProduct, categoryProduct )
	VALUES (
		@nameProduct,
		@priceProduct,
		@catProduct
	)

	SET @newProductId = SCOPE_IDENTITY();
	SELECT @newProductId AS id
END
GO
/****** Object:  StoredProcedure [dbo].[spU_deleteProduct]    Script Date: 25/03/2025 06:59:16 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Valdez
-- Create date: 25/03/2025
-- Description:	Elimina un producto
-- =============================================
CREATE PROCEDURE [dbo].[spU_deleteProduct] 
	@idProduct INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @uProductId INT
    -- Insert statements for procedure here
	UPDATE products SET
		statusProduct = 0
	WHERE idProduct = @idProduct

	SET @uProductId = SCOPE_IDENTITY();
	SELECT @uProductId AS id
END
GO
/****** Object:  StoredProcedure [dbo].[spU_updateProducts]    Script Date: 25/03/2025 06:59:16 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Joshua Valdez
-- Create date: 25/03/2025
-- Description:	Actualiza un producto
-- =============================================
CREATE PROCEDURE [dbo].[spU_updateProducts]
	@idProduct INT,
	@nameProduct VARCHAR(150), 
	@priceProduct FLOAT,
	@catProduct INT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @uProductId INT
	UPDATE products SET
		nameProduct = @nameProduct,
		priceProduct = @priceProduct,
		categoryProduct = @catProduct
	WHERE idProduct = @idProduct

	SET @uProductId = SCOPE_IDENTITY();
	SELECT @uProductId AS id
END
GO
USE [master]
GO
ALTER DATABASE [productos_demo] SET  READ_WRITE 
GO
