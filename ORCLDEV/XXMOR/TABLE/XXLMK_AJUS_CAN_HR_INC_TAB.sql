-- dmap_object_gen_tag : type : table name : xxlmk_ajus_can_hr_inc_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_ajus_can_hr_inc_tab"  (
id_ajuste_breaks numeric(38) not null,
id_grupo numeric(38) not null,
num_hr numeric(38) not null,
num_dif_izzi numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
num_dif_sky numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_can_hr_inc_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_can_hr_inc_tab add primary key (id_ajuste_breaks,id_grupo,num_hr);
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_can_hr_inc_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_can_hr_inc_tab alter column id_ajuste_breaks set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_can_hr_inc_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_can_hr_inc_tab alter column id_grupo set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_can_hr_inc_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_can_hr_inc_tab alter column num_hr set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_can_hr_inc_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_can_hr_inc_tab add constraint xxlmkajuscanhrinctab_fk1 foreign key (id_ajuste_breaks) references xxlmk_ajuste_breaks_tab(id_ajuste_breaks) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_can_hr_inc_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_can_hr_inc_tab add constraint xxlmkajuscanhrinctab_fk2 foreign key (id_grupo) references xxlmk_grupos_canales_tab(id_grupo) on delete no action not deferrable initially immediate;
