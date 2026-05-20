-- dmap_object_gen_tag : type : index name : holodetra_2
set search_path = usrsiho,oracle,dmap_extension,public;
create index holodetra_2 on holodettra (det_num_id, det_keyfol, det_keyemp);
