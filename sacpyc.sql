-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-12-2014 a las 06:32:47
-- Versión del servidor: 5.6.20
-- Versión de PHP: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `sacpyc`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE IF NOT EXISTS `administrador` (
  `CORREO_ADMIN` varchar(45) NOT NULL,
  `CLAVE_ADMIN` varchar(45) DEFAULT NULL,
  `NOMBRE_ADMIN` varchar(25) DEFAULT NULL,
  `APELLIDO` varchar(25) DEFAULT NULL,
  `ROL` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla que guarda los datos para el login de los administrado';

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`CORREO_ADMIN`, `CLAVE_ADMIN`, `NOMBRE_ADMIN`, `APELLIDO`, `ROL`) VALUES
('ariel.merino@usach.cl', 'admin', 'Ariel', 'Meriño', 'Admin'),
('benjart91@gmail.com', 'admin', 'Benjamin', 'Ruiz-Tagle', 'Admin'),
('JJtagle@gmail.com', 'qwerty', 'Juan Jose', 'Ruiz-Tagle', 'Admin'),
('maximiliano.perez@usach.cl', 'qwerty', 'Maximiliano', 'Perez', 'Admin');

--
-- Disparadores `administrador`
--
DELIMITER //
CREATE TRIGGER `integridadAdmin` BEFORE INSERT ON `administrador`
 FOR EACH ROW IF NEW.correo_admin NOT LIKE '%@%.%' THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadAdminUpd` BEFORE UPDATE ON `administrador`
 FOR EACH ROW IF NEW.correo_admin NOT LIKE '%@%.%' THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agendamiento_evento`
--

