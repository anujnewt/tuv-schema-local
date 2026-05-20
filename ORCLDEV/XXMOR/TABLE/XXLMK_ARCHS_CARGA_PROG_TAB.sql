-- dmap_object_gen_tag : type : table name : xxlmk_archs_carga_prog_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_archs_carga_prog_tab"  (
id_archivo_plan numeric(38) not null,
id_archivo_orig numeric(38),
des_archivo bytea,
nom_archivo varchar(100),
cve_creado_por varchar(100),
fec_creacion timestamp(0),
cve_actualizado_por varchar(100),
fec_actualizacion timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_archs_carga_prog_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_archs_carga_prog_tab add primary key (id_archivo_plan);
-- dmap_object_gen_tag : type : alter table name : xxlmk_archs_carga_prog_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_archs_carga_prog_tab add constraint xxlmkarchscargaprogtab_fk1 foreign key (id_archivo_orig) references xxlmk_carga_programas_tab(id_carga) on delete no action not deferrable initially immediate;
