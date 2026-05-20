-- dmap_object_gen_tag : type : index name : gldetb01
set search_path = labconf,oracle,dmap_extension,public;
create index gldetb01 on glcodetb (det_keyusu, det_fecmov, det_hormov);
