-- dmap_object_gen_tag : type : table name : xxlmk_archivos_sol_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_archivos_sol_tab"  (
id_archivo_sol numeric not null,
nom_archivo_sol varchar(100),
des_archivo_sol bytea,
ind_tipo numeric,
num_ordenes numeric,
ind_estatus numeric,
ind_enviado_ws numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_archivos_sol_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_archivos_sol_tab add constraint xxlmk_solicitudes_arch_tab_pk primary key (id_archivo_sol);
-- dmap_object_gen_tag : type : alter table name : xxlmk_archivos_sol_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_archivos_sol_tab alter column id_archivo_sol set not null;