CREATE TABLE IF NOT EXISTS `agendamiento_evento` (
`IDAGENDAMIENTOEVENTO` int(11) NOT NULL,
  `ID_COTIZACION` int(11) NOT NULL,
  `FECHA_AGENDAMIENTO_EVENTO` datetime DEFAULT NULL,
  `DURACION_AGENDAMIENTO_EVENTO` int(11) DEFAULT NULL,
  `ESTADO` varchar(10) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Tabla que almacena los datos relacionados al agendamiento de' AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `agendamiento_evento`
--

INSERT INTO `agendamiento_evento` (`IDAGENDAMIENTOEVENTO`, `ID_COTIZACION`, `FECHA_AGENDAMIENTO_EVENTO`, `DURACION_AGENDAMIENTO_EVENTO`, `ESTADO`) VALUES
(1, 2, '2014-12-18 23:00:00', 10, 'terminadi');

--
-- Disparadores `agendamiento_evento`
--
DELIMITER //
CREATE TRIGGER `integridadAgenda` BEFORE INSERT ON `agendamiento_evento`
 FOR EACH ROW IF NOT (NEW.duracion_agendamiento_evento>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadAgendaUpd` BEFORE UPDATE ON `agendamiento_evento`
 FOR EACH ROW IF NOT (NEW.duracion_agendamiento_evento>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auditoria`
--

CREATE TABLE IF NOT EXISTS `auditoria` (
`ID_AUDITORIA` int(11) NOT NULL,
  `USUARIO` int(11) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  `TABLA` varchar(30) DEFAULT NULL,
  `OPERACION` varchar(10) DEFAULT NULL,
  `ATRIBUTO` varchar(20) DEFAULT NULL,
  `VALORANTES` varchar(100) DEFAULT NULL,
  `VALORDESPUES` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla que almacena todos los cambios realizados en la base d' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cantidad_historica`
--

CREATE TABLE IF NOT EXISTS `cantidad_historica` (
  `CANTIDAD` int(11) DEFAULT NULL,
  `NUMERO_PERSONAS` int(11) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  `IDTIPOEVENTO` int(11) NOT NULL,
  `IDITEM` int(11) NOT NULL,
`IDHISTORICO` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `cantidad_historica`
--

INSERT INTO `cantidad_historica` (`CANTIDAD`, `NUMERO_PERSONAS`, `FECHA`, `IDTIPOEVENTO`, `IDITEM`, `IDHISTORICO`) VALUES
(4, 30, '2014-12-07', 2, 4, 1),
(2, 15, '2014-12-07', 4, 10, 2);

--
-- Disparadores `cantidad_historica`
--
DELIMITER //
CREATE TRIGGER `integridadCantidadHis` BEFORE INSERT ON `cantidad_historica`
 FOR EACH ROW IF NOT (NEW.cantidad>0) AND NOT (NEW.numero_personas>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integtridadCanHisUpd` BEFORE UPDATE ON `cantidad_historica`
 FOR EACH ROW IF NOT (NEW.cantidad>0) AND NOT (NEW.numero_personas>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE IF NOT EXISTS `cliente` (
  `MAIL_CLIENTE` varchar(45) NOT NULL,
  `TELEFONO_CLIENTE` int(11) DEFAULT NULL,
  `NOMBRE_CLIENTE` varchar(25) DEFAULT NULL,
  `APELLIDO_CLIENTE` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Registro de los clientes que han realizado cotizaciones.';

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`MAIL_CLIENTE`, `TELEFONO_CLIENTE`, `NOMBRE_CLIENTE`, `APELLIDO_CLIENTE`) VALUES
('gabriel.godoy@usach.cl', 85209598, 'Gabriel', 'Godoy'),
('rusiox_x@homail.com', 98019877, 'Daniel', 'Vargas');

--
-- Disparadores `cliente`
--
DELIMITER //
CREATE TRIGGER `integridadCliente` BEFORE INSERT ON `cliente`
 FOR EACH ROW IF NOT (NEW.telefono_cliente>0) AND NEW.mail_cliente NOT LIKE '%@%.%' THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadClienteUpd` BEFORE UPDATE ON `cliente`
 FOR EACH ROW IF NOT (NEW.telefono_cliente>0) AND NEW.mail_cliente NOT LIKE '%@%.%' THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra_ingrediente`
--

CREATE TABLE IF NOT EXISTS `compra_ingrediente` (
`IDCOMPRAINGREDIENTE` int(11) NOT NULL,
  `IDPROVEEDORINGREDIENTE` int(11) DEFAULT NULL,
  `TOTAL_COMPRA_INGREDIENTE` int(11) DEFAULT NULL,
  `FECHA_COMPRA_INGREDIENTE` datetime DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Registro de las compras realizadas a cada proveedor.' AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `compra_ingrediente`
--

INSERT INTO `compra_ingrediente` (`IDCOMPRAINGREDIENTE`, `IDPROVEEDORINGREDIENTE`, `TOTAL_COMPRA_INGREDIENTE`, `FECHA_COMPRA_INGREDIENTE`) VALUES
(1, 1, 10000, '2014-12-03 15:30:00'),
(2, 1, 60500, '2014-12-12 12:00:00'),
(3, 2, 12000, '2014-11-20 14:00:00');

--
-- Disparadores `compra_ingrediente`
--
DELIMITER //
CREATE TRIGGER `integridadCompraIng` BEFORE INSERT ON `compra_ingrediente`
 FOR EACH ROW IF NOT (NEW.total_compra_ingrediente>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadCompraIngUpd` BEFORE UPDATE ON `compra_ingrediente`
 FOR EACH ROW IF NOT (NEW.total_compra_ingrediente>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra_ingrediente_ingrediente`
--

CREATE TABLE IF NOT EXISTS `compra_ingrediente_ingrediente` (
  `CANTIDAD_COMPRA_INGREDIENTE` int(11) DEFAULT NULL,
  `PRECIO_COMPRA_INGREDIENTE` int(11) DEFAULT NULL,
`IDCOMPRAINGREDIENTEINGREDIENTE` int(11) NOT NULL,
  `IDINGREDIENTE` int(11) NOT NULL,
  `IDCOMPRAINGREDIENTE` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Detalle de los ingredientes de una compra espec?fica.' AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `compra_ingrediente_ingrediente`
--

INSERT INTO `compra_ingrediente_ingrediente` (`CANTIDAD_COMPRA_INGREDIENTE`, `PRECIO_COMPRA_INGREDIENTE`, `IDCOMPRAINGREDIENTEINGREDIENTE`, `IDINGREDIENTE`, `IDCOMPRAINGREDIENTE`) VALUES
(4, 2000, 1, 2, 1),
(1, 1500, 2, 4, 1),
(8, 600, 3, 6, 1);

--
-- Disparadores `compra_ingrediente_ingrediente`
--
DELIMITER //
CREATE TRIGGER `actualizarStockIngrediente` AFTER INSERT ON `compra_ingrediente_ingrediente`
 FOR EACH ROW UPDATE ingrediente SET stock_ingrediente=stock_ingrediente+(SELECT NEW.cantidad_compra_ingrediente) WHERE idingrediente=NEW.idingrediente
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadCompraIngIng` BEFORE INSERT ON `compra_ingrediente_ingrediente`
 FOR EACH ROW IF NOT (NEW.cantidad_compra_ingrediente>0) AND NOT (NEW.precio_compra_ingrediente>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadCompraIngIngUpd` BEFORE UPDATE ON `compra_ingrediente_ingrediente`
 FOR EACH ROW IF NOT (NEW.cantidad_compra_ingrediente>0) AND NOT (NEW.precio_compra_ingrediente>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra_utensilio`
--

CREATE TABLE IF NOT EXISTS `compra_utensilio` (
`IDCOMPRAUTENSILIO` int(11) NOT NULL,
  `IDPROVEEDORUTENSILIO` int(11) DEFAULT NULL,
  `TOTAL_COMPRA_UTENSILIO` int(11) DEFAULT NULL,
  `FECHA_COMPRA_UTENSILIO` datetime DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `compra_utensilio`
--

INSERT INTO `compra_utensilio` (`IDCOMPRAUTENSILIO`, `IDPROVEEDORUTENSILIO`, `TOTAL_COMPRA_UTENSILIO`, `FECHA_COMPRA_UTENSILIO`) VALUES
(1, 1, 50000, '2014-10-01 14:30:00'),
(2, 1, 30000, '2014-12-01 17:00:00');

--
-- Disparadores `compra_utensilio`
--
DELIMITER //
CREATE TRIGGER `integridadCompraUtensilio` BEFORE INSERT ON `compra_utensilio`
 FOR EACH ROW IF NOT (NEW.total_compra_utensilio>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadcomprautensilioUpd` BEFORE UPDATE ON `compra_utensilio`
 FOR EACH ROW IF NOT (NEW.total_compra_utensilio>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra_utensilio_utensilio`
--

CREATE TABLE IF NOT EXISTS `compra_utensilio_utensilio` (
  `CANTIDAD_COMPRA_UTENSILIO` int(11) DEFAULT NULL,
  `PRECIO_COMPRA_UTENSILIO` int(11) DEFAULT NULL,
`IDCOMPRAUTENSILIOUTENSILIO` int(11) NOT NULL,
  `IDCOMPRAUTENSILIO` int(11) NOT NULL,
  `IDUTENSILIO` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Detalle de los utensilios comprados en una "compra" espec?fi' AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `compra_utensilio_utensilio`
--

INSERT INTO `compra_utensilio_utensilio` (`CANTIDAD_COMPRA_UTENSILIO`, `PRECIO_COMPRA_UTENSILIO`, `IDCOMPRAUTENSILIOUTENSILIO`, `IDCOMPRAUTENSILIO`, `IDUTENSILIO`) VALUES
(10, 3000, 1, 1, 2),
(12, 10000, 2, 1, 2),
(1, 500, 3, 2, 3),
(3, 1500, 4, 1, 1),
(10, 10000, 5, 2, 2);

--
-- Disparadores `compra_utensilio_utensilio`
--
DELIMITER //
CREATE TRIGGER `actualizarStockUtensilio` AFTER INSERT ON `compra_utensilio_utensilio`
 FOR EACH ROW UPDATE utensilio SET stock_utensilio=stock_utensilio+(SELECT NEW.cantidad_compra_utensilio) WHERE idutensilio=NEW.idutensilio
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadCompraUtensilioUtensilio` BEFORE INSERT ON `compra_utensilio_utensilio`
 FOR EACH ROW IF NOT (NEW.cantidad_compra_utensilio>0) AND NOT (NEW.precio_compra_utensilio>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadCompraUtensilioUtensilioUpd` BEFORE UPDATE ON `compra_utensilio_utensilio`
 FOR EACH ROW IF NOT (NEW.cantidad_compra_utensilio>0) AND NOT (NEW.precio_compra_utensilio>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizacion`
--

CREATE TABLE IF NOT EXISTS `cotizacion` (
`ID_COTIZACION` int(11) NOT NULL,
  `IDSOLICITUDCOTIZACION` int(11) NOT NULL,
  `ESTADO_ACEPTACION` varchar(10) DEFAULT NULL,
  `VALOR_COTIZACION` int(11) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Tabla que contiene las cotizaciones creadas como respuestas ' AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `cotizacion`
--

INSERT INTO `cotizacion` (`ID_COTIZACION`, `IDSOLICITUDCOTIZACION`, `ESTADO_ACEPTACION`, `VALOR_COTIZACION`) VALUES
(1, 2, 'Pendiente', 100000),
(2, 3, 'acordado', 100000);

--
-- Disparadores `cotizacion`
--
DELIMITER //
CREATE TRIGGER `agendarEvento` AFTER UPDATE ON `cotizacion`
 FOR EACH ROW IF NEW.estado_aceptacion='acordado' THEN
INSERT INTO agendamiento_evento(id_cotizacion,fecha_agendamiento_evento,duracion_agendamiento_evento,estado) VALUES(NEW.id_cotizacion,(SELECT fecha_tentativa FROM solicitud_de_cotizacion WHERE idsolicitudcotizacion=NEW.idsolicitudcotizacion),(SELECT duracion_tentativa FROM solicitud_de_cotizacion WHERE idsolicitudcotizacion=NEW.idsolicitudcotizacion),'pendiente');
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `generarSeguimiento` AFTER INSERT ON `cotizacion`
 FOR EACH ROW INSERT INTO seguimiento(id_cotizacion,fecha_acuerdo,fecha_vencimiento) VALUES(NEW.id_cotizacion,CURDATE(),CURDATE()+INTERVAL 3 DAY)
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadCotizacionUpd` BEFORE UPDATE ON `cotizacion`
 FOR EACH ROW IF NOT (NEW.valor_cotizacion>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integrididadCotizacion` BEFORE INSERT ON `cotizacion`
 FOR EACH ROW IF NOT (NEW.valor_cotizacion>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `garzon`
--

CREATE TABLE IF NOT EXISTS `garzon` (
  `MAIL_GARZON` varchar(45) DEFAULT NULL,
  `TELEFONO_GARZON` int(11) DEFAULT NULL,
  `NOMBRE_GARZON` varchar(25) DEFAULT NULL,
  `APELLIDO_GARZON` varchar(25) DEFAULT NULL,
`IDGARZON` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Datos necesarios para pedir disponibilidad de los garzones a' AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `garzon`
--

INSERT INTO `garzon` (`MAIL_GARZON`, `TELEFONO_GARZON`, `NOMBRE_GARZON`, `APELLIDO_GARZON`, `IDGARZON`) VALUES
('Yerko123@gmail.com', 71901245, 'Yerko', 'Palma', 1),
('susume18@hotmail.com', 90716423, 'Fernanda', 'Godoy', 2);

--
-- Disparadores `garzon`
--
DELIMITER //
CREATE TRIGGER `integridadGarzon` BEFORE INSERT ON `garzon`
 FOR EACH ROW IF NOT (NEW.telefono_garzon>0) AND NEW.mail_garzon NOT LIKE '%@%.%' THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadGarzonUpd` BEFORE UPDATE ON `garzon`
 FOR EACH ROW IF NOT (NEW.telefono_garzon>0) AND NEW.mail_garzon NOT LIKE '%@%.%' THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `garzon_evento`
--

CREATE TABLE IF NOT EXISTS `garzon_evento` (
  `RESPUESTA` varchar(5) DEFAULT NULL,
`IDGARZONEVENTO` int(11) NOT NULL,
  `IDAGENDAMIENTOEVENTO` int(11) NOT NULL,
  `IDGARZON` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Detalle de los garzones asignados para un evento.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingrediente`
--

CREATE TABLE IF NOT EXISTS `ingrediente` (
`IDINGREDIENTE` int(11) NOT NULL,
  `NOMBRE_INGREDIENTE` varchar(45) DEFAULT NULL,
  `STOCK_INGREDIENTE` int(11) DEFAULT NULL,
  `STOCK_MINIMO_INGREDIENTE` int(11) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Representa el stock del ingrediente que hay hasta el momento' AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `ingrediente`
--

INSERT INTO `ingrediente` (`IDINGREDIENTE`, `NOMBRE_INGREDIENTE`, `STOCK_INGREDIENTE`, `STOCK_MINIMO_INGREDIENTE`) VALUES
(1, 'Lechuga', 3, 0),
(2, 'Tomate', 14, 0),
(3, 'Carne Avestruz', 0, 0),
(4, 'Frutilla', 11, 0),
(5, 'Empanada Mariscos', 15, 5),
(6, 'Salsa Tomate', 16, 0);

--
-- Disparadores `ingrediente`
--
DELIMITER //
CREATE TRIGGER `integridadIngrediente` BEFORE INSERT ON `ingrediente`
 FOR EACH ROW IF NOT (NEW.stock_ingrediente>=0) AND NOT (NEW.stock_minimo_ingrediente>=0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadIngredienteUpd` BEFORE UPDATE ON `ingrediente`
 FOR EACH ROW IF NOT (NEW.stock_ingrediente>=0) AND NOT (NEW.stock_minimo_ingrediente>=0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingrediente_item`
--

CREATE TABLE IF NOT EXISTS `ingrediente_item` (
  `CANTIDAD_INGREDIENTE` int(11) DEFAULT NULL,
  `UNIDAD_INGREDIENTE` varchar(10) DEFAULT NULL,
`IDINGREDIENTEITEM` int(11) NOT NULL,
  `IDINGREDIENTE` int(11) NOT NULL,
  `IDITEM` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='La cantidad de un ingrediente con que se prepara un plato o ' AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `ingrediente_item`
--

INSERT INTO `ingrediente_item` (`CANTIDAD_INGREDIENTE`, `UNIDAD_INGREDIENTE`, `IDINGREDIENTEITEM`, `IDINGREDIENTE`, `IDITEM`) VALUES
(3, 'Unidades', 1, 1, 1),
(3, 'Unidades', 2, 2, 1),
(1, 'Kg', 3, 3, 5),
(2, 'Unidades', 4, 3, 4),
(10, 'unidades', 5, 3, 10);

--
-- Disparadores `ingrediente_item`
--
DELIMITER //
CREATE TRIGGER `integridadIngredienteItemUpd` BEFORE UPDATE ON `ingrediente_item`
 FOR EACH ROW IF NOT (NEW.cantidad_ingrediente>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadIntegridadItem` BEFORE INSERT ON `ingrediente_item`
 FOR EACH ROW IF NOT (NEW.cantidad_ingrediente>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingrediente_item_especial`
--

CREATE TABLE IF NOT EXISTS `ingrediente_item_especial` (
  `CANTIDAD_INGREDIENTE_ESPECIAL` int(11) DEFAULT NULL,
  `UNIDAD_INGREDIENTE_ESPECIAL` varchar(10) DEFAULT NULL,
`IDINGREDIENTEITEMESPECIAL` int(11) NOT NULL,
  `IDINGREDIENTE` int(11) NOT NULL,
  `ID_ITEM_ESPECIAL` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla que almacena el detalle de la cantidad de todos los in' AUTO_INCREMENT=1 ;

--
-- Disparadores `ingrediente_item_especial`
--
DELIMITER //
CREATE TRIGGER `integridadIngredienteItemEspecialUpd` BEFORE UPDATE ON `ingrediente_item_especial`
 FOR EACH ROW IF NOT (NEW.cantidad_ingrediente_especial>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadIntedienteItemEspecial` BEFORE INSERT ON `ingrediente_item_especial`
 FOR EACH ROW IF NOT (NEW.cantidad_ingrediente_especial>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `item`
--

CREATE TABLE IF NOT EXISTS `item` (
`IDITEM` int(11) NOT NULL,
  `IDTIPO` int(11) DEFAULT NULL,
  `NOMBRE_ITEM` varchar(25) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Un plato o bebida dentro de un men?.\r\n' AUTO_INCREMENT=14 ;

--
-- Volcado de datos para la tabla `item`
--

INSERT INTO `item` (`IDITEM`, `IDTIPO`, `NOMBRE_ITEM`) VALUES
(1, 1, 'Ensalada Cesar'),
(2, 1, 'Empanada de Mariscos'),
(3, 1, 'Empanada de Queso'),
(4, 2, 'Creme Brule'),
(5, 1, 'Carpacio de Avestruz'),
(6, 2, 'Panqueques Celestiales'),
(7, 3, 'Jugo de Piña'),
(8, 3, 'Jugo de Frutilla'),
(9, 3, 'Coca Cola'),
(10, 4, 'Pisco Sour'),
(11, 4, 'Amareto Sour'),
(12, 5, 'Lasagna'),
(13, 5, 'Cazuela de Pollo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `item_especial`
--

CREATE TABLE IF NOT EXISTS `item_especial` (
`ID_ITEM_ESPECIAL` int(11) NOT NULL,
  `ID_COTIZACION` int(11) NOT NULL,
  `NOMBRE_ITEM` varchar(25) DEFAULT NULL,
  `CANTIDAD` int(11) DEFAULT NULL,
  `PRECIO` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla que almacena platos o bebidas pedidos de forma especia' AUTO_INCREMENT=1 ;

--
-- Disparadores `item_especial`
--
DELIMITER //
CREATE TRIGGER `integridadItemEspecial` BEFORE INSERT ON `item_especial`
 FOR EACH ROW IF NOT (NEW.cantidad>0) AND NOT (NEW.precio>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadItemEspecialUpd` BEFORE UPDATE ON `item_especial`
 FOR EACH ROW IF NOT (NEW.cantidad>0) AND NOT (NEW.precio>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `item_menu`
--

CREATE TABLE IF NOT EXISTS `item_menu` (
`IDITEMMENU` int(11) NOT NULL,
  `IDTIPOMENU` int(11) NOT NULL,
  `IDITEM` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `item_menu`
--

INSERT INTO `item_menu` (`IDITEMMENU`, `IDTIPOMENU`, `IDITEM`) VALUES
(1, 2, 5),
(2, 6, 11),
(3, 4, 9),
(4, 3, 5),
(5, 2, 12),
(6, 3, 10),
(7, 4, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `item_solicitud_de_cotizacion`
--

CREATE TABLE IF NOT EXISTS `item_solicitud_de_cotizacion` (
  `CANTIDAD_ITEM` int(11) DEFAULT NULL,
`ITEMSOLICITUDCOTIZACION` int(11) NOT NULL,
  `IDITEM` int(11) NOT NULL,
  `IDSOLICITUDCOTIZACION` int(11) NOT NULL,
  `PRECIO_ITEM` int(11) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='El detalle de la cantidad de ?tems pedidos en una cotizaci' AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `item_solicitud_de_cotizacion`
--

INSERT INTO `item_solicitud_de_cotizacion` (`CANTIDAD_ITEM`, `ITEMSOLICITUDCOTIZACION`, `IDITEM`, `IDSOLICITUDCOTIZACION`, `PRECIO_ITEM`) VALUES
(4, 1, 4, 2, 10000),
(NULL, 2, 3, 2, NULL),
(NULL, 3, 8, 2, NULL),
(2, 4, 10, 3, NULL),
(NULL, 5, 7, 3, NULL);

--
-- Disparadores `item_solicitud_de_cotizacion`
--
DELIMITER //
CREATE TRIGGER `cantidadHistorica` AFTER UPDATE ON `item_solicitud_de_cotizacion`
 FOR EACH ROW INSERT INTO cantidad_historica(cantidad,numero_personas,fecha,idtipoevento,iditem) VALUES(NEW.cantidad_item,(SELECT cantidad_asistentes FROM solicitud_de_cotizacion WHERE idsolicitudcotizacion=NEW.idsolicitudcotizacion),CURDATE(),(SELECT idtipoevento FROM solicitud_de_cotizacion WHERE idsolicitudcotizacion=NEW.idsolicitudcotizacion),NEW.iditem)
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadItemSolicitudCotizacion` BEFORE INSERT ON `item_solicitud_de_cotizacion`
 FOR EACH ROW IF NOT (NEW.cantidad_item>0) AND NOT (NEW.precio_item>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadItemSolicitudUpd` BEFORE UPDATE ON `item_solicitud_de_cotizacion`
 FOR EACH ROW IF NOT (NEW.cantidad_item>0) AND NOT (NEW.precio_item>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor_ingrediente`
--

CREATE TABLE IF NOT EXISTS `proveedor_ingrediente` (
`IDPROVEEDORINGREDIENTE` int(11) NOT NULL,
  `NOMBRE_PROVEEDOR_INGREDIENTE` varchar(45) DEFAULT NULL,
  `TELEFONO_PROVEEDOR_INGREDIENTE` int(11) DEFAULT NULL,
  `DIRECCION_PROVEEDOR_INGREDIENTE` varchar(45) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Registro de los proveedores asociados a la banqueter?a.' AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `proveedor_ingrediente`
--

INSERT INTO `proveedor_ingrediente` (`IDPROVEEDORINGREDIENTE`, `NOMBRE_PROVEEDOR_INGREDIENTE`, `TELEFONO_PROVEEDOR_INGREDIENTE`, `DIRECCION_PROVEEDOR_INGREDIENTE`) VALUES
(1, 'Pablo Cabrales', 76291089, 'Las Garzas #4345'),
(2, 'Alejandra Solar', 89521029, 'Los Alerces #120');

--
-- Disparadores `proveedor_ingrediente`
--
DELIMITER //
CREATE TRIGGER `integridadProveedorIng` BEFORE INSERT ON `proveedor_ingrediente`
 FOR EACH ROW IF NOT (NEW.telefono_proveedor_ingrediente>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadProveedorIngUpd` BEFORE UPDATE ON `proveedor_ingrediente`
 FOR EACH ROW IF NOT (NEW.telefono_proveedor_ingrediente>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor_utensilio`
--

CREATE TABLE IF NOT EXISTS `proveedor_utensilio` (
`IDPROVEEDORUTENSILIO` int(11) NOT NULL,
  `NOMBRE_PROVEEDOR_UTENSILIO` varchar(45) DEFAULT NULL,
  `TELEFONO_PROVEEDOR_UTENSILIO` int(11) DEFAULT NULL,
  `DIRECCION_PROVEEDOR_UTENSILIO` varchar(45) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `proveedor_utensilio`
--

INSERT INTO `proveedor_utensilio` (`IDPROVEEDORUTENSILIO`, `NOMBRE_PROVEEDOR_UTENSILIO`, `TELEFONO_PROVEEDOR_UTENSILIO`, `DIRECCION_PROVEEDOR_UTENSILIO`) VALUES
(1, 'Moserrat Ariza', 61797890, 'Sol de Estrella #5000');

--
-- Disparadores `proveedor_utensilio`
--
DELIMITER //
CREATE TRIGGER `integridadProveedorUten` BEFORE INSERT ON `proveedor_utensilio`
 FOR EACH ROW IF NOT (NEW.telefono_proveedor_utensilio>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadProveedorUtenUpd` BEFORE UPDATE ON `proveedor_utensilio`
 FOR EACH ROW IF NOT (NEW.telefono_proveedor_utensilio>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento`
--

CREATE TABLE IF NOT EXISTS `seguimiento` (
`IDSEGUIMIENTO` int(11) NOT NULL,
  `ID_COTIZACION` int(11) NOT NULL,
  `FECHA_ACUERDO` date DEFAULT NULL,
  `FECHA_VENCIMIENTO` date DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='El seguimiento permite ver si el cliente ha respondido o no ' AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `seguimiento`
--

INSERT INTO `seguimiento` (`IDSEGUIMIENTO`, `ID_COTIZACION`, `FECHA_ACUERDO`, `FECHA_VENCIMIENTO`) VALUES
(1, 1, '2014-12-07', '2014-12-10'),
(2, 2, '2014-12-07', '2014-12-10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitud_de_cotizacion`
--

CREATE TABLE IF NOT EXISTS `solicitud_de_cotizacion` (
`IDSOLICITUDCOTIZACION` int(11) NOT NULL,
  `MAIL_CLIENTE` varchar(45) NOT NULL,
  `IDTIPOEVENTO` int(11) DEFAULT NULL,
  `CANTIDAD_ASISTENTES` int(11) unsigned DEFAULT NULL,
  `FECHA_TENTATIVA` datetime DEFAULT NULL,
  `DURACION_TENTATIVA` int(11) unsigned DEFAULT NULL,
  `COMENTARIOS_` varchar(250) DEFAULT NULL,
  `NOMBRE_EVENTO` varchar(25) DEFAULT NULL,
  `DIRECCION_EVENTO` varchar(128) DEFAULT NULL,
  `ESTADO_SOLICITUD` varchar(20) DEFAULT 'generada'
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Tabla que contiene las solicitudes de cotizaci?n creadas por' AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `solicitud_de_cotizacion`
--

INSERT INTO `solicitud_de_cotizacion` (`IDSOLICITUDCOTIZACION`, `MAIL_CLIENTE`, `IDTIPOEVENTO`, `CANTIDAD_ASISTENTES`, `FECHA_TENTATIVA`, `DURACION_TENTATIVA`, `COMENTARIOS_`, `NOMBRE_EVENTO`, `DIRECCION_EVENTO`, `ESTADO_SOLICITUD`) VALUES
(2, 'gabriel.godoy@usach.cl', 2, 30, '2014-12-12 15:00:00', 8, 'Necesito que toda la comida sea vegetariana', 'Matrimonio Gabriel', 'Apoquindo #4512', 'generada'),
(3, 'rusiox_x@homail.com', 4, 15, '2014-12-18 23:00:00', 10, NULL, 'Cumple Rusio', 'Ricardo Lyon #2653', 'generada');

--
-- Disparadores `solicitud_de_cotizacion`
--
DELIMITER //
CREATE TRIGGER `integridadSolicitudCoti` BEFORE INSERT ON `solicitud_de_cotizacion`
 FOR EACH ROW IF NEW.mail_cliente NOT LIKE '%@%.%' AND NOT (NEW.cantidad_asistentes>0) AND (NEW.duracion_tentativa>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadSolicitudCotiUpd` BEFORE UPDATE ON `solicitud_de_cotizacion`
 FOR EACH ROW IF NEW.mail_cliente NOT LIKE '%@%.%' AND NOT (NEW.cantidad_asistentes>0) AND (NEW.duracion_tentativa>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_evento`
--

CREATE TABLE IF NOT EXISTS `tipo_evento` (
`IDTIPOEVENTO` int(11) NOT NULL,
  `NOMBRE_TIPO_EVENTO` varchar(25) DEFAULT NULL,
  `VISIBLE` tinyint(1) DEFAULT NULL,
  `DESRIPCION_EVENTO` varchar(1024) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='El tipo de evento al que corresponde el men?.\r\nEjemplo:' AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `tipo_evento`
--

INSERT INTO `tipo_evento` (`IDTIPOEVENTO`, `NOMBRE_TIPO_EVENTO`, `VISIBLE`, `DESRIPCION_EVENTO`) VALUES
(2, 'Matrimonio', 1, 'Platos y bebidas pensados para tener una agradable velada en el inicio de su nueva vida'),
(3, 'Cofee Break', 0, 'Pensado en desayunos y onces de oficina'),
(4, 'Cumpleaños', 1, 'Niños, adultos y adultos mayores. Tenemos platos pensados para todas las edades y todos los gustos');

--
-- Disparadores `tipo_evento`
--
DELIMITER //
CREATE TRIGGER `integridadTipoEvento` BEFORE INSERT ON `tipo_evento`
 FOR EACH ROW IF (NEW.visible!=0 AND NEW.visible!=1) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadTipoEventoUpd` BEFORE UPDATE ON `tipo_evento`
 FOR EACH ROW IF NEW.visible!=0 AND NEW.visible!=1 THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_item`
--

CREATE TABLE IF NOT EXISTS `tipo_item` (
`IDTIPO` int(11) NOT NULL,
  `NOMBRE_TIPO` varchar(25) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Representa a la categor?a de un plato, ejemplo: fondo, entra' AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `tipo_item`
--

INSERT INTO `tipo_item` (`IDTIPO`, `NOMBRE_TIPO`) VALUES
(1, 'Entrada'),
(2, 'Postre'),
(3, 'Bebida'),
(4, 'Coctail'),
(5, 'Plato Fondo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_menu`
--

CREATE TABLE IF NOT EXISTS `tipo_menu` (
`IDTIPOMENU` int(11) NOT NULL,
  `IDTIPOEVENTO` int(11) DEFAULT NULL,
  `NOMBRE_TIPO_MENU` varchar(25) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='La categor?a de los platos que habr? en el men?.\r\nEjemp' AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `tipo_menu`
--

INSERT INTO `tipo_menu` (`IDTIPOMENU`, `IDTIPOEVENTO`, `NOMBRE_TIPO_MENU`) VALUES
(1, 2, 'Básico'),
(2, 2, 'Estandar'),
(3, 2, 'Premium'),
(4, 3, 'Básico'),
(5, 4, 'Básico'),
(6, 4, 'Estandar'),
(7, 4, 'Premium');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_utensilio`
--

CREATE TABLE IF NOT EXISTS `tipo_utensilio` (
`IDTIPOUTENSILIO` int(11) NOT NULL,
  `NOMBRE_TIPO_UTENSILIO` varchar(25) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Generalizaci?n de un utencilio, ejemplo : bandeja, taza, etc' AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `tipo_utensilio`
--

INSERT INTO `tipo_utensilio` (`IDTIPOUTENSILIO`, `NOMBRE_TIPO_UTENSILIO`) VALUES
(1, 'Cuchara'),
(2, 'Cuchillo'),
(3, 'Tenedor'),
(4, 'Vaso');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `utensilio`
--

CREATE TABLE IF NOT EXISTS `utensilio` (
`IDUTENSILIO` int(11) NOT NULL,
  `IDTIPOUTENSILIO` int(11) DEFAULT NULL,
  `NOMBRE_UTENSILIO` varchar(25) DEFAULT NULL,
  `STOCK_UTENSILIO` int(11) DEFAULT NULL,
  `STOCK_MINIMO_UTENSILIO` int(11) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Corresponde a un objeto espec?fico, que ser? llevado a un ev' AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `utensilio`
--

INSERT INTO `utensilio` (`IDUTENSILIO`, `IDTIPOUTENSILIO`, `NOMBRE_UTENSILIO`, `STOCK_UTENSILIO`, `STOCK_MINIMO_UTENSILIO`) VALUES
(1, 1, 'Cuchara Sopera', 13, 5),
(2, 4, 'Garza', 42, 3),
(3, 4, 'Trago Largo', 11, 0),
(4, 3, 'Tenedor Ensalada', 10, 4);

--
-- Disparadores `utensilio`
--
DELIMITER //
CREATE TRIGGER `integridadUtensilio` BEFORE INSERT ON `utensilio`
 FOR EACH ROW IF NOT (NEW.stock_utensilio>=0) AND NOT (NEW.stock_minimo_utensilio>=0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadUtensilioUpd` BEFORE UPDATE ON `utensilio`
 FOR EACH ROW IF NOT (NEW.stock_utensilio>=0) AND NOT (NEW.stock_minimo_utensilio>=0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `utensilio_evento`
--

CREATE TABLE IF NOT EXISTS `utensilio_evento` (
  `UTENSILIOS_UTILIZADOS` int(11) DEFAULT NULL,
  `UTENSILIOS_ROTOS` int(11) DEFAULT NULL,
`IDUTENSILIOEVENTO` int(11) NOT NULL,
  `IDUTENSILIO` int(11) NOT NULL,
  `IDAGENDAMIENTOEVENTO` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Permite mantener el registro de la cantidad de elementos que' AUTO_INCREMENT=1 ;

--
-- Disparadores `utensilio_evento`
--
DELIMITER //
CREATE TRIGGER `integridadUtensilioEvento` BEFORE INSERT ON `utensilio_evento`
 FOR EACH ROW IF NOT (NEW.utensilios_utilizados>0) AND NOT (NEW.utensilios_rotos>=0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadUtensilioEventoUpd` BEFORE UPDATE ON `utensilio_evento`
 FOR EACH ROW IF NOT (NEW.utensilios_utilizados>0) AND NOT (NEW.utensilios_rotos>=0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `stockUtensilio` AFTER INSERT ON `utensilio_evento`
 FOR EACH ROW UPDATE utensilio SET stock_utensilio=stock_utensilio-NEW.utensilios_rotos WHERE idutensilio=NEW.idutensilio
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `utensilio_item`
--

CREATE TABLE IF NOT EXISTS `utensilio_item` (
  `CANTIDADITEM` int(11) DEFAULT NULL,
  `CANTIDADUTENSILIO` int(11) DEFAULT NULL,
`IDUTENSILIOITEM` int(11) NOT NULL,
  `IDITEM` int(11) NOT NULL,
  `IDUTENSILIO` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `utensilio_item`
--

INSERT INTO `utensilio_item` (`CANTIDADITEM`, `CANTIDADUTENSILIO`, `IDUTENSILIOITEM`, `IDITEM`, `IDUTENSILIO`) VALUES
(1, 1, 1, 1, 4),
(1, 1, 2, 11, 3);

--
-- Disparadores `utensilio_item`
--
DELIMITER //
CREATE TRIGGER `integridadUtensilioItem` BEFORE INSERT ON `utensilio_item`
 FOR EACH ROW IF NOT (NEW.cantidaditem>0) AND NOT (NEW.cantidadutensilio>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER `integridadUtensilioItemUpd` BEFORE UPDATE ON `utensilio_item`
 FOR EACH ROW IF NOT (NEW.cantidaditem>0) AND NOT (NEW.cantidadutensilio>0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Datos no validos';
END IF
//
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
 ADD PRIMARY KEY (`CORREO_ADMIN`);

--
-- Indices de la tabla `agendamiento_evento`
--
ALTER TABLE `agendamiento_evento`
 ADD PRIMARY KEY (`IDAGENDAMIENTOEVENTO`), ADD KEY `FK_RELATIONSHIP_29` (`ID_COTIZACION`);

--
-- Indices de la tabla `auditoria`
--
ALTER TABLE `auditoria`
 ADD PRIMARY KEY (`ID_AUDITORIA`);

--
-- Indices de la tabla `cantidad_historica`
--
ALTER TABLE `cantidad_historica`
 ADD PRIMARY KEY (`IDHISTORICO`), ADD KEY `FK_RELATIONSHIP_31` (`IDTIPOEVENTO`), ADD KEY `FK_RELATIONSHIP_32` (`IDITEM`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
 ADD PRIMARY KEY (`MAIL_CLIENTE`);

--
-- Indices de la tabla `compra_ingrediente`
--
ALTER TABLE `compra_ingrediente`
 ADD PRIMARY KEY (`IDCOMPRAINGREDIENTE`), ADD KEY `FK_RELATIONSHIP_36` (`IDPROVEEDORINGREDIENTE`);

--
-- Indices de la tabla `compra_ingrediente_ingrediente`
--
ALTER TABLE `compra_ingrediente_ingrediente`
 ADD PRIMARY KEY (`IDCOMPRAINGREDIENTEINGREDIENTE`), ADD KEY `FK_RELATIONSHIP_37` (`IDCOMPRAINGREDIENTE`), ADD KEY `FK_R20` (`IDINGREDIENTE`);

--
-- Indices de la tabla `compra_utensilio`
--
ALTER TABLE `compra_utensilio`
 ADD PRIMARY KEY (`IDCOMPRAUTENSILIO`), ADD KEY `FK_RELATIONSHIP_38` (`IDPROVEEDORUTENSILIO`);

--
-- Indices de la tabla `compra_utensilio_utensilio`
--
ALTER TABLE `compra_utensilio_utensilio`
 ADD PRIMARY KEY (`IDCOMPRAUTENSILIOUTENSILIO`), ADD KEY `FK_RELATIONSHIP_39` (`IDCOMPRAUTENSILIO`), ADD KEY `FK_R22` (`IDUTENSILIO`);

--
-- Indices de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
 ADD PRIMARY KEY (`ID_COTIZACION`), ADD KEY `FK_RELATIONSHIP_30` (`IDSOLICITUDCOTIZACION`);

--
-- Indices de la tabla `garzon`
--
ALTER TABLE `garzon`
 ADD PRIMARY KEY (`IDGARZON`);

--
-- Indices de la tabla `garzon_evento`
--
ALTER TABLE `garzon_evento`
 ADD PRIMARY KEY (`IDGARZONEVENTO`), ADD KEY `FK_ACEPTA_O_RECHAZA` (`IDGARZON`), ADD KEY `FK_RELATIONSHIP_10` (`IDAGENDAMIENTOEVENTO`);

--
-- Indices de la tabla `ingrediente`
--
ALTER TABLE `ingrediente`
 ADD PRIMARY KEY (`IDINGREDIENTE`);

--
-- Indices de la tabla `ingrediente_item`
--
ALTER TABLE `ingrediente_item`
 ADD PRIMARY KEY (`IDINGREDIENTEITEM`), ADD KEY `FK_RELATIONSHIP_4` (`IDITEM`), ADD KEY `FK_RELATIONSHIP_5` (`IDINGREDIENTE`);

--
-- Indices de la tabla `ingrediente_item_especial`
--
ALTER TABLE `ingrediente_item_especial`
 ADD PRIMARY KEY (`IDINGREDIENTEITEMESPECIAL`), ADD KEY `FK_RELATIONSHIP_34` (`IDINGREDIENTE`), ADD KEY `FK_RELATIONSHIP_35` (`ID_ITEM_ESPECIAL`);

--
-- Indices de la tabla `item`
--
ALTER TABLE `item`
 ADD PRIMARY KEY (`IDITEM`), ADD KEY `FK_RELATIONSHIP_3` (`IDTIPO`);

--
-- Indices de la tabla `item_especial`
--
ALTER TABLE `item_especial`
 ADD PRIMARY KEY (`ID_ITEM_ESPECIAL`), ADD KEY `FK_RELATIONSHIP_28` (`ID_COTIZACION`);

--
-- Indices de la tabla `item_menu`
--
ALTER TABLE `item_menu`
 ADD PRIMARY KEY (`IDITEMMENU`), ADD KEY `FK_RELATIONSHIP_41` (`IDTIPOMENU`), ADD KEY `FK_RELATIONSHIP_42` (`IDITEM`);

--
-- Indices de la tabla `item_solicitud_de_cotizacion`
--
ALTER TABLE `item_solicitud_de_cotizacion`
 ADD PRIMARY KEY (`ITEMSOLICITUDCOTIZACION`), ADD KEY `FK_RELATIONSHIP_6` (`IDITEM`), ADD KEY `FK_RELATIONSHIP_7` (`IDSOLICITUDCOTIZACION`);

--
-- Indices de la tabla `proveedor_ingrediente`
--
ALTER TABLE `proveedor_ingrediente`
 ADD PRIMARY KEY (`IDPROVEEDORINGREDIENTE`);

--
-- Indices de la tabla `proveedor_utensilio`
--
ALTER TABLE `proveedor_utensilio`
 ADD PRIMARY KEY (`IDPROVEEDORUTENSILIO`);

--
-- Indices de la tabla `seguimiento`
--
ALTER TABLE `seguimiento`
 ADD PRIMARY KEY (`IDSEGUIMIENTO`), ADD KEY `FK_RELATIONSHIP_26` (`ID_COTIZACION`);

--
-- Indices de la tabla `solicitud_de_cotizacion`
--
ALTER TABLE `solicitud_de_cotizacion`
 ADD PRIMARY KEY (`IDSOLICITUDCOTIZACION`), ADD KEY `FK_RELATIONSHIP_8` (`MAIL_CLIENTE`), ADD KEY `FK_TIENE` (`IDTIPOEVENTO`);

--
-- Indices de la tabla `tipo_evento`
--
ALTER TABLE `tipo_evento`
 ADD PRIMARY KEY (`IDTIPOEVENTO`);

--
-- Indices de la tabla `tipo_item`
--
ALTER TABLE `tipo_item`
 ADD PRIMARY KEY (`IDTIPO`);

--
-- Indices de la tabla `tipo_menu`
--
ALTER TABLE `tipo_menu`
 ADD PRIMARY KEY (`IDTIPOMENU`), ADD KEY `FK_RELATIONSHIP_27` (`IDTIPOEVENTO`);

--
-- Indices de la tabla `tipo_utensilio`
--
ALTER TABLE `tipo_utensilio`
 ADD PRIMARY KEY (`IDTIPOUTENSILIO`);

--
-- Indices de la tabla `utensilio`
--
ALTER TABLE `utensilio`
 ADD PRIMARY KEY (`IDUTENSILIO`), ADD KEY `FK_SE_CLASIFICA_SEGUN` (`IDTIPOUTENSILIO`);

--
-- Indices de la tabla `utensilio_evento`
--
ALTER TABLE `utensilio_evento`
 ADD PRIMARY KEY (`IDUTENSILIOEVENTO`), ADD KEY `FK_RELATIONSHIP_13` (`IDUTENSILIO`), ADD KEY `FK_UTILIZA` (`IDAGENDAMIENTOEVENTO`);

--
-- Indices de la tabla `utensilio_item`
--
ALTER TABLE `utensilio_item`
 ADD PRIMARY KEY (`IDUTENSILIOITEM`), ADD KEY `FK_RELATIONSHIP_33` (`IDITEM`), ADD KEY `FK_RELATIONSHIP_40` (`IDUTENSILIO`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `agendamiento_evento`
--
ALTER TABLE `agendamiento_evento`
MODIFY `IDAGENDAMIENTOEVENTO` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `auditoria`
--
ALTER TABLE `auditoria`
MODIFY `ID_AUDITORIA` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `cantidad_historica`
--
ALTER TABLE `cantidad_historica`
MODIFY `IDHISTORICO` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `compra_ingrediente`
--
ALTER TABLE `compra_ingrediente`
MODIFY `IDCOMPRAINGREDIENTE` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `compra_ingrediente_ingrediente`
--
ALTER TABLE `compra_ingrediente_ingrediente`
MODIFY `IDCOMPRAINGREDIENTEINGREDIENTE` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `compra_utensilio`
--
ALTER TABLE `compra_utensilio`
MODIFY `IDCOMPRAUTENSILIO` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `compra_utensilio_utensilio`
--
ALTER TABLE `compra_utensilio_utensilio`
MODIFY `IDCOMPRAUTENSILIOUTENSILIO` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
MODIFY `ID_COTIZACION` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `garzon`
--
ALTER TABLE `garzon`
MODIFY `IDGARZON` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `garzon_evento`
--
ALTER TABLE `garzon_evento`
MODIFY `IDGARZONEVENTO` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ingrediente`
--
ALTER TABLE `ingrediente`
MODIFY `IDINGREDIENTE` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT de la tabla `ingrediente_item`
--
ALTER TABLE `ingrediente_item`
MODIFY `IDINGREDIENTEITEM` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `ingrediente_item_especial`
--
ALTER TABLE `ingrediente_item_especial`
MODIFY `IDINGREDIENTEITEMESPECIAL` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `item`
--
ALTER TABLE `item`
MODIFY `IDITEM` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT de la tabla `item_especial`
--
ALTER TABLE `item_especial`
MODIFY `ID_ITEM_ESPECIAL` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `item_menu`
--
ALTER TABLE `item_menu`
MODIFY `IDITEMMENU` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `item_solicitud_de_cotizacion`
--
ALTER TABLE `item_solicitud_de_cotizacion`
MODIFY `ITEMSOLICITUDCOTIZACION` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `proveedor_ingrediente`
--
ALTER TABLE `proveedor_ingrediente`
MODIFY `IDPROVEEDORINGREDIENTE` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `proveedor_utensilio`
--
ALTER TABLE `proveedor_utensilio`
MODIFY `IDPROVEEDORUTENSILIO` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `seguimiento`
--
ALTER TABLE `seguimiento`
MODIFY `IDSEGUIMIENTO` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `solicitud_de_cotizacion`
--
ALTER TABLE `solicitud_de_cotizacion`
MODIFY `IDSOLICITUDCOTIZACION` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `tipo_evento`
--
ALTER TABLE `tipo_evento`
MODIFY `IDTIPOEVENTO` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `tipo_item`
--
ALTER TABLE `tipo_item`
MODIFY `IDTIPO` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT de la tabla `tipo_menu`
--
ALTER TABLE `tipo_menu`
MODIFY `IDTIPOMENU` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT de la tabla `tipo_utensilio`
--
ALTER TABLE `tipo_utensilio`
MODIFY `IDTIPOUTENSILIO` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `utensilio`
--
ALTER TABLE `utensilio`
MODIFY `IDUTENSILIO` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `utensilio_evento`
--
ALTER TABLE `utensilio_evento`
MODIFY `IDUTENSILIOEVENTO` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `utensilio_item`
--
ALTER TABLE `utensilio_item`
MODIFY `IDUTENSILIOITEM` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `agendamiento_evento`
--
ALTER TABLE `agendamiento_evento`
ADD CONSTRAINT `FK_RELATIONSHIP_29` FOREIGN KEY (`ID_COTIZACION`) REFERENCES `cotizacion` (`ID_COTIZACION`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cantidad_historica`
--
ALTER TABLE `cantidad_historica`
ADD CONSTRAINT `FK_RELATIONSHIP_31` FOREIGN KEY (`IDTIPOEVENTO`) REFERENCES `tipo_evento` (`IDTIPOEVENTO`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `FK_RELATIONSHIP_32` FOREIGN KEY (`IDITEM`) REFERENCES `item` (`IDITEM`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `compra_ingrediente`
--
ALTER TABLE `compra_ingrediente`
ADD CONSTRAINT `FK_RELATIONSHIP_36` FOREIGN KEY (`IDPROVEEDORINGREDIENTE`) REFERENCES `proveedor_ingrediente` (`IDPROVEEDORINGREDIENTE`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `compra_ingrediente_ingrediente`
--
ALTER TABLE `compra_ingrediente_ingrediente`
ADD CONSTRAINT `FK_R20` FOREIGN KEY (`IDINGREDIENTE`) REFERENCES `ingrediente` (`IDINGREDIENTE`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `FK_RELATIONSHIP_37` FOREIGN KEY (`IDCOMPRAINGREDIENTE`) REFERENCES `compra_ingrediente` (`IDCOMPRAINGREDIENTE`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `compra_utensilio`
--
ALTER TABLE `compra_utensilio`
ADD CONSTRAINT `FK_RELATIONSHIP_38` FOREIGN KEY (`IDPROVEEDORUTENSILIO`) REFERENCES `proveedor_utensilio` (`IDPROVEEDORUTENSILIO`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `compra_utensilio_utensilio`
--
ALTER TABLE `compra_utensilio_utensilio`
ADD CONSTRAINT `FK_R22` FOREIGN KEY (`IDUTENSILIO`) REFERENCES `utensilio` (`IDUTENSILIO`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `FK_RELATIONSHIP_39` FOREIGN KEY (`IDCOMPRAUTENSILIO`) REFERENCES `compra_utensilio` (`IDCOMPRAUTENSILIO`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
ADD CONSTRAINT `FK_RELATIONSHIP_30` FOREIGN KEY (`IDSOLICITUDCOTIZACION`) REFERENCES `solicitud_de_cotizacion` (`IDSOLICITUDCOTIZACION`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `garzon_evento`
--
ALTER TABLE `garzon_evento`
ADD CONSTRAINT `FK_ACEPTA_O_RECHAZA` FOREIGN KEY (`IDGARZON`) REFERENCES `garzon` (`IDGARZON`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `FK_RELATIONSHIP_10` FOREIGN KEY (`IDAGENDAMIENTOEVENTO`) REFERENCES `agendamiento_evento` (`IDAGENDAMIENTOEVENTO`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ingrediente_item`
--
ALTER TABLE `ingrediente_item`
ADD CONSTRAINT `FK_RELATIONSHIP_4` FOREIGN KEY (`IDITEM`) REFERENCES `item` (`IDITEM`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `FK_RELATIONSHIP_5` FOREIGN KEY (`IDINGREDIENTE`) REFERENCES `ingrediente` (`IDINGREDIENTE`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ingrediente_item_especial`
--
ALTER TABLE `ingrediente_item_especial`
ADD CONSTRAINT `FK_RELATIONSHIP_34` FOREIGN KEY (`IDINGREDIENTE`) REFERENCES `ingrediente` (`IDINGREDIENTE`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `FK_RELATIONSHIP_35` FOREIGN KEY (`ID_ITEM_ESPECIAL`) REFERENCES `item_especial` (`ID_ITEM_ESPECIAL`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `item`
--
ALTER TABLE `item`
ADD CONSTRAINT `FK_RELATIONSHIP_3` FOREIGN KEY (`IDTIPO`) REFERENCES `tipo_item` (`IDTIPO`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `item_especial`
--
ALTER TABLE `item_especial`
ADD CONSTRAINT `FK_RELATIONSHIP_28` FOREIGN KEY (`ID_COTIZACION`) REFERENCES `cotizacion` (`ID_COTIZACION`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `item_menu`
--
ALTER TABLE `item_menu`
ADD CONSTRAINT `FK_RELATIONSHIP_41` FOREIGN KEY (`IDTIPOMENU`) REFERENCES `tipo_menu` (`IDTIPOMENU`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `FK_RELATIONSHIP_42` FOREIGN KEY (`IDITEM`) REFERENCES `item` (`IDITEM`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `item_solicitud_de_cotizacion`
--
ALTER TABLE `item_solicitud_de_cotizacion`
ADD CONSTRAINT `FK_RELATIONSHIP_6` FOREIGN KEY (`IDITEM`) REFERENCES `item` (`IDITEM`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `FK_RELATIONSHIP_7` FOREIGN KEY (`IDSOLICITUDCOTIZACION`) REFERENCES `solicitud_de_cotizacion` (`IDSOLICITUDCOTIZACION`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `seguimiento`
--
ALTER TABLE `seguimiento`
ADD CONSTRAINT `FK_RELATIONSHIP_26` FOREIGN KEY (`ID_COTIZACION`) REFERENCES `cotizacion` (`ID_COTIZACION`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `solicitud_de_cotizacion`
--
ALTER TABLE `solicitud_de_cotizacion`
ADD CONSTRAINT `FK_RELATIONSHIP_8` FOREIGN KEY (`MAIL_CLIENTE`) REFERENCES `cliente` (`MAIL_CLIENTE`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `FK_TIENE` FOREIGN KEY (`IDTIPOEVENTO`) REFERENCES `tipo_evento` (`IDTIPOEVENTO`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `tipo_menu`
--
ALTER TABLE `tipo_menu`
ADD CONSTRAINT `FK_RELATIONSHIP_27` FOREIGN KEY (`IDTIPOEVENTO`) REFERENCES `tipo_evento` (`IDTIPOEVENTO`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `utensilio`
--
ALTER TABLE `utensilio`
ADD CONSTRAINT `FK_SE_CLASIFICA_SEGUN` FOREIGN KEY (`IDTIPOUTENSILIO`) REFERENCES `tipo_utensilio` (`IDTIPOUTENSILIO`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `utensilio_evento`
--
ALTER TABLE `utensilio_evento`
ADD CONSTRAINT `FK_RELATIONSHIP_13` FOREIGN KEY (`IDUTENSILIO`) REFERENCES `utensilio` (`IDUTENSILIO`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `FK_UTILIZA` FOREIGN KEY (`IDAGENDAMIENTOEVENTO`) REFERENCES `agendamiento_evento` (`IDAGENDAMIENTOEVENTO`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `utensilio_item`
--
ALTER TABLE `utensilio_item`
ADD CONSTRAINT `FK_RELATIONSHIP_33` FOREIGN KEY (`IDITEM`) REFERENCES `item` (`IDITEM`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `FK_RELATIONSHIP_40` FOREIGN KEY (`IDUTENSILIO`) REFERENCES `utensilio` (`IDUTENSILIO`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
