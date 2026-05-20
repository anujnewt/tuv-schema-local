-- dmap_object_gen_tag : type : index name : idx_isnconf01
set search_path = labprod,oracle,dmap_extension,public;
create index idx_isnconf01 on isnconf (con_keyent);
