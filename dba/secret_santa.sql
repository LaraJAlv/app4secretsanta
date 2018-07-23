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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Table structure for table `tab_Grupos_Sorteio` */

DROP TABLE IF EXISTS `tab_Grupos_Sorteio`;

CREATE TABLE `tab_Grupos_Sorteio` (
  `ID_Grupo` int(11) NOT NULL,
  `ID_Usuario` int(11) NOT NULL,
  `ID_AmigoSecreto` int(11) NOT NULL,
  PRIMARY KEY (`ID_Grupo`,`ID_Usuario`),
  CONSTRAINT `FK_tab_Grupos_Sorteio` FOREIGN KEY (`ID_Grupo`, `ID_Usuario`) REFERENCES `tab_Grupos_Usuarios` (`ID_Grupo`, `ID_Usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

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
		
		select tab_Usuarios.*, tab_Amigos.nm_Usuario as nm_Amigo, tab_Amigos.nm_Imagem as nm_ImagemAmigo, CURRENT_TIMESTAMP as dt_Sorteio
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
										    in _fl_anonimo BOOLEAN)
BEGIN
	
	DECLARE _id_mensagem, _id_usuario, _id_usuario_destino INTEGER;
	
	SET _id_usuario = (SELECT ID_Usuario FROM tab_Usuarios WHERE CD_Usuario = _cd_usuario_logado);
	SET _id_usuario_destino = (SELECT ID_Usuario FROM tab_Usuarios WHERE CD_Usuario = _cd_usuario_destino);
	
	SET _id_mensagem = ifnull((SELECT ID_Mensagem FROM tab_Usuarios_Mensagens
			    WHERE ID_Mensagem = ID_MensagemPai AND fl_Anonimo = _fl_anonimo and (
				(ID_Usuario = _id_usuario AND ID_UsuarioDestino = _id_usuario_destino) OR 
				(ID_Usuario = _id_usuario_destino AND ID_UsuarioDestino = _id_usuario)
			    )),0);
			    
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
		(SELECT COUNT(0) FROM tab_Usuarios_Mensagens tab_Lido WHERE tab_Lido.ID_MensagemPai = tab_Usuarios_Mensagens.ID_Mensagem AND ID_UsuarioDestino = _id_usuario) as nr_Lidos,
		case tab_Usuarios_Mensagens.ID_Usuario when _id_usuario then tab_Usuarios_Destino.nm_Usuario else 
			(case fl_Anonimo when 1 then '' else tab_Usuarios.nm_Usuario end) end as nm_Usuario,
		CASE tab_Usuarios_Mensagens.ID_Usuario WHEN _id_usuario THEN tab_Usuarios_Destino.nm_Imagem ELSE 
			(CASE fl_Anonimo WHEN 1 THEN '' ELSE tab_Usuarios.nm_Imagem END) END AS nm_Imagem,
		CASE tab_Usuarios_Mensagens.ID_Usuario WHEN _id_usuario THEN tab_Usuarios_Destino.CD_Usuario ELSE 
			(CASE fl_Anonimo WHEN 1 THEN '' ELSE tab_Usuarios.CD_Usuario END) END AS CD_Usuario
	from tab_Usuarios_Mensagens inner join tab_Usuarios on tab_Usuarios_Mensagens.ID_Usuario = tab_Usuarios.ID_Usuario
		inner join tab_Usuarios tab_Usuarios_Destino ON tab_Usuarios_Mensagens.ID_UsuarioDestino = tab_Usuarios_Destino.ID_Usuario
	WHERE ID_Mensagem = ID_MensagemPai AND (tab_Usuarios_Mensagens.ID_Usuario = _id_usuario OR tab_Usuarios_Mensagens.ID_UsuarioDestino = _id_usuario) 
	group by ID_MensagemPai
	ORDER BY Max(dt_Mensagem) DESC;
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `ST_USUARIOS_MENSAGENS_SELECT` */

/*!50003 DROP PROCEDURE IF EXISTS  `ST_USUARIOS_MENSAGENS_SELECT` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`brasilco_app4`@`localhost` PROCEDURE `ST_USUARIOS_MENSAGENS_SELECT`(in _cd_usuario_logado VARCHAR(80),
										    in _cd_usuario_destino VARCHAR(80),
										    in _fl_anonimo boolean)
BEGIN
	declare _id_mensagem, _id_usuario, _id_usuario_destino integer;
	
	set _id_usuario = (select ID_Usuario from tab_Usuarios where CD_Usuario = _cd_usuario_logado);
	SET _id_usuario_destino = (SELECT ID_Usuario FROM tab_Usuarios WHERE CD_Usuario = _cd_usuario_destino);
	
	set _id_mensagem = (select ID_Mensagem from tab_Usuarios_Mensagens
			    WHERE ID_Mensagem = ID_MensagemPai AND fl_Anonimo = _fl_anonimo AND (
				(ID_Usuario = _id_usuario and ID_UsuarioDestino = _id_usuario_destino) or (ID_Usuario = _id_usuario_destino AND ID_UsuarioDestino = _id_usuario)
			    ));
	
	SELECT tab_Usuarios_Mensagens.*, tab_Usuarios.CD_Usuario, tab_Usuarios.nm_Usuario, tab_Usuarios.nm_Imagem
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
		(SELECT COUNT(DISTINCT ID_MensagemPai) FROM tab_Usuarios_Mensagens WHERE ID_UsuarioDestino = tab_Usuarios_Mensagens.ID_Mensagem and fl_Lido = 0) AS nr_Mensagens
	FROM tab_Usuarios WHERE CD_Usuario = _cd_usuario;
	
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
