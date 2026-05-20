-- dmap_object_gen_tag : type : index name : holodet_5
set search_path = usrsiho,oracle,dmap_extension,public;
create index holodet_5 on holodetlla (det_keydep, det_keyfol, det_stslla);
