-- dmap_object_gen_tag : type : index name : tmpexclcon
set search_path = usrsiho,oracle,dmap_extension,public;
create index tmpexclcon on tmp_cont_exclu (con_keyemp, con_keydep, con_keypue);
