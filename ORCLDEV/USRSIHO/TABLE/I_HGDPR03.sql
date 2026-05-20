-- dmap_object_gen_tag : type : index name : i_hgdpr03
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_hgdpr03 on hologdpr (gdp_keyemp, gdp_keyfol);
