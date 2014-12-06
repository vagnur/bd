-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-12-2014 a las 01:12:50
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

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `adminAdd`(IN `correo` VARCHAR(45), IN `pass` VARCHAR(45), IN `nombre` VARCHAR(25), IN `apellido` VARCHAR(25), IN `rol` VARCHAR(10))
    NO SQL
IF correo LIKE '%@%.%' AND nombre REGEXP '[a-zA-Z]+' AND apellido REGEXP '[a-zA-Z]+' THEN
INSERT INTO administrador(CORREO_ADMIN,CLAVE_ADMIN,NOMBRE_ADMIN,APELLIDO,ROL)
  VALUES(correo,pass,nombre,apellido,rol);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `adminDel`(IN `correoInput` VARCHAR(45))
    NO SQL
DELETE FROM administrador WHERE correo_admin=correoInput$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `adminGet`()
    NO SQL
SELECT * FROM administrador$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `adminUpdt`(IN `correo` VARCHAR(45), IN `correoNuevo` VARCHAR(45), IN `clave` VARCHAR(45), IN `nombre` VARCHAR(45), IN `apellidoIn` VARCHAR(25), IN `rolIn` VARCHAR(10))
    NO SQL
IF correoNuevo LIKE '%@%.%' AND nombre REGEXP '[a-zA-Z]+' AND apellidoIn REGEXP '[a-zA-Z]+' THEN
UPDATE administrador SET correo_admin=correoNuevo, clave_admin=clave, nombre_admin=nombre, apellido=apellidoIn, rol=rolIn WHERE correo_admin=correo;
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `clienteAdd`(IN `mail` VARCHAR(45), IN `telefono` INT, IN `nombre` VARCHAR(25), IN `apellido` VARCHAR(25))
    NO SQL
IF mail LIKE '%@%.%' AND telefono>0 AND nombre REGEXP '[a-zA-Z]+' AND apellido REGEXP '[a-zA-Z]+' THEN
INSERT INTO cliente(MAIL_CLIENTE, TELEFONO_CLIENTE, NOMBRE_CLIENTE, APELLIDO_CLIENTE) VALUES (mail,telefono,nombre,apellido);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `clienteDel`(IN `correo` VARCHAR(45))
    NO SQL
DELETE FROM cliente WHERE MAIL_CLIENTE=correo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `clienteGet`()
    NO SQL
SELECT * FROM cliente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `clienteUpdt`(IN `correo` VARCHAR(45), IN `mail` VARCHAR(45), IN `fono` INT, IN `nombre` VARCHAR(25), IN `apellido` VARCHAR(25))
    NO SQL
IF mail LIKE '%@%.%' AND fono>0 AND nombre REGEXP '[a-zA-Z]+' AND apellido REGEXP '[a-zA-Z]+' THEN
UPDATE cliente SET mail_cliente=mail, telefono_cliente=fono, nombre_cliente=nombre, apellido_cliente=apellido WHERE mail_cliente=correo;
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `compraIngredienteAdd`(IN `proveedor` INT, IN `total` INT, IN `fecha` DATETIME)
    NO SQL
IF proveedor IN (SELECT IDCOMPRAUTENSILIO FROM compra_utensilio) AND total>0 THEN
INSERT INTO compra_utensilio(IDPROVEEDORUTENSILIO,TOTAL,FECHA) VALUES(proveedor,total,fecha);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `compraIngredienteDel`(IN `id` INT)
    NO SQL
DELETE FROM compra_ingrediente WHERE idcompraingrediente=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `compraIngredienteGet`()
    NO SQL
SELECT * FROM compra_ingrediente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `compraIngrediente_ingredienteAdd`(IN `ingrediente` INT, IN `compra` INT, IN `cantidad` INT, IN `precio` INT)
    NO SQL
IF ingrediente IN (SELECT idingrediente FROM ingrediente) AND compra IN (SELECT icompraingrediente FROM compra_ingrediente) AND cantidad>0 AND precio>0 THEN
INSERT INTO ingrediente(idingrediente,idcompraingrediente,cantidad_compra_ingrediente,precio_compra_ingrediente) VALUES(ingrediente,compra,cantidad,precio);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `compraIngrediente_ingredienteGet`()
    NO SQL
SELECT * FROM compra_ingrediente_ingrediente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `compraUtensilioAdd`(IN `proveedor` INT, IN `total` INT, IN `fecha` DATETIME)
    NO SQL
IF proveedor IN (SELECT IDPROVEEDORUTENSILIO FROM proveedor_utensilio) AND total>0 THEN
INSERT INTO compra_utensilio(IDPROVEEDORUTENSILIO, TOTAL_COMPRA_UTENSILIO,FECHA_COMPRA_UTENSILIO) VALUES(proveedor,total,fecha);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `compraUtensilioDel`(IN `id` INT)
    NO SQL
