-- dmap_object_gen_tag : type : table name : glcocamp
set search_path = labppto,oracle,dmap_extension,public;
create table "glcocamp"  (
cam_keytab varchar(18),
cam_keycam varchar(18),
cam_descam varchar(40),
cam_desaux varchar(40),
cam_descor varchar(8),
cam_valcam varchar(12)
) ;
