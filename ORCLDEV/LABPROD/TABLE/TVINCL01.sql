-- dmap_object_gen_tag : type : index name : tvincl01
set search_path = labprod,oracle,dmap_extension,public;
create index tvincl01 on tvloincl (inc_keypro, inc_keyper, inc_keysem);
