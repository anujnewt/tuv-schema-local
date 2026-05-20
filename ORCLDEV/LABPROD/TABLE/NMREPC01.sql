-- dmap_object_gen_tag : type : index name : nmrepc01
set search_path = labprod,oracle,dmap_extension,public;
create index nmrepc01 on nmlorepc (rep_keyrco, rep_keymen, rep_keyusu);
