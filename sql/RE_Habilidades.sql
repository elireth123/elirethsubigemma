CREATE TABLE RE_Habilidades (
  RE_ID int(10) unsigned NOT NULL DEFAULT '0',
  RE_Nombre varchar(120) NOT NULL DEFAULT '0',
  RE_Efecto varchar(120) NOT NULL DEFAULT '',
  RE_Atributo varchar(120) NOT NULL DEFAULT '',
  RE_Code varchar(255) NOT NULL DEFAULT '',
  RE_Mana int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (RE_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Habilidades';
