-- dmap_object_gen_tag : type : table name : cfdiconf
set search_path = usrsiho,oracle,dmap_extension,public;
create table "cfdiconf"  (
idconfig numeric(10) not null,
con_keycia varchar(2),
con_codimp varchar(2),
con_keycon varchar(3),
con_tipcon varchar(1),
con_tipsat varchar(3),
con_clave varchar(15),
con_descri varchar(100),
con_camexe varchar(6),
con_camgra varchar(6),
con_tipope varchar(1),
con_incdia varchar(6),
con_incdes varchar(6),
con_hexdia varchar(6),
con_hexhor varchar(6),
con_heximp varchar(6),
con_diapag varchar(6)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdiconf
set search_path = usrsiho,oracle,dmap_extension,public;
alter table cfdiconf alter column idconfig set not null;
