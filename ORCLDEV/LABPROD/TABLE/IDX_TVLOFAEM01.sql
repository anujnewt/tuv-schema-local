-- dmap_object_gen_tag : type : index name : idx_tvlofaem01
set search_path = labprod,oracle,dmap_extension,public;
create index idx_tvlofaem01 on tvlofaem (fae_keypro, fae_keyper);
