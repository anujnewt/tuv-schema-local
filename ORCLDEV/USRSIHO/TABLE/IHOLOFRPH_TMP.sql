-- dmap_object_gen_tag : type : index name : iholofrph_tmp
set search_path = usrsiho,oracle,dmap_extension,public;
create index iholofrph_tmp on holofrph_tmp (frp_keypro, frp_keyper);
