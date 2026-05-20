-- dmap_object_gen_tag : type : index name : tvgasdet_index1
set search_path = labprod,oracle,dmap_extension,public;
create index tvgasdet_index1 on tvgasdet (det_scta);
