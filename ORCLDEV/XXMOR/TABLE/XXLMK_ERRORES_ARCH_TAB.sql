-- dmap_object_gen_tag : type : table name : xxlmk_errores_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_errores_arch_tab"  (
id_error numeric not null,
id_archivo numeric,
cod_tipo_archivo varchar(10),
nom_orden varchar(50),
cve_posicion varchar(1),
num_linea numeric,
des_error varchar(4000),
fec_creacion timestamp(0),
cve_creado_por varchar(20),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errores_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errores_arch_tab add constraint xxlmk_errores_arch_tab_pk primary key (id_error);
-- dmap_object_gen_tag : type : alter table name : xxlmk_errores_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errores_arch_tab alter column id_error set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errores_arch_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errores_arch_tab add constraint xxlmk_errores_arch_tab_fk01 foreign key (id_archivo) references xxlmk_archivos_sol_tab(id_archivo_sol) on delete no action not deferrable initially immediate;
