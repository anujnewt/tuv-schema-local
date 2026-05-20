-- dmap_object_gen_tag : type : table name : wecohipa
set search_path = labprod,oracle,dmap_extension,public;
create table "wecohipa"  (
hip_keyemp varchar(64) not null,
hip_numsec numeric(10),
hip_fecpas timestamp(0),
hip_keypas varchar(64)
) ;
-- dmap_object_gen_tag : type : alter table name : wecohipa
set search_path = labprod,oracle,dmap_extension,public;
alter table wecohipa alter column hip_keyemp set not null;
