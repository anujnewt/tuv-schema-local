-- dmap_object_gen_tag : type : index name : xpkdet_capinc
set search_path = labprod,oracle,dmap_extension,public;
create index xpkdet_capinc on det_capinc (det_cvedia, det_keyusu, det_keyemp, det_keysem, det_ccosto, det_ent, det_sal, det_concep);
