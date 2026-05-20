-- dmap_object_gen_tag : type : index name : nmeols01
set search_path = usrsiho,oracle,dmap_extension,public;
create index nmeols01 on nmwkeols (eol_idepro, eol_idepcc, eol_keyusu, eol_keydep);
