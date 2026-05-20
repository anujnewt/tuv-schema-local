-- dmap_object_gen_tag : type : index name : i_hcont06
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_hcont06 on holocont (con_keyemp, con_keyfol);
