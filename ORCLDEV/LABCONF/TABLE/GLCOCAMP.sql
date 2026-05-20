-- dmap_object_gen_tag : type : table name : glcocamp
set search_path = labconf,oracle,dmap_extension,public;
create table "glcocamp"  (
cam_keytab varchar(18),
cam_keycam varchar(18),
cam_descam varchar(46),
cam_desaux varchar(46),
cam_descor varchar(15),
cam_valcam varchar(12)
) ;
