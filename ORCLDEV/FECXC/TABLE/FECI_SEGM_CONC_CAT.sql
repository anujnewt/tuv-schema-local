-- dmap_object_gen_tag : type : table name : feci_segm_conc_cat
set search_path = fecxc,oracle,dmap_extension,public;
create table "feci_segm_conc_cat"  (
id_segmento numeric,
id_grupo_forecast numeric,
id_concepto numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_segm_conc_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segm_conc_cat alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_segm_conc_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segm_conc_cat alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_segm_conc_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segm_conc_cat alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_segm_conc_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segm_conc_cat alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_segm_conc_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segm_conc_cat alter column ind_estado set not null;
-- dmap_object_gen_tag : type : alter table name : feci_segm_conc_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segm_conc_cat add constraint fk_feci_seg_feci_sgco_feci_con foreign key (id_concepto) references feci_concepto_cat(id_concepto) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : feci_segm_conc_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segm_conc_cat add constraint fk_feci_seg_feci_sgco_feci_gru foreign key (id_grupo_forecast) references feci_grupo_forecast_cat(id_grupo_forecast) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : feci_segm_conc_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segm_conc_cat add constraint fk_feci_seg_feci_sgco_feci_seg foreign key (id_segmento) references feci_segmento_cat(id_segmento) on delete no action not deferrable initially immediate;
