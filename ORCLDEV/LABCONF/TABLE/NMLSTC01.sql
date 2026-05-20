-- dmap_object_gen_tag : type : index name : nmlstc01
set search_path = labconf,oracle,dmap_extension,public;
create index nmlstc01 on nmwklstc (lst_nomrep, lst_idepcc, lst_keyusu);