DELETE FROM compra_utensilio WHERE IDCOMPRAUTENSILIO=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `compraUtensilioGet`()
    NO SQL
SELECT * FROM compra_utensilio$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `compraUtensilio_utensilioAdd`(IN `utensilio` INT, IN `compra` INT, IN `cantidad` INT, IN `precio` INT)
    NO SQL
IF utensilio IN (SELECT idutensilio FROM utensilio) AND compra IN (SELECT idcomprautensilio FROM compra_utensilio) AND cantidad>0 AND precio>0 THEN
INSERT INTO compra_utensilio_utensilio(idutensilio,idcomprautensilio,cantidad_compra_utensilio,precio_compra_utensilio) VALUES(utensilio,compra,cantidad,precio);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `compraUtensilio_utensilioGet`()
    NO SQL
SELECT * FROM compra_utensilio_utensilio$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `compra_ingredienteAdd`(IN `ingrediente` INT, IN `compra` INT, IN `cantidad` INT, IN `precio` INT)
    NO SQL
IF ingrediente IN (SELECT idingrediente FROM ingrediente) AND compra IN (SELECT idcompraingrediente FROM compra_ingrediente) AND cantidad>0 and precio>0 THEN
INSERT INTO compra_ingrediente_ingrediente(idingrediente,idcompraingrediente,cantidad_compra_ingrediente,precio_compra_ingrediente) VALUES(ingrediente,compra,cantidad,precio);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `compra_utensilioGet`()
    NO SQL
SELECT * FROM compra_utensilio_utensilio$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cotizacionAdd`(IN `solicitud` INT, IN `valor` INT)
    NO SQL
IF solicitud IN (SELECT idsolicitudcotizacion FROM solicitud_de_cotizacion) AND valor>0 THEN
INSERT INTO cotizacion(IDSOLICITUDCOTIZACION,ESTADO_ACEPTACION,VALOR_COTIZACION) VALUES(solicitud,'ingresada',valor);
INSERT INTO seguimiento(id_cotizacion,fecha_acuerdo,fecha_vencimiento) VALUES(LAST_INSERT_ID(),CURDATE(),CURDATE()+INTERVAL 3 DAY);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cotizacionDel`(IN `id` INT)
    NO SQL
DELETE FROM cotizacion WHERE id_cotizacion=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cotizacionGet`()
    NO SQL
SELECT * FROM cotizacion$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `garzonAdd`(IN `mail` VARCHAR(45), IN `telefono` INT, IN `nombre` VARCHAR(25), IN `apellido` VARCHAR(25))
    NO SQL
IF mail LIKE '%@%.%' AND telefono>0 AND nombre REGEXP '[a-zA-Z]+' AND apellido REGEXP '[a-zA-Z]+' THEN
INSERT INTO garzon(MAIL_GARZON,TELEFONO_GARZON,NOMBRE_GARZON,APELLIDO_GARZON) VALUES(mail,telefono,nombre,apellido);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `garzonDel`(IN `mail` VARCHAR(45))
    NO SQL
DELETE FROM garzon WHERE mail_garzon=mail$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `garzonGet`()
    NO SQL
sELECT * FROM garzon$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `garzonUpd`(IN `mail` VARCHAR(45), IN `mailNuevo` VARCHAR(45), IN `telefono` INT, IN `nombre` VARCHAR(25), IN `apellido` VARCHAR(25))
    NO SQL
IF mailNuevo LIKE '%@%.%' AND telefono>0 AND nombre REGEXP '[a-zA-Z]+' AND apellido REGEXP '[a-zA-Z]+' THEN
UPDATE garzon SET mail_garzon=mailNuevo, telefono_garzon=telefono, nombre_garzon=nombre, apellido_garzon=apellido WHERE mail_garzon=mail;
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ingredienteAdd`(IN `nombre` VARCHAR(45), IN `stock` INT, IN `stockMin` INT)
    NO SQL
IF nombre REGEXP '[a-zA-Z]+' AND stock>0 AND stockMin>=0 THEN
INSERT INTO ingrediente(NOMBRE_INGREDIENTE,STOCK_INGREDIENTE,STOCK_MINIMO_INGREDIENTE) VALUES(nombre,stock,stockMin);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ingredienteDel`(IN `id` INT)
    NO SQL
DELETE FROM ingrediente WHERE IDINGREDIENTE=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ingredienteGet`()
    NO SQL
SELECT * FROM ingrediente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ingrediente_itemAdd`(IN `item` INT, IN `ingrediente` INT, IN `cantidad` INT, IN `unidad` INT)
    NO SQL
IF item IN (SELECT iditem FROM item) AND ingrediente IN (SELECT idingrediente FROM ingrediente) AND cantidad>0 THEN
INSERT INTO ingrediente_item(idingrediente,id_item_especial,cantidad_ingrediente_especial,unidad_ingrediente_especial) VALUES(item,ingrediente,cantidad,unidad);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ingrediente_itemEspecialAdd`(IN `item` INT, IN `ingrediente` INT, IN `cantidad` INT, IN `unidad` VARCHAR(10))
    NO SQL
