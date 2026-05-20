-- dmap_object_gen_tag : type : table name : feci_segm_regn_cat
set search_path = fecxc,oracle,dmap_extension,public;
create table "feci_segm_regn_cat"  (
id_segmento numeric,
id_region numeric,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_segm_regn_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segm_regn_cat alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_segm_regn_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segm_regn_cat alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_segm_regn_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segm_regn_cat alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_segm_regn_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segm_regn_cat alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_segm_regn_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segm_regn_cat alter column ind_estado set not null;
