-- dmap_object_gen_tag : type : index name : iholofrph2
set search_path = usrsiho,oracle,dmap_extension,public;
create index iholofrph2 on holofrph (frp_keypro, frp_keyper);
