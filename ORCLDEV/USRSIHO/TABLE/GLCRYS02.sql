-- dmap_object_gen_tag : type : index name : glcrys02
set search_path = usrsiho,oracle,dmap_extension,public;
create index glcrys02 on glwkcrys (cry_nomrep, cry_idepcc, cry_keyusu);
