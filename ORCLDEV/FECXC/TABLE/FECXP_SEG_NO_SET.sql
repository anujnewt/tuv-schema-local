-- dmap_object_gen_tag : type : table name : fecxp_seg_no_set
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_seg_no_set"  (
id_seg numeric not null,
desc_seg varchar(500) not null,
tipo_empresa varchar(10) default 'SET'
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_seg_no_set
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_seg_no_set add primary key (id_seg);
-- dmap_object_gen_tag : type : alter table name : fecxp_seg_no_set
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_seg_no_set alter column id_seg set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_seg_no_set
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_seg_no_set alter column desc_seg set not null;
