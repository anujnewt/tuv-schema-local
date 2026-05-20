-- dmap_object_gen_tag : type : table name : api_empleadosda
set search_path = labprod,oracle,dmap_extension,public;
create table "api_empleadosda"  (
id_transaccion varchar(30) not null,
dat_keyemp numeric not null,
dat_keypar varchar(50) not null,
dat_valpar varchar(50) not null,
status varchar(50),
code varchar(150),
message varchar(150),
fecha timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : api_empleadosda
set search_path = labprod,oracle,dmap_extension,public;
alter table api_empleadosda alter column id_transaccion set not null;
-- dmap_object_gen_tag : type : alter table name : api_empleadosda
set search_path = labprod,oracle,dmap_extension,public;
alter table api_empleadosda alter column dat_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : api_empleadosda
set search_path = labprod,oracle,dmap_extension,public;
alter table api_empleadosda alter column dat_keypar set not null;
-- dmap_object_gen_tag : type : alter table name : api_empleadosda
set search_path = labprod,oracle,dmap_extension,public;
alter table api_empleadosda alter column dat_valpar set not null;
