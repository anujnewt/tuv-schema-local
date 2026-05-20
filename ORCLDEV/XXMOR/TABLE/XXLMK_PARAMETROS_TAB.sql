-- dmap_object_gen_tag : type : table name : xxlmk_parametros_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_parametros_tab"  (
id_parametro numeric not null,
nom_parametro varchar(50) not null,
des_valor varchar(4000) not null,
des_parametro varchar(4000),
ind_tipo numeric,
ind_cifrado numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(50),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_parametros_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_parametros_tab add constraint xxlmk_parametros_tab_pk primary key (id_parametro);
-- dmap_object_gen_tag : type : alter table name : xxlmk_parametros_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_parametros_tab alter column id_parametro set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_parametros_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_parametros_tab alter column nom_parametro set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_parametros_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_parametros_tab alter column des_valor set not null;
