-- dmap_object_gen_tag : type : table name : xxlmk_carga_programas_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_carga_programas_tab"  (
id_carga numeric(38) not null,
nom_archivo_carga varchar(200),
des_archivo_carga bytea,
cve_creado_por varchar(100),
fec_creacion timestamp(0),
cve_actualizado_por varchar(100),
fec_actualizacion timestamp(0),
ind_estatus numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_carga_programas_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_carga_programas_tab add constraint xxlmkcargaprogramastab_ix1 unique (nom_archivo_carga);
-- dmap_object_gen_tag : type : alter table name : xxlmk_carga_programas_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_carga_programas_tab add primary key (id_carga);
-- dmap_object_gen_tag : type : alter table name : xxlmk_carga_programas_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_carga_programas_tab alter column id_carga set not null;
