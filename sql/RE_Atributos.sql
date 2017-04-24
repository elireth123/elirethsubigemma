CREATE TABLE RE_Atributos (
  RE_pj varchar(120) NOT NULL DEFAULT '',
  RE_Fisico int(10) unsigned NOT NULL DEFAULT '0',
  RE_Destreza int(10) unsigned NOT NULL DEFAULT '0',
  RE_Inteligencia int(10) unsigned NOT NULL DEFAULT '0',
  RE_Percepcion int(10) unsigned NOT NULL DEFAULT '0',
  RE_Mana int(10) unsigned NOT NULL DEFAULT '0',
  RE_Vida tinyint(3) NOT NULL DEFAULT '0',
  RE_Iniciativa int(10) unsigned NOT NULL DEFAULT '0',
  RE_Defensa int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (RE_pj)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Atributos';
