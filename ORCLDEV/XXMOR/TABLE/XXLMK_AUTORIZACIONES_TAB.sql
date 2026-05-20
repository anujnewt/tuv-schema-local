-- dmap_object_gen_tag : type : table name : xxlmk_autorizaciones_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_autorizaciones_tab"  (
id_aut numeric not null,
id_orden numeric not null,
ind_estatus numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
ind_tipo_aut varchar(10) not null,
ind_nivel varchar(2),
num_linea numeric(38),
des_aut varchar(500)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_autorizaciones_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_autorizaciones_tab add primary key (id_aut);
-- dmap_object_gen_tag : type : alter table name : xxlmk_autorizaciones_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_autorizaciones_tab alter column id_aut set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_autorizaciones_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_autorizaciones_tab alter column id_orden set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_autorizaciones_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_autorizaciones_tab alter column ind_tipo_aut set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_autorizaciones_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_autorizaciones_tab add constraint xxlmk_autorizaciones_tab_fk1 foreign key (id_orden) references xxlmk_ordhdr_tab(id_ordhdr) on delete no action not deferrable initially immediate;
