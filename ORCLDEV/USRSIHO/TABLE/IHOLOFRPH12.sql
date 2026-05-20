-- dmap_object_gen_tag : type : index name : iholofrph12
set search_path = usrsiho,oracle,dmap_extension,public;
create index iholofrph12 on holofrph1 (frp_keypro, frp_keyper);
