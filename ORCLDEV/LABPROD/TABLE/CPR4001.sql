-- dmap_object_gen_tag : type : index name : cpr4001
set search_path = labprod,oracle,dmap_extension,public;
create index cpr4001 on nmwkcpr4 (cpr_nomrep, cpr_keyusu);
