-- dmap_object_gen_tag : type : table name : rpfmtcam
set search_path = labprod,oracle,dmap_extension,public;
create table "rpfmtcam"  (
cam_keyrep varchar(16),
cam_numsec numeric(38),
cam_keycam varchar(16),
cam_format varchar(100)
) ;
