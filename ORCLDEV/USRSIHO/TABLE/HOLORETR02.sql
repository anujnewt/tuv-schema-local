-- dmap_object_gen_tag : type : index name : holoretr02
set search_path = usrsiho,oracle,dmap_extension,public;
create index holoretr02 on holoretr (ret_keyrph, ret_keyrpv, ret_keyusu, ret_logusu);