IF item IN (SELECT id_item_especial FROM item_especial) AND ingrediente IN (SELECT idingrediente FROM ingrediente) AND cantidad>0 THEN
INSERT INTO ingrediente_item_especial(idingrediente,id_item_especial,cantidad_ingrediente_especial,unidad_ingrediente_especial) VALUES(item,ingrediente,cantidad,unidad);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ingrediente_itemEspecialGet`()
    NO SQL
SELECT * FROM ingrediente_item_especial$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ingrediente_itemGet`()
    NO SQL
sELECT * FROM ingrediente_item$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `itemAdd`(IN `tipomenu` INT, IN `tipo` INT, IN `nombre` VARCHAR(25))
    NO SQL
IF tipomenu IN (SELECT idtipomenu FROM tipo_menu) AND tipo IN (SELECT idtipo FROM tipo_item) AND nombre REGEXP '[a-zA-Z]+' THEN
INSERT INTO item(IDTIPOMENU,IDTIPO,NOMBRE_ITEM) VALUES(tipomenu,tipo,nombre);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `itemDel`(IN `id` INT)
    NO SQL
DELETE FROM item WHERE iditem=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `itemGet`()
    NO SQL
SELECT * FROM item$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `item_EspecialAdd`(IN `cotizacion` INT, IN `nombre` VARCHAR(25), IN `cantidad` INT, IN `precio` INT)
    NO SQL
IF cotizacion IN (SELECT id_cotizacion FROM cotizacion) AND nombre REGEXP '[a-zA-Z]+' AND cantidad>0 AND precio>0 THEN
INSERT INTO item_especial(id_cotizacion,nombre_item,cantidad,precio) VALUES(cotizacion,nombre,cantidad,precio);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `item_EspecialDel`(IN `id` INT)
    NO SQL
DELETE FROM item_especial WHERE id_item_especial=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `item_EspecialGet`()
    NO SQL
SELECT * FROM item_especial$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `item_utensilioAdd`(IN `item` INT, IN `utensilio` INT, IN `cantidadItem` INT, IN `cantidadUtensilio` INT)
    NO SQL
IF item IN (SELECT iditem FROM item) AND utensilio IN (SELECT idutensilio FROM utensilio) AND cantidadItem>0 AND cantidadUtensilio>0 THEN
INSERT INTO utensilo_item(iditem,idutensilio,cantidaditem,cantidadutensilio) VALUES (item,utensilio,cantidadItem,cantidadUtensilio);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `item_utensilioGet`()
    NO SQL
SELECT * FROM utensilio_item$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proveedorIngAdd`(IN `nombre` VARCHAR(45), IN `telefono` INT, IN `direccion` INT(45))
    NO SQL
IF nombre REGEXP '[a-zA-Z]+' AND telefono>0 AND direccion REGEXP '[a-zA-Z]+#[0-9]+' THEN
INSERT INTo proveedor_ingrediente(NOMBRE_PROVEEDOR_INGREDIENTE,TELEFONO_PROVEEDOR_INGREDIENTE,DIRECCION_PROVEEDOR_INGREDIENTE) VALUES (nombre,telefono,direccion);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proveedorIngDel`(IN `direccion` VARCHAR(45))
    NO SQL
DELETE FROM proveedor_ingrediente WHERE direccion_proveedor_ingrediente=direccion$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proveedorIngGet`()
    NO SQL
SELECT * FROM proveedor_ingrediente$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proveedorIngUpd`(IN `nombre` VARCHAR(45), IN `telefono` INT, IN `direccion` VARCHAR(45), IN `direccionNueva` VARCHAR(45))
    NO SQL
IF nombre REGEXP '[a-zA-Z]+' AND telefono>0 AND direccionNueva REGEXP '[a-zA-Z]+#[0-9]+' THEN
UPDATE proveedor_ingrediente SET nombre_proveedor_ingrediente=nombre, telefono_proveedor_ingrediente=telefono, direccion_proveedor_ingrediente=direccionNueva WHERE direccion_proveedor_ingrediente=direccion;
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proveedorUtenAdd`(IN `nombre` VARCHAR(45), IN `telefono` INT, IN `direccion` VARCHAR(45))
    NO SQL
IF nombre REGEXP '[a-zA-Z]+' AND telefono>0 AND direccion REGEXP '[a-zA-Z]+#[0-9]+' THEN
INSERT INTo proveedor_utensilio(NOMBRE_PROVEEDOR_UTENSILIO,TELEFONO_PROVEEDOR_UTENSILIO,DIRECCION_PROVEEDOR_UTENSILIO) VALUES (nombre,telefono,direccion);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proveedorUtenDel`(IN `direccion` VARCHAR(45))
    NO SQL
