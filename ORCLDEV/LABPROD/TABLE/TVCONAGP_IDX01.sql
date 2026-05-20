-- dmap_object_gen_tag : type : index name : tvconagp_idx01
set search_path = labprod,oracle,dmap_extension,public;
create index tvconagp_idx01 on tvconagp (agp_numagr, agp_keycon);
