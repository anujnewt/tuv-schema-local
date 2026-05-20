-- dmap_object_gen_tag : type : table name : api_catalogo
set search_path = labprod,oracle,dmap_extension,public;
create table "api_catalogo"  (
id_transaccion varchar(30) not null,
pam_keypar varchar(4) not null,
pam_cvesec varchar(6) not null,
pam_nompar varchar(100) not null,
pam_folini varchar(100),
pam_folfin varchar(100),
fecha_insert timestamp(0),
fecha_proc timestamp(0),
status varchar(150),
code varchar(200),
message varchar(200)
) ;
-- dmap_object_gen_tag : type : alter table name : api_catalogo
set search_path = labprod,oracle,dmap_extension,public;
alter table api_catalogo alter column id_transaccion set not null;
-- dmap_object_gen_tag : type : alter table name : api_catalogo
set search_path = labprod,oracle,dmap_extension,public;
alter table api_catalogo alter column pam_keypar set not null;
-- dmap_object_gen_tag : type : alter table name : api_catalogo
set search_path = labprod,oracle,dmap_extension,public;
alter table api_catalogo alter column pam_cvesec set not null;
-- dmap_object_gen_tag : type : alter table name : api_catalogo
set search_path = labprod,oracle,dmap_extension,public;
alter table api_catalogo alter column pam_nompar set not null;
