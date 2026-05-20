-- dmap_object_gen_tag : type : table name : xxlmk_smod_grp_ncans_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_smod_grp_ncans_tab"  (
id_grupo numeric(38) not null,
num_cans numeric(38) not null,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_smod_grp_ncans_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_smod_grp_ncans_tab add primary key (id_grupo,num_cans);
-- dmap_object_gen_tag : type : alter table name : xxlmk_smod_grp_ncans_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_smod_grp_ncans_tab alter column id_grupo set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_smod_grp_ncans_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_smod_grp_ncans_tab alter column num_cans set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_smod_grp_ncans_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_smod_grp_ncans_tab add constraint xxlmksmodgrpncanstab_fk1 foreign key (id_grupo) references xxlmk_smod_grup_cans_tab(id_grupo) on delete no action not deferrable initially immediate;
