-- dmap_object_gen_tag : type : index name : holodet_2
set search_path = usrsiho,oracle,dmap_extension,public;
create index holodet_2 on holodetlla (det_num_id, det_keyfol, det_keyemp);
