-- dmap_object_gen_tag : type : table name : xxlmk_smod_conf_cans_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_smod_conf_cans_tab"  (
num_canal numeric(38) not null,
id_grupo numeric(38) not null,
ind_network numeric(38),
ind_sky numeric(38),
ind_izzi numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
ind_orden numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_smod_conf_cans_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_smod_conf_cans_tab add primary key (num_canal);
-- dmap_object_gen_tag : type : alter table name : xxlmk_smod_conf_cans_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_smod_conf_cans_tab alter column num_canal set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_smod_conf_cans_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_smod_conf_cans_tab alter column id_grupo set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_smod_conf_cans_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_smod_conf_cans_tab add constraint xxlmksmodconfcanstab_fk1 foreign key (id_grupo) references xxlmk_smod_grup_cans_tab(id_grupo) on delete no action not deferrable initially immediate;
