-- dmap_object_gen_tag : type : index name : i_hhgdp03
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_hhgdp03 on holohgdp (hgd_keyemp, hgd_keyfol);
