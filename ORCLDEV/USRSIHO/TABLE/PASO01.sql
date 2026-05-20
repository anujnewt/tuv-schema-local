-- dmap_object_gen_tag : type : index name : paso01
set search_path = usrsiho,oracle,dmap_extension,public;
create index paso01 on paso (pas_nomrep, pas_idepcc, pas_keyusu);
