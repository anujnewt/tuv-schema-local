-- dmap_object_gen_tag : type : table name : xxlmk_osmod_grup_cans_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_osmod_grup_cans_tab"  (
id_ordhdr numeric(38) not null,
num_grupo numeric(38) not null,
nom_grupo varchar(100),
num_spots_plat numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
num_spots_network numeric(38),
num_spots_sky numeric(38),
num_spots_izzi numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_osmod_grup_cans_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_osmod_grup_cans_tab add primary key (id_ordhdr,num_grupo);
-- dmap_object_gen_tag : type : alter table name : xxlmk_osmod_grup_cans_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_osmod_grup_cans_tab alter column id_ordhdr set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_osmod_grup_cans_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_osmod_grup_cans_tab alter column num_grupo set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_osmod_grup_cans_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_osmod_grup_cans_tab add constraint xxlmkosmodgrupcanstab_fk1 foreign key (id_ordhdr) references xxlmk_ordhdr_tab(id_ordhdr) on delete no action not deferrable initially immediate;
