-- dmap_object_gen_tag : type : index name : glcrys01
set search_path = labprod,oracle,dmap_extension,public;
create index glcrys01 on glwkcrys (cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_dec007);
