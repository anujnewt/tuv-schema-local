-- dmap_object_gen_tag : type : table name : xxlmk_credito_corporativo_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_credito_corporativo_tab"  (
id_sol_cc numeric not null,
id_orden numeric not null,
ind_estatus numeric,
ind_rechazo_gestor numeric,
id_motivo_ar_cc numeric,
des_coment_ar_cc varchar(2000),
num_carga numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_credito_corporativo_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_credito_corporativo_tab add constraint xxlmk_credito_corporativo__pk primary key (id_sol_cc);
-- dmap_object_gen_tag : type : alter table name : xxlmk_credito_corporativo_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_credito_corporativo_tab alter column id_sol_cc set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_credito_corporativo_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_credito_corporativo_tab alter column id_orden set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_credito_corporativo_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_credito_corporativo_tab add constraint xxlmk_credito_corporativo_fk1 foreign key (id_orden) references xxlmk_ordhdr_tab(id_ordhdr) on delete no action not deferrable initially immediate;
