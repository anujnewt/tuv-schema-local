-- dmap_object_gen_tag : type : table name : cfdiconf
set search_path = labconf,oracle,dmap_extension,public;
create table "cfdiconf"  (
idconfig numeric(38) not null,
con_keycia varchar(2) not null,
con_codimp varchar(2) not null,
con_keycon varchar(3) not null,
con_tipcon varchar(1) not null,
con_tipsat varchar(3) not null,
con_clave varchar(15) not null,
con_descri varchar(100) not null,
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
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdiconf add constraint cfdiconf_pk primary key (idconfig);
-- dmap_object_gen_tag : type : alter table name : cfdiconf
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdiconf alter column idconfig set not null;
-- dmap_object_gen_tag : type : alter table name : cfdiconf
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdiconf alter column con_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : cfdiconf
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdiconf alter column con_codimp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdiconf
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdiconf alter column con_keycon set not null;
-- dmap_object_gen_tag : type : alter table name : cfdiconf
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdiconf alter column con_tipcon set not null;
-- dmap_object_gen_tag : type : alter table name : cfdiconf
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdiconf alter column con_tipsat set not null;
-- dmap_object_gen_tag : type : alter table name : cfdiconf
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdiconf alter column con_clave set not null;
-- dmap_object_gen_tag : type : alter table name : cfdiconf
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdiconf alter column con_descri set not null;
