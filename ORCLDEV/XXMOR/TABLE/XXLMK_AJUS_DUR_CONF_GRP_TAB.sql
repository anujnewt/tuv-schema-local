-- dmap_object_gen_tag : type : table name : xxlmk_ajus_dur_conf_grp_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_ajus_dur_conf_grp_tab"  (
id_ajuste_breaks numeric(38) not null,
id_grupo numeric(38) not null,
num_dur_conf numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
num_break_time numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_dur_conf_grp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_dur_conf_grp_tab add primary key (id_ajuste_breaks,id_grupo,num_break_time);
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_dur_conf_grp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_dur_conf_grp_tab alter column id_ajuste_breaks set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_dur_conf_grp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_dur_conf_grp_tab alter column id_grupo set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_dur_conf_grp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_dur_conf_grp_tab alter column num_break_time set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_dur_conf_grp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_dur_conf_grp_tab add constraint xxlmkajusdurconfgrptab_fk1 foreign key (id_ajuste_breaks) references xxlmk_ajuste_breaks_tab(id_ajuste_breaks) on delete no action not deferrable initially immediate;
