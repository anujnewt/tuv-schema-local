-- dmap_object_gen_tag : type : table name : wesend
set search_path = labconf,oracle,dmap_extension,public;
create table "wesend"  (
id numeric(38) not null,
keyemp numeric(38),
keysol decimal(16, 6),
tipo numeric(38),
fecha_envio timestamp(0),
intentos numeric(38),
estatus numeric(38),
error varchar(200)
) ;
-- dmap_object_gen_tag : type : alter table name : wesend
set search_path = labconf,oracle,dmap_extension,public;
alter table wesend add primary key (id);
