-- dmap_object_gen_tag : type : index name : idx_sccocoma02
set search_path = labprod,oracle,dmap_extension,public;
create index idx_sccocoma02 on sccocoma (com_keypro, com_keyper);
