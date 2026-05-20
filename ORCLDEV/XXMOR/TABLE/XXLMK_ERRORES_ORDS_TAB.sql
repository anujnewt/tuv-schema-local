-- dmap_object_gen_tag : type : table name : xxlmk_errores_ords_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_errores_ords_tab"  (
id_error numeric not null,
des_error varchar(2000),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
id_ordhdr numeric
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errores_ords_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errores_ords_tab add constraint xxlmk_errores_ords_tab_pk primary key (id_error);
-- dmap_object_gen_tag : type : alter table name : xxlmk_errores_ords_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errores_ords_tab alter column id_error set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errores_ords_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errores_ords_tab add constraint xxlmk_errores_ords_tab_fk1 foreign key (id_ordhdr) references xxlmk_ordhdr_tab(id_ordhdr) on delete no action not deferrable initially immediate;
