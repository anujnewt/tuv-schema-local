-- dmap_object_gen_tag : type : index name : i_hapco01
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_hapco01 on holoapco (apc_keycon, apc_keynom, apc_keytfo);
