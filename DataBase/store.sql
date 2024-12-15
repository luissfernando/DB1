-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-04-2016 a las 18:57:38
-- Versión del servidor: 5.6.21
-- Versión de PHP: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `store`
--
CREATE DATABASE IF NOT EXISTS `store` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `store`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--
CREATE TABLE IF NOT EXISTS `administrador` (
  `Nombre` varchar(30) NOT NULL,
  `Clave` text NOT NULL,
  PRIMARY KEY (`Nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--
CREATE TABLE IF NOT EXISTS `categoria` (
  `CodigoCat` varchar(30) NOT NULL,
  `Nombre` varchar(30) NOT NULL,
  `Descripcion` text NOT NULL,
  PRIMARY KEY (`CodigoCat`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--
CREATE TABLE IF NOT EXISTS `cliente` (
  `NIT` varchar(30) NOT NULL,
  `Nombre` varchar(30) NOT NULL,
  `NombreCompleto` varchar(70) NOT NULL,
  `Apellido` varchar(70) NOT NULL,
  `Clave` text NOT NULL,
  `Direccion` varchar(200) NOT NULL,
  `Telefono` int(20) NOT NULL,
  `Email` varchar(30) NOT NULL,
  PRIMARY KEY (`NIT`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle`
--
CREATE TABLE IF NOT EXISTS `detalle` (
  `NumPedido` int(20) NOT NULL,
  `CodigoProd` varchar(30) NOT NULL,
  `CantidadProductos` int(20) NOT NULL,
  PRIMARY KEY (`NumPedido`, `CodigoProd`),
  FOREIGN KEY (`NumPedido`) REFERENCES `venta` (`NumPedido`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`CodigoProd`) REFERENCES `producto` (`CodigoProd`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--
CREATE TABLE IF NOT EXISTS `producto` (
  `CodigoProd` varchar(30) NOT NULL,
  `NombreProd` varchar(30) NOT NULL,
  `CodigoCat` varchar(30) NOT NULL,
  `Precio` decimal(30,2) NOT NULL,
  `Modelo` varchar(30) NOT NULL,
  `Marca` varchar(30) NOT NULL,
  `Stock` int(20) NOT NULL,
  `NITProveedor` varchar(30) NOT NULL,
  `Imagen` varchar(150) NOT NULL,
  PRIMARY KEY (`CodigoProd`),
  FOREIGN KEY (`CodigoCat`) REFERENCES `categoria` (`CodigoCat`) ON UPDATE CASCADE,
  FOREIGN KEY (`NITProveedor`) REFERENCES `proveedor` (`NITProveedor`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--
CREATE TABLE IF NOT EXISTS `proveedor` (
  `NITProveedor` varchar(30) NOT NULL,
  `NombreProveedor` varchar(30) NOT NULL,
  `Direccion` varchar(200) NOT NULL,
  `Telefono` int(20) NOT NULL,
  `PaginaWeb` varchar(30) NOT NULL,
  PRIMARY KEY (`NITProveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--
CREATE TABLE IF NOT EXISTS `venta` (
  `NumPedido` int(20) NOT NULL AUTO_INCREMENT,
  `Fecha` varchar(150) NOT NULL,
  `NIT` varchar(30) NOT NULL,
  `Descuento` int(20) NOT NULL,
  `TotalPagar` decimal(30,2) NOT NULL,
  `Estado` varchar(150) NOT NULL,
  PRIMARY KEY (`NumPedido`),
  FOREIGN KEY (`NIT`) REFERENCES `cliente` (`NIT`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plataforma`
--
CREATE TABLE IF NOT EXISTS `plataforma` (
  `CodigoPlataforma` varchar(30) NOT NULL,
  `NombrePlataforma` varchar(50) NOT NULL,
  PRIMARY KEY (`CodigoPlataforma`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genero_videojuego`
--
CREATE TABLE IF NOT EXISTS `genero_videojuego` (
  `CodigoGenero` varchar(30) NOT NULL,
  `NombreGenero` varchar(50) NOT NULL,
  PRIMARY KEY (`CodigoGenero`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `promocion`
--
CREATE TABLE IF NOT EXISTS `promocion` (
  `CodigoPromocion` varchar(30) NOT NULL,
  `Descripcion` text NOT NULL,
  `Descuento` decimal(5,2) NOT NULL,
  `FechaInicio` date NOT NULL,
  `FechaFin` date NOT NULL,
  PRIMARY KEY (`CodigoPromocion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodo_pago`
--
CREATE TABLE IF NOT EXISTS `metodo_pago` (
  `CodigoMetodo` varchar(30) NOT NULL,
  `NombreMetodo` varchar(50) NOT NULL,
  PRIMARY KEY (`CodigoMetodo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resena`
--
CREATE TABLE IF NOT EXISTS `resena` (
  `CodigoResena` int(20) NOT NULL AUTO_INCREMENT,
  `CodigoProd` varchar(30) NOT NULL,
  `NITCliente` varchar(30) NOT NULL,
  `Calificacion` int(1) NOT NULL,
  `Comentario` text NOT NULL,
  PRIMARY KEY (`CodigoResena`),
  FOREIGN KEY (`CodigoProd`) REFERENCES `producto` (`CodigoProd`) ON UPDATE CASCADE,
  FOREIGN KEY (`NITCliente`) REFERENCES `cliente` (`NIT`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--
CREATE TABLE IF NOT EXISTS `inventario` (
  `CodigoInventario` int(20) NOT NULL AUTO_INCREMENT,
  `CodigoProd` varchar(30) NOT NULL,
  `Cantidad` int(20) NOT NULL,
  `FechaMovimiento` date NOT NULL,
  `TipoMovimiento` varchar(20) NOT NULL,
  PRIMARY KEY (`CodigoInventario`),
  FOREIGN KEY (`CodigoProd`) REFERENCES `producto` (`CodigoProd`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
