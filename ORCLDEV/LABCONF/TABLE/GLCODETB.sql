-- dmap_object_gen_tag : type : table name : glcodetb
set search_path = labconf,oracle,dmap_extension,public;
create table "glcodetb"  (
det_keyusu numeric(10),
det_fecmov timestamp(0),
det_hormov varchar(8),
det_keytab varchar(18),
det_keycam varchar(18),
det_valant varchar(47),
det_valact varchar(46)
) ;
