-- dmap_object_gen_tag : type : index name : holodet_1
set search_path = usrsiho,oracle,dmap_extension,public;
create index holodet_1 on holodetlla (det_num_id, det_serial);
