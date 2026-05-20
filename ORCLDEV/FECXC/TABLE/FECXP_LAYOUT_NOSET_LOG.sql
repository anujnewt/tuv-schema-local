-- dmap_object_gen_tag : type : table name : fecxp_layout_noset_log
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_layout_noset_log"  (
created_by numeric(15) not null,
creation_date timestamp(0) not null,
id_version numeric(38),
nombre_version varchar(400),
comentarios varchar(1000)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_layout_noset_log
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_layout_noset_log alter column created_by set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_layout_noset_log
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_layout_noset_log alter column creation_date set not null;