DELETE FROM proveedor_utensilio WHERE direccion_proveedor_utensilio=direccion$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proveedorUtenGet`()
    NO SQL
SELECT * FROM proveedor_utensilio$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `proveedorUtenUpd`(IN `nombre` VARCHAR(45), IN `telefono` INT, IN `direccion` VARCHAR(45), IN `direccionNueva` VARCHAR(45))
    NO SQL
IF nombre REGEXP '[a-zA-Z]+' AND telefono>0 AND direccionNueva REGEXP '[a-zA-Z]+#[0-9]+' THEN
UPDATE proveedor_utensilio SET nombre_proveedor_utensilio=nombre, telefono_proveedor_utensilio=telefono, direccion_proveedor_utensilio=direccionNueva WHERE direccion_proveedor_utensilio=direccion;
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `seguimientoGet`()
    NO SQL
sELECT * FROM seguimiento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `solicitudAdd`(IN `mail` VARCHAR(45), IN `tipoEvento` INT, IN `asistentes` INT, IN `duracion` INT, IN `comentarios` VARCHAR(250), IN `nombre` VARCHAR(25), IN `direccion` VARCHAR(45), IN `fecha` DATETIME)
    NO SQL
IF mail IN (SELECT mail_cliente FROM cliente) AND asistentes>0 AND duracion>0 THEN
INSERT INTO `solicitud_de_cotizacion`(`MAIL_CLIENTE`, `IDTIPOEVENTO`, `CANTIDAD_ASISTENTES`,`FECHA_TENTATIVA`, `DURACION_TENTATIVA`, `COMENTARIOS_`, `NOMBRE_EVENTO`, `DIRECCION_EVENTO`, `ESTADO_SOLICITUD`) VALUES(mail,tipoEvento,asistentes,fecha,duracion,comentarios,nombre,direccion,'ingresada');
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `solicitudDel`(IN `id` INT)
    NO SQL
DELETE FROM solicitud_de_cotizacion WHERE idsolicitudcotizacion=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `solicitudGet`()
    NO SQL
SELECT * FROM solicitud_de_cotizacion$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tipoEventoAdd`(IN `nombre` VARCHAR(25))
    NO SQL
IF nombre REGEXP '[a-zA-Z]+' THEN
INSERT INTO tipo_evento(NOMBRE_TIPO_EVENTO) VALUES(nombre);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tipoEventoDel`(IN `id` INT)
    NO SQL
delete from tipo_evento where idtipoevento=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tipoEventoGet`()
    NO SQL
SELECT * FROM tipo_evento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tipoEventoUpd`(IN `id` INT, IN `nombreNuevo` VARCHAR(25))
    NO SQL
if nombreNuevo regexp '[a-zA-Z]+' THEN
UPDATE tipo_evento set nombre_tipo_evento=nombreNuevo;
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tipoItemAdd`(IN `nombre` VARCHAR(25))
    NO SQL
IF nombre REGEXP '[a-zA-Z]+' THEN
INSERT INTO tipo_item(nombre_tipo) VALUES(nombre);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tipoItemDel`(IN `nombre` VARCHAR(25))
    NO SQL
DELETE FROM tipo_item WHERE nombre_tipo=nombre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tipoItemGet`()
    NO SQL
SELECT * FROM tipo_item$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tipoItemUpd`(IN `nombre` VARCHAR(45), IN `nombreNuevo` VARCHAR(45))
    NO SQL
IF nombreNuevo REGEXP '[a-zA-Z]+' THEN
UPDATE tipo_item SET nombre_tipo=nombreNuevo WHERE nombre_tipo=nombre;
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tipoMenuAdd`(IN `evento` INT, IN `nombre` VARCHAR(25))
    NO SQL
IF evento IN (SELECT idtipoevento FROM tipo_evento) AND nombre REGEXP '[a-zA-Z]+' THEN
INSERT INTO tipo_menu(IDTIPOEVENTO,NOMBRE_TIPO_MENU) VALUES(evento,nombre);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tipoMenuDel`(IN `id` INT)
    NO SQL
DELETE FROM tipo_menu WHERE idtipomenu=id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tipoMenuGet`()
    NO SQL
sELECT * FROM tipo_menu$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tipoUtensilioAdd`(IN `nombre` VARCHAR(25))
    NO SQL
IF nombre REGEXP '[a-zA-Z]+' THEN
INSERT INTO TIPO_UTENSILIO(NOMBRE_TIPO_UTENSILIO) VALUES(nombre);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tipoUtensilioDel`(IN `nombre` VARCHAR(25))
    NO SQL
