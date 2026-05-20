-- dmap_object_gen_tag : type : index name : xif6det_capinc
set search_path = labconf,oracle,dmap_extension,public;
create index xif6det_capinc on det_capinc (det_keyemp, det_keysem, det_keyusu);
