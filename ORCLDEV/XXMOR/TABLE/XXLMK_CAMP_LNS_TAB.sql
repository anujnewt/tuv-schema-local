-- dmap_object_gen_tag : type : table name : xxlmk_camp_lns_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_camp_lns_tab"  (
id_linea numeric(38) not null,
id_camp_env numeric(38) not null,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_camp_lns_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_camp_lns_tab add primary key (id_linea);
-- dmap_object_gen_tag : type : alter table name : xxlmk_camp_lns_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_camp_lns_tab alter column id_linea set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_camp_lns_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_camp_lns_tab alter column id_camp_env set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_camp_lns_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_camp_lns_tab add constraint xxlmkcamplnstab_fk1 foreign key (id_linea) references xxlmk_ordln_tab(id_linea) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxlmk_camp_lns_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_camp_lns_tab add constraint xxlmkcamplnstab_fk2 foreign key (id_camp_env) references xxlmk_camp_env_tab(id_camp_env) on delete no action not deferrable initially immediate;
