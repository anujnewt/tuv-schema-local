-- dmap_object_gen_tag : type : table name : xxlmk_osmod_conf_cans_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_osmod_conf_cans_tab"  (
id_ordhdr numeric(38) not null,
num_grupo numeric(38) not null,
nom_canal varchar(100) not null,
ind_network numeric(38),
ind_sky numeric(38),
ind_izzi numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_osmod_conf_cans_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_osmod_conf_cans_tab add primary key (id_ordhdr,num_grupo,nom_canal);
-- dmap_object_gen_tag : type : alter table name : xxlmk_osmod_conf_cans_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_osmod_conf_cans_tab alter column id_ordhdr set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_osmod_conf_cans_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_osmod_conf_cans_tab alter column num_grupo set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_osmod_conf_cans_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_osmod_conf_cans_tab add constraint xxlmkosmodconfcanstab_fk1 foreign key (id_ordhdr,num_grupo) references xxlmk_osmod_grup_cans_tab(id_ordhdr,num_grupo) on delete no action not deferrable initially immediate;
