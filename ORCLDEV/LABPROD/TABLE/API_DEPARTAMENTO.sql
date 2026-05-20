-- dmap_object_gen_tag : type : table name : api_departamento
set search_path = labprod,oracle,dmap_extension,public;
create table "api_departamento"  (
id_transaccion varchar(30) not null,
dep_keydep varchar(16) not null,
dep_desdep varchar(40) not null,
dep_refcon varchar(52),
dep_keycen varchar(16),
dep_tipdep varchar(1),
dep_nu1aux varchar(10),
dep_nu2aux varchar(10),
dep_nu3aux varchar(10),
dep_nu4aux varchar(10),
dep_nu5aux varchar(10),
dep_ca1aux varchar(10),
dep_ca2aux varchar(10),
dep_ca3aux varchar(10),
dep_ca4aux varchar(10),
dep_ca5aux varchar(10),
status varchar(20),
code varchar(150),
message varchar(150),
fecha timestamp(0),
fecha_insert timestamp(0),
fecha_proc timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : api_departamento
set search_path = labprod,oracle,dmap_extension,public;
alter table api_departamento alter column id_transaccion set not null;
-- dmap_object_gen_tag : type : alter table name : api_departamento
set search_path = labprod,oracle,dmap_extension,public;
alter table api_departamento alter column dep_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : api_departamento
set search_path = labprod,oracle,dmap_extension,public;
alter table api_departamento alter column dep_desdep set not null;
