-- dmap_object_gen_tag : type : table name : xxmor_conf_params_grls_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_conf_params_grls_tab"  (
id_parametro numeric not null,
nombre_parametro varchar(30) not null,
descripcion_parametro varchar(250),
valor_parametro varchar(3001) not null,
tipo_parametro varchar(30)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_params_grls_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_params_grls_tab add constraint xxmor_conf_params_grls_tab_pk primary key (id_parametro);
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_params_grls_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_params_grls_tab alter column id_parametro set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_params_grls_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_params_grls_tab alter column nombre_parametro set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_conf_params_grls_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_conf_params_grls_tab alter column valor_parametro set not null;
