CREATE TABLE RE_Habilidades_pj (
  RE_ID int(10) unsigned NOT NULL DEFAULT '0',
  RE_pj varchar(120) NOT NULL DEFAULT '',
  RE_Valor int(10) NOT NULL DEFAULT '0'
  PRIMARY KEY (RE_ID, RE_pj)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Habilidades de pj';
