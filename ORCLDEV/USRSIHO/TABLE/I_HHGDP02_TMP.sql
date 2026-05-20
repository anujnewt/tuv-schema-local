-- dmap_object_gen_tag : type : index name : i_hhgdp02_tmp
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_hhgdp02_tmp on holohgdp_tmp (hgd_keytco, hgd_keyfol);
