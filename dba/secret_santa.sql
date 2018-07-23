/*
SQLyog Enterprise - MySQL GUI v8.05 
MySQL - 5.7.22 : Database - brasilco_app4trainer
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`brasilco_app4trainer` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `brasilco_app4trainer`;

/*Table structure for table `tab_Grupos` */

DROP TABLE IF EXISTS `tab_Grupos`;

CREATE TABLE `tab_Grupos` (
  `ID_Grupo` int(11) NOT NULL AUTO_INCREMENT,
  `nm_Grupo` varchar(100) NOT NULL,
  `tx_Grupo` text,
  `dt_Cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_Sorteio` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID_Grupo`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `tab_Grupos` */

insert  into `tab_Grupos`(`ID_Grupo`,`nm_Grupo`,`tx_Grupo`,`dt_Cadastro`,`dt_Sorteio`) values ('2','grupo 2',NULL,'2018-07-17 17:12:56',NULL),('3','grupo 3',NULL,'2018-07-17 17:12:59',NULL),('9','Amigo oculto da empresa','Este amigo oculto será sorteado no dia 30/07/2018 e a revelação será no dia 10/08/2018 na reunião de comemoração da entrada dos novos integrante da equipe (me inclusive rsrs)','2018-07-20 16:22:52',NULL),('10','Festa em comemoração da minha contratação','Esta festa vai bombar para caramba! Vai entrando no grupo ai mas os presentes quero todos pra mim!!','2018-07-20 17:21:50','2018-07-23 12:10:33'),('22','Grupo teste mussum','Mussum Ipsum, cacilds vidis litro abertis. Copo furadis é disculpa de bebadis, arcu quam euismod magna. Admodum accumsan disputationi eu sit. Vide electram sadipscing et per. In elementis mé pra quem é amistosis quis leo. Sapien in monti palavris qui num significa nadis i pareci latim. ','2018-07-21 00:08:39',NULL),('23','Nois','Nois','2018-07-22 10:54:43',NULL),('24','Amigo invisível','Amigo invisível da turma de 2008','2018-07-23 11:00:45','2018-07-23 11:26:20'),('25','Lara Chata','É hoje','2018-07-23 11:27:14',NULL);

/*Table structure for table `tab_Grupos_Sorteio` */

DROP TABLE IF EXISTS `tab_Grupos_Sorteio`;

CREATE TABLE `tab_Grupos_Sorteio` (
  `ID_Grupo` int(11) NOT NULL,
  `ID_Usuario` int(11) NOT NULL,
  `ID_AmigoSecreto` int(11) NOT NULL,
  PRIMARY KEY (`ID_Grupo`,`ID_Usuario`),
  CONSTRAINT `FK_tab_Grupos_Sorteio` FOREIGN KEY (`ID_Grupo`, `ID_Usuario`) REFERENCES `tab_Grupos_Usuarios` (`ID_Grupo`, `ID_Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `tab_Grupos_Sorteio` */

insert  into `tab_Grupos_Sorteio`(`ID_Grupo`,`ID_Usuario`,`ID_AmigoSecreto`) values ('10','4','6'),('10','6','8'),('10','7','9'),('10','8','4'),('10','9','7'),('24','4','10'),('24','10','4');

/*Table structure for table `tab_Grupos_Usuarios` */

DROP TABLE IF EXISTS `tab_Grupos_Usuarios`;

CREATE TABLE `tab_Grupos_Usuarios` (
  `ID_Usuario` int(11) NOT NULL,
  `ID_Grupo` int(11) NOT NULL,
  `fl_Proprietario` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID_Usuario`,`ID_Grupo`),
  KEY `FK_tab_Grupos_Usuarios1` (`ID_Grupo`),
  CONSTRAINT `FK_tab_Grupos_Usuarios` FOREIGN KEY (`ID_Usuario`) REFERENCES `tab_Usuarios` (`ID_Usuario`),
  CONSTRAINT `FK_tab_Grupos_Usuarios1` FOREIGN KEY (`ID_Grupo`) REFERENCES `tab_Grupos` (`ID_Grupo`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `tab_Grupos_Usuarios` */

insert  into `tab_Grupos_Usuarios`(`ID_Usuario`,`ID_Grupo`,`fl_Proprietario`) values ('4','2','0'),('4','9','1'),('4','10','1'),('4','22','1'),('4','24','0'),('6','10','0'),('7','10','0'),('8','10','0'),('8','23','1'),('9','10','0'),('10','24','1'),('10','25','1');

/*Table structure for table `tab_Grupos_Usuarios_Dicas` */

DROP TABLE IF EXISTS `tab_Grupos_Usuarios_Dicas`;

CREATE TABLE `tab_Grupos_Usuarios_Dicas` (
  `ID_Usuario` int(11) NOT NULL,
  `ID_Grupo` int(11) NOT NULL,
  `tx_Dica` text NOT NULL,
  `nm_Link` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`ID_Usuario`,`ID_Grupo`),
  CONSTRAINT `FK_tab_Grupos_Usuarios_Dicas` FOREIGN KEY (`ID_Usuario`, `ID_Grupo`) REFERENCES `tab_Grupos_Usuarios` (`ID_Usuario`, `ID_Grupo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `tab_Grupos_Usuarios_Dicas` */

insert  into `tab_Grupos_Usuarios_Dicas`(`ID_Usuario`,`ID_Grupo`,`tx_Dica`,`nm_Link`) values ('4','10','teste de cadastro de dica','qq link ai'),('4','22','teste de cadastro de dica','ojdjdfxufbun vcmkdksfrjgtnv'),('10','24','Ferrari vermelha!','https://carro.mercadolivre.com.br/MLB-1071199117-ferrari-458-italia-45-v8-f1-dtc');

/*Table structure for table `tab_Usuarios` */

DROP TABLE IF EXISTS `tab_Usuarios`;

CREATE TABLE `tab_Usuarios` (
  `ID_Usuario` int(11) NOT NULL AUTO_INCREMENT,
  `CD_Usuario` varchar(80) NOT NULL,
  `CD_Token` varchar(100) NOT NULL,
  `nm_Usuario` varchar(200) NOT NULL,
  `nm_Email` varchar(200) NOT NULL,
  `nm_Imagem` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`ID_Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `tab_Usuarios` */

insert  into `tab_Usuarios`(`ID_Usuario`,`CD_Usuario`,`CD_Token`,`nm_Usuario`,`nm_Email`,`nm_Imagem`) values ('4','2008772015809144','EAAcTqJOJ24EBAGBT9KeOuuHWujqaRsG5yCrMZBR47GcBiYM4iLGN9tXvdXeIajqRY1ERAAbsRTSMqoZBZAjHf4edZBORFTsH7vt','Lara Junqueira Alvarenga','la_alvarenga@hotmail.com','https://graph.facebook.com/2008772015809144/picture?type=large'),('6','1806640559423573','EAAcTqJOJ24EBAOQrM0jKQFBFGQ6oUYKKiTuhzSVMQATvGv41cwlsYZAlTWAKZBIILSWEDNLaNvindcvuIUrRDOiC8r8k9DechWZ','Simone Maria Junqueira Alvarenga','simonemariajunqueira@hotmail.com','https://graph.facebook.com/1806640559423573/picture?type=large'),('7','2284064304943667','EAAcTqJOJ24EBAMwioccVUFvRJtpGK3gHLOivrf31jgoqgur8M0qTm4BcC6DyqyZAjnE0ZAzcQVK2Okn3Mtf2sCSNCspgzCtRYOG','João Pedro Nogueira Alvarenga','jopalvarenga@hotmail.com','https://graph.facebook.com/2284064304943667/picture?type=large'),('8','2090506021047146','EAAcTqJOJ24EBAL3ZBqmzjZBhywAbWgamfMFYL0ZAiq2ykbaqeUA7HACYqk33UFZCPgjUII8nqsQLyll6QKFhx00Q85VGYdmyAyL','Nilo Dal\'Ava','niloandradina@hotmail.com','https://graph.facebook.com/2090506021047146/picture?type=large'),('9','2063031763768045','EAAcTqJOJ24EBAO5DZBsVZAH3f3Sg8S06W8ibn1F1Pgm7TnEmuYtAAV4HQedYZBP2nKAZCVfQ2Dx28dSaTPktzmlsoBO7Cqkewd7','Dalila Junqueira Alvarenga','dady.alvarenga@hotmail.com','https://graph.facebook.com/2063031763768045/picture?type=large'),('10','1827662823967454','EAAcTqJOJ24EBAC4y3VntDY54kr6oG9TBXa76ITid14aPFp6ZBaljRUZCfgkvX9kZC8blNuHRo5KyjpMghVfHevxXdRKdwGrX9xO','Flávio Rondinelli Carnevalli Neto','flavio_seo@yahoo.com.br','https://graph.facebook.com/1827662823967454/picture?type=large');

/*Table structure for table `tab_Usuarios_Mensagens` */

DROP TABLE IF EXISTS `tab_Usuarios_Mensagens`;

CREATE TABLE `tab_Usuarios_Mensagens` (
  `ID_Mensagem` int(11) NOT NULL AUTO_INCREMENT,
  `ID_MensagemPai` int(11) NOT NULL,
  `ID_Usuario` int(11) NOT NULL,
  `ID_UsuarioDestino` int(11) NOT NULL,
  `dt_Mensagem` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tx_Mensagem` text,
  `fl_Anonimo` tinyint(1) NOT NULL DEFAULT '0',
  `fl_Lido` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID_Mensagem`),
  KEY `FK_tab_Usuarios_Mensagens` (`ID_MensagemPai`),
  KEY `FK_tab_Usuarios_Mensagens_Usr` (`ID_Usuario`),
  KEY `FK_tab_Usuarios_Mensagens_Dest` (`ID_UsuarioDestino`),
  CONSTRAINT `FK_tab_Usuarios_Mensagens_Dest` FOREIGN KEY (`ID_UsuarioDestino`) REFERENCES `tab_Usuarios` (`ID_Usuario`),
  CONSTRAINT `FK_tab_Usuarios_Mensagens_Usr` FOREIGN KEY (`ID_Usuario`) REFERENCES `tab_Usuarios` (`ID_Usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `tab_Usuarios_Mensagens` */

insert  into `tab_Usuarios_Mensagens`(`ID_Mensagem`,`ID_MensagemPai`,`ID_Usuario`,`ID_UsuarioDestino`,`dt_Mensagem`,`tx_Mensagem`,`fl_Anonimo`,`fl_Lido`) values ('2','2','4','6','2018-07-22 22:29:40','teste de envio de mensagem','0','1'),('3','2','4','6','2018-07-22 22:36:18','hdbfvysgvuizhscjnvhbnz sbojnk','0','1'),('4','2','4','6','2018-07-22 22:37:11','xv bçokmzkcnvmnnfvhoivnx, kjishbsbçzdlfmb','0','1'),('5','2','4','6','2018-07-22 22:38:13','xv bçokmzkcnvmnnfvhoivnx, kjishbsbçzdlfmb','0','1'),('7','7','4','7','2018-07-23 00:21:43','teste','0','0'),('8','2','4','6','2018-07-23 00:31:43','teste de envio de mensagem','0','1'),('9','2','4','6','2018-07-23 00:34:10','xvdxfbdb','0','1'),('10','2','6','4','2018-07-23 00:57:05','teste de envio de resposta','0','1'),('11','2','6','4','2018-07-23 00:57:43','mais uma resposta','0','1'),('12','2','6','4','2018-07-23 00:57:52','again','0','1'),('13','13','4','6','2018-07-23 01:37:15','teste de envio','1','1'),('16','16','4','10','2018-07-23 12:32:19','teste','1','1'),('17','16','10','4','2018-07-23 12:33:17','testado','1','1'),('19','16','10','4','2018-07-23 12:42:18','mensagem anonima','1','1'),('20','20','10','4','2018-07-23 12:58:24','foi anonuima','1','1'),('21','21','10','4','2018-07-23 12:59:06','foi publica','0','1'),('22','21','4','10','2018-07-23 13:17:45','inseriu','0','0');

/* Procedure structure for procedure `ST_GRUPOS_DELETE` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_GRUPOS_DELETE` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_GRUPOS_DELETE`(in _cd_usuario varchar(80), 
									in _id_grupo integer)
BEGIN
	IF (SELECT COUNT(0) 
	    FROM tab_Grupos_Usuarios INNER JOIN tab_Usuarios ON tab_Grupos_Usuarios.ID_Usuario = tab_Usuarios.ID_Usuario
	    WHERE CD_Usuario = _cd_usuario AND ID_Grupo = _id_grupo AND fl_Proprietario = 1) > 0 THEN		
		
		DELETE FROM tab_Grupos where ID_Grupo = _id_grupo and dt_Sorteio is null;
		
	else
	
		select -1 as fl_Permissao;
		
	end if;
		
    END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_GRUPOS_INSERT` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_GRUPOS_INSERT` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_GRUPOS_INSERT`(in _cd_usuario VARCHAR(80), 
									in _nm_grupo VARCHAR(100),
									in _tx_grupo text)
BEGIN
	declare _id_grupo integer;
	DECLARE _id_usuario INTEGER;
	
	SET _id_usuario = (SELECT ID_Usuario FROM tab_Usuarios WHERE CD_Usuario = _cd_usuario);
    
	insert into tab_Grupos (nm_Grupo, tx_Grupo) values (_nm_grupo, _tx_grupo);
	
	set _id_grupo = LAST_INSERT_ID();
	
	insert into tab_Grupos_Usuarios 
		(ID_Usuario, ID_Grupo, fl_Proprietario)
	values
		(_id_usuario, _id_grupo, 1);
		
	select _id_grupo as ID_Grupo;
		
    END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_GRUPOS_LISTA` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_GRUPOS_LISTA` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_GRUPOS_LISTA`(in _usuario VARCHAR(80))
BEGIN
	declare _id integer;
	
	set _id = (select ID_Usuario from tab_Usuarios where CD_Usuario = _usuario);
	
	SELECT tab_Grupos.*, tab_Grupos_Usuarios.fl_Proprietario 
	FROM tab_Grupos inner join tab_Grupos_Usuarios on tab_Grupos.ID_Grupo = tab_Grupos_Usuarios.ID_Grupo
	where tab_Grupos_Usuarios.ID_Usuario = _id
	order by dt_Cadastro desc;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_GRUPOS_SELECT` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_GRUPOS_SELECT` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_GRUPOS_SELECT`(in _usuario VARCHAR(80), in _id integer)
BEGIN
    
    SELECT tab_Grupos.*, tab_Grupos_Usuarios.fl_Proprietario
    FROM tab_Grupos inner join tab_Grupos_Usuarios on tab_Grupos.ID_Grupo = tab_Grupos_Usuarios.ID_Grupo
		inner JOIN tab_Usuarios on tab_Grupos_Usuarios.ID_Usuario = tab_Usuarios.ID_Usuario
    where tab_Usuarios.CD_Usuario = _usuario and tab_Grupos.ID_Grupo = _id;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_GRUPOS_SORTEIO_DELETE` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_GRUPOS_SORTEIO_DELETE` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_GRUPOS_SORTEIO_DELETE`(in _cd_usuario VARCHAR(80), 
											 in _id_grupo integer)
BEGIN
	IF (SELECT COUNT(0) 
	    FROM tab_Grupos_Usuarios INNER JOIN tab_Usuarios ON tab_Grupos_Usuarios.ID_Usuario = tab_Usuarios.ID_Usuario
	    WHERE CD_Usuario = _cd_usuario AND ID_Grupo = _id_grupo AND fl_Proprietario = 1) > 0 THEN	
	    	
		DELETE FROM tab_Grupos_Sorteio
		where ID_Grupo = _id_grupo;
		
		UPDATE tab_Grupos SET dt_Sorteio = null WHERE ID_Grupo = _id_grupo;
		
		SELECT 1 AS fl_Retorno;
	ELSE
	
		SELECT -1 AS fl_Retorno;
		
	END IF;
		
END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_GRUPOS_SORTEIO_INSERT` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_GRUPOS_SORTEIO_INSERT` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_GRUPOS_SORTEIO_INSERT`(in _cd_usuario varchar(80), 
										 in _id_grupo integer)
BEGIN
	declare _qtd, _ok, _id_usuario integer;
	declare _id_temp, _id_amigo varchar(30);
	declare _ids, _amigos, _lista text;
	SET _id_usuario = (SELECT ID_Usuario FROM tab_Usuarios WHERE CD_Usuario = _cd_usuario);	
	set _qtd = (select count(0) from tab_Grupos_Usuarios where ID_Usuario = _id_usuario and ID_Grupo = _id_grupo and fl_Proprietario = 1);
	
	if _qtd > 0 then
	
		set _ids = (SELECT GROUP_CONCAT(ID_Usuario) FROM tab_Grupos_Usuarios WHERE ID_Grupo = _id_grupo);
		set _ok = 1;
		
		while _ok > 0 do
		
			SET _lista = _ids;
			delete FROM tab_Grupos_Sorteio WHERE ID_Grupo = _id_grupo;
			
			SET _amigos = (SELECT GROUP_CONCAT(ID_Usuario ORDER BY RAND()) FROM tab_Grupos_Usuarios WHERE ID_Grupo = _id_grupo);
		
			WHILE _lista != '' DO
			
				SET _id_temp = SUBSTRING_INDEX(_lista,',',1);
				set _id_amigo = SUBSTRING_INDEX(_amigos,',',1);
			
				INSERT INTO tab_Grupos_Sorteio 
					(ID_Grupo, 
					 ID_Usuario, 
					 ID_AmigoSecreto) 
				VALUES 
					(_id_grupo, 
					 CAST(_id_temp as UNSIGNED), 
					 CAST(_id_amigo AS UNSIGNED));
				
				SET _lista = SUBSTRING(_lista, LENGTH(_id_temp) + 2);
				SET _amigos = SUBSTRING(_amigos, LENGTH(_id_amigo) + 2);
			
			END WHILE;
			
			SET _ok = (SELECT count(0) FROM tab_Grupos_Sorteio WHERE ID_Grupo = _id_grupo and ID_Usuario = ID_AmigoSecreto);
			
		end while;
		
		update tab_Grupos set dt_Sorteio = CURRENT_TIMESTAMP where ID_Grupo = _id_grupo;
		
		select tab_Usuarios.*, tab_Amigos.nm_Usuario as nm_Amigo, tab_Amigos.nm_Imagem as nm_ImagemAmigo, 
			CURRENT_TIMESTAMP as dt_Sorteio, (select nm_Grupo from tab_Grupos where ID_Grupo = _id_grupo) as nm_Grupo
		from tab_Grupos_Sorteio
			inner join tab_Usuarios on tab_Grupos_Sorteio.ID_Usuario = tab_Usuarios.ID_Usuario
			INNER JOIN tab_Usuarios as tab_Amigos ON tab_Grupos_Sorteio.ID_AmigoSecreto = tab_Amigos.ID_Usuario
		where ID_Grupo = _id_grupo;
		
	else 
	
		select -1 as fl_Retorno;
	
	end if;
		
    END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_GRUPOS_SORTEIO_SELECT` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_GRUPOS_SORTEIO_SELECT` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_GRUPOS_SORTEIO_SELECT`(in _cd_usuario VARCHAR(80), 
										 in _id_grupo integer)
BEGIN
	select tab_Amigos.*, tab_Grupos_Usuarios_Dicas.tx_Dica, tab_Grupos_Usuarios_Dicas.nm_Link from tab_Grupos_Sorteio
		inner join tab_Usuarios on tab_Grupos_Sorteio.ID_Usuario = tab_Usuarios.ID_Usuario
		inner join tab_Usuarios as tab_Amigos on tab_Grupos_Sorteio.ID_AmigoSecreto = tab_Amigos.ID_Usuario
		left outer join tab_Grupos_Usuarios_Dicas on tab_Amigos.ID_Usuario = tab_Grupos_Usuarios_Dicas.ID_Usuario and tab_Grupos_Sorteio.ID_Grupo = tab_Grupos_Usuarios_Dicas.ID_Grupo
	where tab_Usuarios.CD_Usuario = _cd_usuario and tab_Grupos_Sorteio.ID_Grupo = _id_grupo;
		
END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_GRUPOS_UPDATE` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_GRUPOS_UPDATE` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_GRUPOS_UPDATE`(in _cd_usuario VARCHAR(80), 
									in _id_grupo integer,
									in _nm_grupo VARCHAR(100),
									in _tx_grupo text)
BEGIN
	
	IF (SELECT COUNT(0) 
	    FROM tab_Grupos_Usuarios inner join tab_Usuarios on tab_Grupos_Usuarios.ID_Usuario = tab_Usuarios.ID_Usuario
	    WHERE CD_Usuario = _cd_usuario AND ID_Grupo = _id_grupo AND fl_Proprietario = 1) > 0 THEN		
		
		update tab_Grupos set 
			nm_Grupo = _nm_grupo,
			tx_Grupo = _tx_grupo
		WHERE ID_Grupo = _id_grupo;
		
	ELSE
	
		SELECT -1 AS ID_Grupo;
		
	END IF;
	select _id_grupo as ID_Grupo;
		
    END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_GRUPOS_USUARIOS_DELETE` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_GRUPOS_USUARIOS_DELETE` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_GRUPOS_USUARIOS_DELETE`(in _cd_usuario VARCHAR(80), 
										 in _id_grupo integer,
										 IN _id_usuario INTEGER)
BEGIN
	IF (SELECT COUNT(0) 
	    FROM tab_Grupos_Usuarios INNER JOIN tab_Usuarios ON tab_Grupos_Usuarios.ID_Usuario = tab_Usuarios.ID_Usuario
	    WHERE CD_Usuario = _cd_usuario AND ID_Grupo = _id_grupo AND (fl_Proprietario = 1 or tab_Grupos_Usuarios.ID_Usuario = _id_usuario)) > 0 THEN	
	    	
		DELETE FROM tab_Grupos_Usuarios
		where ID_Usuario = _id_usuario and ID_Grupo = _id_grupo;
		
		SELECT 1 AS fl_Retorno;
	ELSE
	
		SELECT -1 AS fl_Retorno;
		
	END IF;
		
END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_GRUPOS_USUARIOS_DICAS_DELETE` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_GRUPOS_USUARIOS_DICAS_DELETE` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_GRUPOS_USUARIOS_DICAS_DELETE`(in _cd_usuario varchar(80), 
											in _id_grupo integer)
BEGIN
	declare _id_usuario integer;
	SET _id_usuario = (SELECT ID_Usuario FROM tab_Usuarios WHERE CD_Usuario = _cd_usuario);	
	
	DELETE from tab_Grupos_Usuarios_Dicas
	where ID_Usuario = _id_usuario and ID_Grupo = _id_grupo;
		
    END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_GRUPOS_USUARIOS_DICAS_INSERT` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_GRUPOS_USUARIOS_DICAS_INSERT` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_GRUPOS_USUARIOS_DICAS_INSERT`(in _cd_usuario varchar(80), 
											in _id_grupo integer,
											in _tx_dica text,
											in _nm_link VARCHAR(80))
BEGIN
	declare _id_usuario integer;
	SET _id_usuario = (SELECT ID_Usuario FROM tab_Usuarios WHERE CD_Usuario = _cd_usuario);	
	
	if (select count(0) from tab_Grupos_Usuarios_Dicas WHERE ID_Usuario = _id_usuario AND ID_Grupo = _id_grupo) > 0 then
	
		update tab_Grupos_Usuarios_Dicas set
			tx_Dica = _tx_dica,
			nm_Link = _nm_link
		WHERE ID_Usuario = _id_usuario AND ID_Grupo = _id_grupo;
	
	else
	
		INSERT INTO tab_Grupos_Usuarios_Dicas
			(ID_Usuario, ID_Grupo, tx_Dica, nm_Link)
		values
			(_id_usuario, _id_grupo, _tx_dica, _nm_link);
		
	end if;
		
    END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_GRUPOS_USUARIOS_DICAS_SELECT` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_GRUPOS_USUARIOS_DICAS_SELECT` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_GRUPOS_USUARIOS_DICAS_SELECT`(in _cd_usuario varchar(80), 
											in _id_grupo integer)
BEGIN
	select tab_Grupos_Usuarios_Dicas.* from tab_Grupos_Usuarios_Dicas
		inner JOIN tab_Usuarios on tab_Grupos_Usuarios_Dicas.ID_Usuario = tab_Usuarios.ID_Usuario
	where CD_Usuario = _cd_usuario and ID_Grupo = _id_grupo;
		
    END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_GRUPOS_USUARIOS_INSERT` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_GRUPOS_USUARIOS_INSERT` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_GRUPOS_USUARIOS_INSERT`(in _cd_usuario varchar(80), 
										 in _id_grupo integer)
BEGIN
	declare _ok, _id_usuario integer;
	
	set _id_usuario = (select ID_Usuario from tab_Usuarios where CD_Usuario = _cd_usuario);
	set _ok = (select count(0) from tab_Grupos_Usuarios where ID_Usuario = _id_usuario and ID_Grupo = _id_grupo);
	
	if _ok = 0 then
		INSERT INTO tab_Grupos_Usuarios
			(ID_Usuario, ID_Grupo, fl_Proprietario)
		values
			(_id_usuario, _id_grupo, 0);
	end if;
		
    END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_GRUPOS_USUARIOS_LISTA` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_GRUPOS_USUARIOS_LISTA` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_GRUPOS_USUARIOS_LISTA`(in _cd_usuario VARCHAR(80), 
										 in _id_grupo integer)
BEGIN
	declare _ok integer;
	
	set _ok = (select count(0) FROM tab_Grupos_Usuarios inner join tab_Usuarios on tab_Grupos_Usuarios.ID_Usuario = tab_Usuarios.ID_Usuario
		where CD_Usuario = _cd_usuario and ID_Grupo = _id_grupo);
	
	if _ok > 0 then
	
		select tab_Usuarios.*, tab_Grupos_Usuarios.fl_Proprietario
		from tab_Usuarios inner join tab_Grupos_Usuarios on tab_Usuarios.ID_Usuario = tab_Grupos_Usuarios.ID_Usuario
		where ID_Grupo = _id_grupo order by nm_Usuario;
	
	end if;
		
    END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_GRUPOS_USUARIOS_UPDATE` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_GRUPOS_USUARIOS_UPDATE` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_GRUPOS_USUARIOS_UPDATE`(in _cd_usuario VARCHAR(80),
										 IN _id_grupo INTEGER,
										 in _id_usuario integer,
										 IN _fl_propriedade binary)
BEGIN
	IF (SELECT COUNT(0) 
	    FROM tab_Grupos_Usuarios INNER JOIN tab_Usuarios ON tab_Grupos_Usuarios.ID_Usuario = tab_Usuarios.ID_Usuario
	    WHERE CD_Usuario = _cd_usuario AND ID_Grupo = _id_grupo AND fl_Proprietario = 1) > 0 THEN	
	    	
		UPDATE tab_Grupos_Usuarios SET
			fl_Proprietario = _fl_propriedade
		WHERE ID_Usuario = _id_usuario AND ID_Grupo = _id_grupo;
		
		SELECT 1 AS fl_Retorno;
	ELSE
	
		SELECT -1 AS fl_Retorno;
		
	END IF;
		
    END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_USUARIOS_INSERT` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_USUARIOS_INSERT` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_USUARIOS_INSERT`(in _cd_usuario VARCHAR(80), 
							  in _cd_token VARCHAR(100),
							  in _nm_usuario VARCHAR(200),
							  in _nm_email VARCHAR(200),
							  in _nm_imagem VARCHAR(300))
BEGIN
    
	DECLARE _qtd INTEGER;
	
	SET _qtd = (SELECT COUNT(0) FROM tab_Usuarios WHERE CD_Usuario = _cd_usuario);
	
	IF _qtd = 0 THEN
		
		INSERT INTO tab_Usuarios
			(CD_Usuario, CD_Token, nm_Usuario, nm_Email, nm_Imagem)
		VALUES
			(_cd_usuario, _cd_token, _nm_usuario, _nm_email, _nm_imagem);
			
	ELSE
	
		UPDATE tab_Usuarios SET
			CD_Token = _cd_token,
			nm_Usuario = _nm_usuario,
			nm_Email = _nm_email,
			nm_Imagem = _nm_imagem
		WHERE CD_Usuario = _cd_usuario;
	
	END IF;
	
	SELECT * FROM tab_Usuarios WHERE CD_Usuario = _cd_usuario;
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_USUARIOS_MENSAGENS_INSERT` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_USUARIOS_MENSAGENS_INSERT` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_USUARIOS_MENSAGENS_INSERT`(in _cd_usuario_logado VARCHAR(80),
										    in _cd_usuario_destino VARCHAR(80),
										    in _tx_mensagem text,
										    in _fl_anonimo integer)
BEGIN
	
	DECLARE _id_mensagem, _id_usuario, _id_usuario_destino INTEGER;
	
	SET _id_usuario = (SELECT ID_Usuario FROM tab_Usuarios WHERE CD_Usuario = _cd_usuario_logado);
	SET _id_usuario_destino = (SELECT ID_Usuario FROM tab_Usuarios WHERE CD_Usuario = _cd_usuario_destino);
	
	SET _id_mensagem = (SELECT ID_Mensagem FROM tab_Usuarios_Mensagens
			    WHERE ID_Mensagem = ID_MensagemPai AND ((_fl_anonimo = 2 AND fl_Anonimo = 1 AND ID_Usuario = _id_usuario AND ID_UsuarioDestino = _id_usuario_destino) OR 
								    (_fl_anonimo = 1 AND fl_Anonimo = 1 AND ID_UsuarioDestino = _id_usuario AND ID_UsuarioDestino = _id_usuario) OR
								    (_fl_anonimo = 0 AND fl_Anonimo = 0 AND (
									(ID_Usuario = _id_usuario AND ID_UsuarioDestino = _id_usuario_destino) OR 
									(ID_Usuario = _id_usuario_destino AND ID_UsuarioDestino = _id_usuario))
			    )) LIMIT 1);
	
	if _fl_anonimo = 2 then set _fl_anonimo = 1; end if;
			    
	INSERT INTO tab_Usuarios_Mensagens
		(ID_MensagemPai, ID_Usuario, ID_UsuarioDestino, dt_Mensagem, tx_Mensagem, fl_Anonimo)
	VALUES
		(_id_mensagem, _id_usuario, _id_usuario_destino, CURRENT_TIMESTAMP, _tx_mensagem, _fl_anonimo);
			
	if _id_mensagem = 0 then
	
		SET _id_mensagem = LAST_INSERT_ID();
	
		UPDATE tab_Usuarios_Mensagens SET
			ID_MensagemPai = _id_mensagem
		WHERE ID_Mensagem = _id_mensagem and ID_MensagemPai = 0;
	
	else
		SET _id_mensagem = LAST_INSERT_ID();
	
	END IF;
	
	select tab_Usuarios_Mensagens.*, tab_Usuarios.CD_Usuario, tab_Usuarios.nm_Usuario, tab_Usuarios.nm_Imagem
	from tab_Usuarios_Mensagens inner join tab_Usuarios on tab_Usuarios_Mensagens.ID_Usuario = tab_Usuarios.ID_Usuario
	where tab_Usuarios_Mensagens.ID_Mensagem = _id_mensagem;
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_USUARIOS_MENSAGENS_LISTA` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_USUARIOS_MENSAGENS_LISTA` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_USUARIOS_MENSAGENS_LISTA`(in _cd_usuario VARCHAR(80))
BEGIN
	declare _id_usuario integer;
	
	set _id_usuario = (select ID_Usuario from tab_Usuarios where CD_Usuario = _cd_usuario);
	
	select tab_Usuarios_Mensagens.*, 
		(SELECT COUNT(0) FROM tab_Usuarios_Mensagens tab_Lido WHERE tab_Lido.ID_MensagemPai = tab_Usuarios_Mensagens.ID_Mensagem AND ID_UsuarioDestino = _id_usuario and fl_Lido = 0) as nr_Lidos,
		case tab_Usuarios_Mensagens.ID_Usuario when _id_usuario then tab_Usuarios_Destino.nm_Usuario else 
			(case fl_Anonimo when 1 then 'Anônimo' else tab_Usuarios.nm_Usuario end) end as nm_Usuario,
		CASE tab_Usuarios_Mensagens.ID_Usuario WHEN _id_usuario THEN tab_Usuarios_Destino.nm_Imagem ELSE 
			(CASE fl_Anonimo WHEN 1 THEN '' ELSE tab_Usuarios.nm_Imagem END) END AS nm_Imagem,
		CASE tab_Usuarios_Mensagens.ID_Usuario WHEN _id_usuario THEN tab_Usuarios_Destino.CD_Usuario ELSE tab_Usuarios.CD_Usuario END AS CD_Usuario,
		CASE fl_Anonimo WHEN 1 THEN (CASE tab_Usuarios_Mensagens.ID_Usuario WHEN _id_usuario THEN 2 ELSE fl_Anonimo end) ELSE fl_Anonimo END AS fl_Anonimo
	from tab_Usuarios_Mensagens inner join tab_Usuarios on tab_Usuarios_Mensagens.ID_Usuario = tab_Usuarios.ID_Usuario
		inner join tab_Usuarios tab_Usuarios_Destino ON tab_Usuarios_Mensagens.ID_UsuarioDestino = tab_Usuarios_Destino.ID_Usuario
	WHERE ID_Mensagem = ID_MensagemPai AND (tab_Usuarios_Mensagens.ID_Usuario = _id_usuario OR tab_Usuarios_Mensagens.ID_UsuarioDestino = _id_usuario) 
	group by ID_MensagemPai
	ORDER BY nr_Lidos desc, Max(dt_Mensagem) DESC;
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_USUARIOS_MENSAGENS_SELECT` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_USUARIOS_MENSAGENS_SELECT` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_USUARIOS_MENSAGENS_SELECT`(in _cd_usuario_logado VARCHAR(80),
										    in _cd_usuario_destino VARCHAR(80),
										    in _fl_anonimo integer)
BEGIN
	declare _id_mensagem, _id_usuario, _id_usuario_destino integer;
	
	set _id_usuario = (select ID_Usuario from tab_Usuarios where CD_Usuario = _cd_usuario_logado);
	SET _id_usuario_destino = (SELECT ID_Usuario FROM tab_Usuarios WHERE CD_Usuario = _cd_usuario_destino);
	
	set _id_mensagem = (select ID_Mensagem from tab_Usuarios_Mensagens
			    WHERE ID_Mensagem = ID_MensagemPai AND ((_fl_anonimo = 2 and fl_Anonimo = 1 and ID_Usuario = _id_usuario AND ID_UsuarioDestino = _id_usuario_destino) or 
								    (_fl_anonimo = 1 AND fl_Anonimo = 1 AND ID_UsuarioDestino = _id_usuario AND ID_UsuarioDestino = _id_usuario) or
								    (_fl_anonimo = 0 and fl_Anonimo = 0 and (
									(ID_Usuario = _id_usuario and ID_UsuarioDestino = _id_usuario_destino) or 
									(ID_Usuario = _id_usuario_destino AND ID_UsuarioDestino = _id_usuario))
			    )) limit 1);
	
	update tab_Usuarios_Mensagens set
		fl_Lido = true
	where fl_Lido = 0 and ID_UsuarioDestino = _id_usuario and ID_MensagemPai = _id_mensagem;
	
	SELECT tab_Usuarios_Mensagens.*, tab_Usuarios.CD_Usuario,
		CASE _fl_anonimo WHEN 1 THEN 'Anônimo' ELSE tab_Usuarios.nm_Usuario END as nm_Usuario,
		CASE _fl_anonimo WHEN 1 THEN '' ELSE tab_Usuarios.nm_Imagem END AS nm_Imagem
	FROM tab_Usuarios_Mensagens INNER JOIN tab_Usuarios ON tab_Usuarios_Mensagens.ID_Usuario = tab_Usuarios.ID_Usuario
	where ID_MensagemPai = _id_mensagem order by dt_Mensagem;
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_USUARIOS_SELECT` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_USUARIOS_SELECT` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_USUARIOS_SELECT`(in _cd_usuario VARCHAR(80))
BEGIN
	
	SELECT *,
		(select count(0) from tab_Grupos_Usuarios where ID_Usuario = tab_Usuarios.ID_Usuario) as nr_Grupos,
		(SELECT COUNT(0) FROM tab_Grupos_Usuarios WHERE ID_Usuario = tab_Usuarios.ID_Usuario and fl_Proprietario = 1) AS nr_GruposProprietario,
		(SELECT COUNT(DISTINCT ID_MensagemPai) FROM tab_Usuarios_Mensagens WHERE ID_UsuarioDestino = tab_Usuarios.ID_Usuario and fl_Lido = 0) AS nr_Mensagens
	FROM tab_Usuarios WHERE CD_Usuario = _cd_usuario;
	
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
