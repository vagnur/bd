-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-12-2014 a las 01:22:23
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
  `CANTIDAD_COMPRA_INGREDIENTE` int(11) DEFAULT NULL,
  `PRECIO_COMPRA_INGREDIENTE` int(11) DEFAULT NULL,
  `IDCOMPRAINGREDIENTEINGREDIENTE` int(11) NOT NULL,
  `IDINGREDIENTE` int(11) NOT NULL,
  `IDCOMPRAINGREDIENTE` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Detalle de los ingredientes de una compra espec?fica.';

--
-- Disparadores `compra_ingrediente_ingrediente`
--
DELIMITER //
CREATE TRIGGER `actualizarStockIngrediente` AFTER INSERT ON `compra_ingrediente_ingrediente`
 FOR EACH ROW UPDATE ingrediente SET stock_ingrediente=stock_ingrediente+(SELECT NEW.cantidad_compra_ingrediente) WHERE idingrediente=NEW.idingrediente
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Detalle de los utensilios comprados en una "compra" espec?fi';

--
-- Disparadores `compra_utensilio_utensilio`
--
DELIMITER //
CREATE TRIGGER `actualizarStockUtensilio` AFTER INSERT ON `compra_utensilio_utensilio`
 FOR EACH ROW UPDATE utensilio SET stock_utensilio=stock_utensilio+(SELECT NEW.cantidad_compra_utensilio) WHERE idutensilio=NEW.idutensilio
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla que contiene las cotizaciones creadas como respuestas ' AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Datos necesarios para pedir disponibilidad de los garzones a' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `garzon_evento`
--

CREATE TABLE IF NOT EXISTS `garzon_evento` (
  `RESPUESTA` varchar(5) DEFAULT NULL,
  `IDGARZONEVENTO` int(11) NOT NULL,
  `IDAGENDAMIENTOEVENTO` int(11) NOT NULL,
  `IDGARZON` int(11) NOT NULL
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
  `CANTIDAD_INGREDIENTE_ESPECIAL` int(11) DEFAULT NULL,
  `UNIDAD_INGREDIENTE_ESPECIAL` varchar(10) DEFAULT NULL,
  `IDINGREDIENTEITEM` int(11) NOT NULL,
  `IDINGREDIENTE` int(11) NOT NULL,
  `IDITEM` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='La cantidad de un ingrediente con que se prepara un plato o ';

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla que almacena el detalle de la cantidad de todos los in';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `item`
--

CREATE TABLE IF NOT EXISTS `item` (
`IDITEM` int(11) NOT NULL,
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
-- Estructura de tabla para la tabla `item_menu`
--

CREATE TABLE IF NOT EXISTS `item_menu` (
  `IDITEMMENU` int(11) NOT NULL,
  `IDTIPOMENU` int(11) NOT NULL,
  `IDITEM` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='El detalle de la cantidad de ?tems pedidos en una cotizaci';

--
-- Disparadores `item_solicitud_de_cotizacion`
--
DELIMITER //
CREATE TRIGGER `cantidadHistorica` AFTER UPDATE ON `item_solicitud_de_cotizacion`
 FOR EACH ROW INSERT INTO cantidad_historica(cantidad,numero_personas,fecha,idtipoevento,iditem) VALUES(NEW.cantidad_item,(SELECT cantidad_asistentes FROM solicitud_de_cotizacion WHERE idsolicitudcotizacion=NEW.idsolicitudcotizacion),CURDATE(),(SELECT idtipoevento FROM solicitud_de_cotizacion WHERE idsolicitudcotizacion=NEW.idsolicitudcotizacion),NEW.iditem)
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
  `NOMBRE_TIPO_EVENTO` varchar(25) DEFAULT NULL,
  `VISIBLE` tinyint(1) DEFAULT NULL
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
  `UTENSILIOS_UTILIZADOS` int(11) DEFAULT NULL,
  `UTENSILIOS_ROTOS` int(11) DEFAULT NULL,
  `IDUTENSILIOEVENTO` int(11) NOT NULL,
  `IDUTENSILIO` int(11) NOT NULL,
  `IDAGENDAMIENTOEVENTO` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Permite mantener el registro de la cantidad de elementos que';

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
 ADD PRIMARY KEY (`IDCOMPRAINGREDIENTEINGREDIENTE`), ADD KEY `FK_R20` (`IDINGREDIENTE`), ADD KEY `FK_RELATIONSHIP_37` (`IDCOMPRAINGREDIENTE`);

--
-- Indices de la tabla `compra_utensilio`
--
ALTER TABLE `compra_utensilio`
 ADD PRIMARY KEY (`IDCOMPRAUTENSILIO`), ADD KEY `FK_RELATIONSHIP_38` (`IDPROVEEDORUTENSILIO`);

--
-- Indices de la tabla `compra_utensilio_utensilio`
--
ALTER TABLE `compra_utensilio_utensilio`
 ADD PRIMARY KEY (`IDCOMPRAUTENSILIOUTENSILIO`), ADD KEY `FK_R22` (`IDUTENSILIO`), ADD KEY `FK_RELATIONSHIP_39` (`IDCOMPRAUTENSILIO`);

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
MODIFY `IDAGENDAMIENTOEVENTO` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `auditoria`
--
ALTER TABLE `auditoria`
MODIFY `ID_AUDITORIA` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `cantidad_historica`
--
ALTER TABLE `cantidad_historica`
MODIFY `IDHISTORICO` int(11) NOT NULL AUTO_INCREMENT;
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
-- AUTO_INCREMENT de la tabla `garzon`
--
ALTER TABLE `garzon`
MODIFY `IDGARZON` int(11) NOT NULL AUTO_INCREMENT;
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
ADD CONSTRAINT `FK_RELATIONSHIP_3` FOREIGN KEY (`IDTIPO`) REFERENCES `tipo_item` (`IDTIPO`) ON DELETE SET NULL ON UPDATE CASCADE;

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