DELETE FROM tipo_utensilio WHERE nombre_tipo_utensilio=nombre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tipoUtensilioGet`()
    NO SQL
SELECT * FROM tipo_utensilio$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tipoUtensilioUpd`(IN `nombre` VARCHAR(25), IN `nombreNuevo` VARCHAR(25))
    NO SQL
IF nombre REGEXP '[a-zA-Z]+' THEN
UPDATE tipo_utensilio SET nombre_tipo_utensilio=nombreNuevo WHERE nombre_tipo_utensilio=nombre;
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `utensilioAdd`(IN `nombre` VARCHAR(25), IN `tipo` INT, IN `stock` INT, IN `stockMin` INT)
    NO SQL
IF nombre REGEXP '[a-zA-Z]+' AND stock>=0 AND stockMin>=0 AND tipo IN (SELECT IDTIPOUTENSILIO FROM tipo_utensilio) THEN
INSERT INTO UTENSILIO(IDTIPOUTENSILIO,NOMBRE_UTENSILIO,STOCK_UTENSILIO,STOCK_MINIMO_UTENSILIO) VALUES (tipo,nombre,stock,stockMin);
END IF$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `utensilioDel`(IN `nombre` VARCHAR(25))
    NO SQL
DELETE FROM utensilio WHERE nombre_utensilio=nombre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `utensilioGet`()
    NO SQL
SELECT * FROM utensilio$$

DELIMITER ;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `agendamiento_evento`
--

