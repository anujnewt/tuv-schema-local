-- dmap_object_gen_tag : type : index name : i_hcont04
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_hcont04 on holocont (con_keyemp, con_keydep, con_keypue, con_keytco);
