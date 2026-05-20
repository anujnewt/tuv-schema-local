-- dmap_object_gen_tag : type : table name : xxlmk_errs_carga_prog_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_errs_carga_prog_tab"  (
id_error numeric(38) not null,
id_carga numeric(38) not null,
des_error varchar(500),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_carga_prog_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_carga_prog_tab add primary key (id_error);
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_carga_prog_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_carga_prog_tab alter column id_error set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_carga_prog_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_carga_prog_tab alter column id_carga set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errs_carga_prog_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errs_carga_prog_tab add constraint xxlmkerrscargaprogtab_fk1 foreign key (id_carga) references xxlmk_carga_programas_tab(id_carga) on delete no action not deferrable initially immediate;
