-- dmap_object_gen_tag : type : table name : xxlmk_errores_ord_lns_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_errores_ord_lns_tab"  (
id_error numeric not null,
id_linea numeric,
des_error varchar(2000),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errores_ord_lns_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errores_ord_lns_tab add constraint table1_pk primary key (id_error);
-- dmap_object_gen_tag : type : alter table name : xxlmk_errores_ord_lns_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errores_ord_lns_tab alter column id_error set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_errores_ord_lns_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_errores_ord_lns_tab add constraint xxlmk_errores_ord_lns_tab_fk1 foreign key (id_linea) references xxlmk_ordln_tab(id_linea) on delete no action not deferrable initially immediate;
