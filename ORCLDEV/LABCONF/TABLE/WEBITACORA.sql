-- dmap_object_gen_tag : type : table name : webitacora
set search_path = labconf,oracle,dmap_extension,public;
create table "webitacora"  (
bit_keyemp numeric(38) not null,
bit_modulo varchar(50) not null,
bit_fecha timestamp(0),
bit_hora varchar(8),
bit_ip varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : webitacora
set search_path = labconf,oracle,dmap_extension,public;
alter table webitacora alter column bit_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : webitacora
set search_path = labconf,oracle,dmap_extension,public;
alter table webitacora alter column bit_modulo set not null;
