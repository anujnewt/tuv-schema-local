-- dmap_object_gen_tag : type : index name : i_hcont_kaz01
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_hcont_kaz01 on holocont (con_stspag, con_keytco, con_fecoto);
