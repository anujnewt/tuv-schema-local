-- dmap_object_gen_tag : type : index name : cospro03
set search_path = labprod,oracle,dmap_extension,public;
create index cospro03 on rpcospro (spr_keyfor, spr_keyspr);
