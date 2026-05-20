-- dmap_object_gen_tag : type : table name : xxlmk_canales_nacional_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_canales_nacional_tab"  (
id_canal numeric not null,
nom_canal varchar(20),
ind_activo numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_canales_nacional_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_canales_nacional_tab add constraint xxlmk_canales_nacional_tab_pk primary key (id_canal);
-- dmap_object_gen_tag : type : alter table name : xxlmk_canales_nacional_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_canales_nacional_tab alter column id_canal set not null;
