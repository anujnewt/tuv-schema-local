-- dmap_object_gen_tag : type : table name : xxlmk_ajus_brks_canales_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_ajus_brks_canales_tab"  (
id_ajuste_breaks numeric(38) not null,
id_canal numeric(38) not null,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
des_archivo bytea,
nom_archivo varchar(100),
ind_estatus numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_brks_canales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_brks_canales_tab add primary key (id_ajuste_breaks,id_canal);
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_brks_canales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_brks_canales_tab alter column id_ajuste_breaks set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_brks_canales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_brks_canales_tab alter column id_canal set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_brks_canales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_brks_canales_tab add constraint xxlmkajusbrkscanalestab_fk1 foreign key (id_ajuste_breaks) references xxlmk_ajuste_breaks_tab(id_ajuste_breaks) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_brks_canales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_brks_canales_tab add constraint xxlmkajusbrkscanalestab_fk2 foreign key (id_canal) references xxlmk_canales_lmk_tab(id_canal) on delete no action not deferrable initially immediate;