CREATE TABLE IF NOT EXISTS `agendamiento_evento` (
`IDAGENDAMIENTOEVENTO` int(11) NOT NULL,
  `ID_COTIZACION` int(11) NOT NULL,
  `FECHA_AGENDAMIENTO_EVENTO` date DEFAULT NULL,
  `HORA_AGENDAMIENTO_EVENTO` time DEFAULT NULL,
  `DURACION_AGENDAMIENTO_EVENTO` int(11) DEFAULT NULL,
  `ESTADO` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla que almacena los datos relacionados al agendamiento de' AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra_ingrediente`
--

CREATE TABLE IF NOT EXISTS `compra_ingrediente` (
`IDCOMPRAINGREDIENTE` int(11) NOT NULL,
  `IDPROVEEDORINGREDIENTE` int(11) DEFAULT NULL,
  `TOTAL_COMPRA_INGREDIENTE` int(11) DEFAULT NULL,
  `FECHA_COMPRA_INGREDIENTE` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Registro de las compras realizadas a cada proveedor.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra_ingrediente_ingrediente`
--

CREATE TABLE IF NOT EXISTS `compra_ingrediente_ingrediente` (
  `IDINGREDIENTE` int(11) NOT NULL,
  `IDCOMPRAINGREDIENTE` int(11) NOT NULL,
  `CANTIDAD_COMPRA_INGREDIENTE` int(11) DEFAULT NULL,
  `PRECIO_COMPRA_INGREDIENTE` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Detalle de los ingredientes de una compra espec?fica.';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra_utensilio`
--

CREATE TABLE IF NOT EXISTS `compra_utensilio` (
`IDCOMPRAUTENSILIO` int(11) NOT NULL,
  `IDPROVEEDORUTENSILIO` int(11) DEFAULT NULL,
  `TOTAL_COMPRA_UTENSILIO` int(11) DEFAULT NULL,
  `FECHA_COMPRA_UTENSILIO` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compra_utensilio_utensilio`
--

CREATE TABLE IF NOT EXISTS `compra_utensilio_utensilio` (
  `IDUTENSILIO` int(11) NOT NULL,
  `IDCOMPRAUTENSILIO` int(11) NOT NULL,
  `CANTIDAD_COMPRA_UTENSILIO` int(11) DEFAULT NULL,
  `PRECIO_COMPRA_UTENSILIO` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Detalle de los utensilios comprados en una "compra" espec?fi';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizacion`
--

CREATE TABLE IF NOT EXISTS `cotizacion` (
`ID_COTIZACION` int(11) NOT NULL,
  `IDSOLICITUDCOTIZACION` int(11) NOT NULL,
  `ESTADO_ACEPTACION` varchar(10) DEFAULT NULL,
  `VALOR_COTIZACION` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla que contiene las cotizaciones creadas como respuestas ' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `garzon`
--

CREATE TABLE IF NOT EXISTS `garzon` (
  `MAIL_GARZON` varchar(45) NOT NULL,
  `TELEFONO_GARZON` int(11) DEFAULT NULL,
  `NOMBRE_GARZON` varchar(25) DEFAULT NULL,
  `APELLIDO_GARZON` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Datos necesarios para pedir disponibilidad de los garzones a';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `garzon_evento`
--

CREATE TABLE IF NOT EXISTS `garzon_evento` (
  `IDAGENDAMIENTOEVENTO` int(11) NOT NULL,
  `MAIL_GARZON` varchar(45) NOT NULL,
  `RESPUESTA` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Detalle de los garzones asignados para un evento.';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingrediente`
--

CREATE TABLE IF NOT EXISTS `ingrediente` (
`IDINGREDIENTE` int(11) NOT NULL,
  `NOMBRE_INGREDIENTE` varchar(45) DEFAULT NULL,
  `STOCK_INGREDIENTE` int(11) DEFAULT NULL,
  `STOCK_MINIMO_INGREDIENTE` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Representa el stock del ingrediente que hay hasta el momento' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingrediente_item`
--

CREATE TABLE IF NOT EXISTS `ingrediente_item` (
  `IDITEM` int(11) NOT NULL,
  `IDINGREDIENTE` int(11) NOT NULL,
  `CANTIDAD_INGREDIENTE_ESPECIAL` int(11) DEFAULT NULL,
  `UNIDAD_INGREDIENTE_ESPECIAL` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='La cantidad de un ingrediente con que se prepara un plato o ';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingrediente_item_especial`
--

CREATE TABLE IF NOT EXISTS `ingrediente_item_especial` (
  `IDINGREDIENTE` int(11) NOT NULL,
  `ID_ITEM_ESPECIAL` int(11) NOT NULL,
  `CANTIDAD_INGREDIENTE_ESPECIAL` int(11) DEFAULT NULL,
  `UNIDAD_INGREDIENTE_ESPECIAL` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla que almacena el detalle de la cantidad de todos los in';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `item`
--

CREATE TABLE IF NOT EXISTS `item` (
`IDITEM` int(11) NOT NULL,
  `IDTIPOEVENTO` int(11) NOT NULL,
  `IDTIPOMENU` int(11) DEFAULT NULL,
  `IDTIPO` int(11) DEFAULT NULL,
  `NOMBRE_ITEM` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Un plato o bebida dentro de un men?.\r\n' AUTO_INCREMENT=1 ;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `item_solicitud_de_cotizacion`
--

CREATE TABLE IF NOT EXISTS `item_solicitud_de_cotizacion` (
  `IDITEM` int(11) NOT NULL,
  `IDSOLICITUDCOTIZACION` int(11) NOT NULL,
  `CANTIDAD_ITEM` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='El detalle de la cantidad de ?tems pedidos en una cotizaci';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor_ingrediente`
--

CREATE TABLE IF NOT EXISTS `proveedor_ingrediente` (
`IDPROVEEDORINGREDIENTE` int(11) NOT NULL,
  `NOMBRE_PROVEEDOR_INGREDIENTE` varchar(45) DEFAULT NULL,
  `TELEFONO_PROVEEDOR_INGREDIENTE` int(11) DEFAULT NULL,
  `DIRECCION_PROVEEDOR_INGREDIENTE` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Registro de los proveedores asociados a la banqueter?a.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor_utensilio`
--

CREATE TABLE IF NOT EXISTS `proveedor_utensilio` (
`IDPROVEEDORUTENSILIO` int(11) NOT NULL,
  `NOMBRE_PROVEEDOR_UTENSILIO` varchar(45) DEFAULT NULL,
  `TELEFONO_PROVEEDOR_UTENSILIO` int(11) DEFAULT NULL,
  `DIRECCION_PROVEEDOR_UTENSILIO` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguimiento`
--

CREATE TABLE IF NOT EXISTS `seguimiento` (
`IDSEGUIMIENTO` int(11) NOT NULL,
  `ID_COTIZACION` int(11) NOT NULL,
  `FECHA_ACUERDO` date DEFAULT NULL,
  `FECHA_VENCIMIENTO` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='El seguimiento permite ver si el cliente ha respondido o no ' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitud_de_cotizacion`
--

CREATE TABLE IF NOT EXISTS `solicitud_de_cotizacion` (
`IDSOLICITUDCOTIZACION` int(11) NOT NULL,
  `MAIL_CLIENTE` varchar(45) NOT NULL,
  `IDTIPOEVENTO` int(11) DEFAULT NULL,
  `CANTIDAD_ASISTENTES` int(11) DEFAULT NULL,
  `FECHA_TENTATIVA` datetime DEFAULT NULL,
  `DURACION_TENTATIVA` int(11) DEFAULT NULL,
  `COMENTARIOS_` varchar(250) DEFAULT NULL,
  `NOMBRE_EVENTO` varchar(25) DEFAULT NULL,
  `DIRECCION_EVENTO` varchar(45) DEFAULT NULL,
  `ESTADO_SOLICITUD` varchar(20) DEFAULT 'generada'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla que contiene las solicitudes de cotizaci?n creadas por' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_evento`
--

CREATE TABLE IF NOT EXISTS `tipo_evento` (
`IDTIPOEVENTO` int(11) NOT NULL,
  `NOMBRE_TIPO_EVENTO` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='El tipo de evento al que corresponde el men?.\r\nEjemplo:' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_item`
--

CREATE TABLE IF NOT EXISTS `tipo_item` (
`IDTIPO` int(11) NOT NULL,
  `NOMBRE_TIPO` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Representa a la categor?a de un plato, ejemplo: fondo, entra' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_menu`
--

CREATE TABLE IF NOT EXISTS `tipo_menu` (
`IDTIPOMENU` int(11) NOT NULL,
  `IDTIPOEVENTO` int(11) DEFAULT NULL,
  `NOMBRE_TIPO_MENU` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='La categor?a de los platos que habr? en el men?.\r\nEjemp' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_utensilio`
--

CREATE TABLE IF NOT EXISTS `tipo_utensilio` (
`IDTIPOUTENSILIO` int(11) NOT NULL,
  `NOMBRE_TIPO_UTENSILIO` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Generalizaci?n de un utencilio, ejemplo : bandeja, taza, etc' AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Corresponde a un objeto espec?fico, que ser? llevado a un ev' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `utensilio_evento`
--

CREATE TABLE IF NOT EXISTS `utensilio_evento` (
  `IDAGENDAMIENTOEVENTO` int(11) NOT NULL,
  `IDUTENSILIO` int(11) NOT NULL,
  `UTENSILIOS_UTILIZADOS` int(11) DEFAULT NULL,
  `UTENSILIOS_ROTOS` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Permite mantener el registro de la cantidad de elementos que';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `utensilio_item`
--

CREATE TABLE IF NOT EXISTS `utensilio_item` (
  `IDITEM` int(11) NOT NULL,
  `IDUTENSILIO` int(11) NOT NULL,
  `CANTIDADITEM` int(11) DEFAULT NULL,
  `CANTIDADUTENSILIO` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
 ADD PRIMARY KEY (`IDINGREDIENTE`,`IDCOMPRAINGREDIENTE`), ADD KEY `FK_RELATIONSHIP_37` (`IDCOMPRAINGREDIENTE`);

--
-- Indices de la tabla `compra_utensilio`
--
ALTER TABLE `compra_utensilio`
 ADD PRIMARY KEY (`IDCOMPRAUTENSILIO`), ADD KEY `FK_RELATIONSHIP_38` (`IDPROVEEDORUTENSILIO`);

--
-- Indices de la tabla `compra_utensilio_utensilio`
--
ALTER TABLE `compra_utensilio_utensilio`
 ADD PRIMARY KEY (`IDUTENSILIO`,`IDCOMPRAUTENSILIO`), ADD KEY `FK_RELATIONSHIP_39` (`IDCOMPRAUTENSILIO`);

--
-- Indices de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
 ADD PRIMARY KEY (`ID_COTIZACION`), ADD KEY `FK_RELATIONSHIP_30` (`IDSOLICITUDCOTIZACION`);

--
-- Indices de la tabla `garzon`
--
ALTER TABLE `garzon`
 ADD PRIMARY KEY (`MAIL_GARZON`);

--
-- Indices de la tabla `garzon_evento`
--
ALTER TABLE `garzon_evento`
 ADD PRIMARY KEY (`IDAGENDAMIENTOEVENTO`,`MAIL_GARZON`), ADD KEY `FK_ACEPTA_O_RECHAZA` (`MAIL_GARZON`);

--
-- Indices de la tabla `ingrediente`
--
ALTER TABLE `ingrediente`
 ADD PRIMARY KEY (`IDINGREDIENTE`);

--
-- Indices de la tabla `ingrediente_item`
--
ALTER TABLE `ingrediente_item`
 ADD PRIMARY KEY (`IDITEM`,`IDINGREDIENTE`), ADD KEY `FK_RELATIONSHIP_5` (`IDINGREDIENTE`);

--
-- Indices de la tabla `ingrediente_item_especial`
--
ALTER TABLE `ingrediente_item_especial`
 ADD PRIMARY KEY (`IDINGREDIENTE`,`ID_ITEM_ESPECIAL`), ADD KEY `FK_RELATIONSHIP_35` (`ID_ITEM_ESPECIAL`);

--
-- Indices de la tabla `item`
--
ALTER TABLE `item`
 ADD PRIMARY KEY (`IDITEM`), ADD KEY `FK_RELATIONSHIP_2` (`IDTIPOMENU`), ADD KEY `FK_RELATIONSHIP_3` (`IDTIPO`);

--
-- Indices de la tabla `item_especial`
--
ALTER TABLE `item_especial`
 ADD PRIMARY KEY (`ID_ITEM_ESPECIAL`), ADD KEY `FK_RELATIONSHIP_28` (`ID_COTIZACION`);

--
-- Indices de la tabla `item_solicitud_de_cotizacion`
--
ALTER TABLE `item_solicitud_de_cotizacion`
 ADD PRIMARY KEY (`IDITEM`,`IDSOLICITUDCOTIZACION`), ADD KEY `FK_RELATIONSHIP_7` (`IDSOLICITUDCOTIZACION`);

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
 ADD PRIMARY KEY (`IDAGENDAMIENTOEVENTO`,`IDUTENSILIO`), ADD KEY `FK_RELATIONSHIP_13` (`IDUTENSILIO`);

--
-- Indices de la tabla `utensilio_item`
--
ALTER TABLE `utensilio_item`
 ADD PRIMARY KEY (`IDITEM`,`IDUTENSILIO`), ADD KEY `FK_RELATIONSHIP_40` (`IDUTENSILIO`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `agendamiento_evento`
--
ALTER TABLE `agendamiento_evento`
MODIFY `IDAGENDAMIENTOEVENTO` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `auditoria`
--
ALTER TABLE `auditoria`
MODIFY `ID_AUDITORIA` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `compra_ingrediente`
--
ALTER TABLE `compra_ingrediente`
MODIFY `IDCOMPRAINGREDIENTE` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `compra_utensilio`
--
ALTER TABLE `compra_utensilio`
MODIFY `IDCOMPRAUTENSILIO` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `cotizacion`
--
ALTER TABLE `cotizacion`
MODIFY `ID_COTIZACION` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `ingrediente`
--
ALTER TABLE `ingrediente`
MODIFY `IDINGREDIENTE` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `item`
--
ALTER TABLE `item`
MODIFY `IDITEM` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `item_especial`
--
ALTER TABLE `item_especial`
MODIFY `ID_ITEM_ESPECIAL` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `proveedor_ingrediente`
--
ALTER TABLE `proveedor_ingrediente`
MODIFY `IDPROVEEDORINGREDIENTE` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `proveedor_utensilio`
--
ALTER TABLE `proveedor_utensilio`
MODIFY `IDPROVEEDORUTENSILIO` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `seguimiento`
--
ALTER TABLE `seguimiento`
MODIFY `IDSEGUIMIENTO` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `solicitud_de_cotizacion`
--
ALTER TABLE `solicitud_de_cotizacion`
MODIFY `IDSOLICITUDCOTIZACION` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tipo_evento`
--
ALTER TABLE `tipo_evento`
MODIFY `IDTIPOEVENTO` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tipo_item`
--
ALTER TABLE `tipo_item`
MODIFY `IDTIPO` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tipo_menu`
--
ALTER TABLE `tipo_menu`
MODIFY `IDTIPOMENU` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `tipo_utensilio`
--
ALTER TABLE `tipo_utensilio`
MODIFY `IDTIPOUTENSILIO` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `utensilio`
--
ALTER TABLE `utensilio`
MODIFY `IDUTENSILIO` int(11) NOT NULL AUTO_INCREMENT;
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
ADD CONSTRAINT `FK_R20` FOREIGN KEY (`IDINGREDIENTE`) REFERENCES `ingrediente` (`IDINGREDIENTE`) ON UPDATE CASCADE,
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
ADD CONSTRAINT `FK_R22` FOREIGN KEY (`IDUTENSILIO`) REFERENCES `utensilio` (`IDUTENSILIO`) ON UPDATE CASCADE,
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
ADD CONSTRAINT `FK_ACEPTA_O_RECHAZA` FOREIGN KEY (`MAIL_GARZON`) REFERENCES `garzon` (`MAIL_GARZON`) ON DELETE CASCADE ON UPDATE CASCADE,
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
ADD CONSTRAINT `FK_RELATIONSHIP_2` FOREIGN KEY (`IDTIPOMENU`) REFERENCES `tipo_menu` (`IDTIPOMENU`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD CONSTRAINT `FK_RELATIONSHIP_3` FOREIGN KEY (`IDTIPO`) REFERENCES `tipo_item` (`IDTIPO`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `item_especial`
--
ALTER TABLE `item_especial`
ADD CONSTRAINT `FK_RELATIONSHIP_28` FOREIGN KEY (`ID_COTIZACION`) REFERENCES `cotizacion` (`ID_COTIZACION`) ON DELETE CASCADE ON UPDATE CASCADE;

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
ADD CONSTRAINT `FK_RELATIONSHIP_27` FOREIGN KEY (`IDTIPOEVENTO`) REFERENCES `tipo_evento` (`IDTIPOEVENTO`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `utensilio`
--
ALTER TABLE `utensilio`
ADD CONSTRAINT `FK_SE_CLASIFICA_SEGUN` FOREIGN KEY (`IDTIPOUTENSILIO`) REFERENCES `tipo_utensilio` (`IDTIPOUTENSILIO`) ON DELETE SET NULL ON UPDATE CASCADE;

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
