-- dmap_object_gen_tag : type : index name : cospro02
set search_path = labconf,oracle,dmap_extension,public;
create index cospro02 on rpcospro (spr_keyrep, spr_keyspr);
