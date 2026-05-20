-- dmap_object_gen_tag : type : table name : xxmor_map_canal_tserv_rech_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_map_canal_tserv_rech_tab"  (
id_mapeo numeric(15) not null,
canal varchar(15) not null,
tipo_servicio varchar(150) not null,
activo varchar(1) not null,
created_date timestamp(0) not null default statement_timestamp(),
created_by varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_map_canal_tserv_rech_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_map_canal_tserv_rech_tab add constraint xxmor_map_can_tserv_rech_pk primary key (id_mapeo);
-- dmap_object_gen_tag : type : alter table name : xxmor_map_canal_tserv_rech_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_map_canal_tserv_rech_tab alter column id_mapeo set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_map_canal_tserv_rech_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_map_canal_tserv_rech_tab alter column canal set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_map_canal_tserv_rech_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_map_canal_tserv_rech_tab alter column tipo_servicio set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_map_canal_tserv_rech_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_map_canal_tserv_rech_tab alter column activo set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_map_canal_tserv_rech_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_map_canal_tserv_rech_tab alter column created_date set not null;
