-- dmap_object_gen_tag : type : index name : i_hcoca01
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_hcoca01 on holococa (coc_keyplz, coc_keyrph);
