-- dmap_object_gen_tag : type : index name : nmetqc01
set search_path = labconf,oracle,dmap_extension,public;
create index nmetqc01 on nmwketqc (etq_nomrep, etq_idepcc, etq_keyusu);
