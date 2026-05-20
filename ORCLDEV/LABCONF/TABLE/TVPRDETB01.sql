-- dmap_object_gen_tag : type : index name : tvprdetb01
set search_path = labconf,oracle,dmap_extension,public;
create index tvprdetb01 on tvprdetb (det_keyusu, det_fecmov, det_hormov);
