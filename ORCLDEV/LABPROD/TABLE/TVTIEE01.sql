-- dmap_object_gen_tag : type : index name : tvtiee01
set search_path = labprod,oracle,dmap_extension,public;
create index tvtiee01 on tvlotiee (tie_keypro, tie_keyper, tie_keysem);
