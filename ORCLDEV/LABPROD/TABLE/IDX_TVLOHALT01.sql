-- dmap_object_gen_tag : type : index name : idx_tvlohalt01
set search_path = labprod,oracle,dmap_extension,public;
create index idx_tvlohalt01 on tvlohalt (hal_keynom, hal_keypro, hal_keyper, hal_keyemp);
