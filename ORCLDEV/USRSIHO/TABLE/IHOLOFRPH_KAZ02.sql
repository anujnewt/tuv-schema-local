-- dmap_object_gen_tag : type : index name : iholofrph_kaz02
set search_path = usrsiho,oracle,dmap_extension,public;
create index iholofrph_kaz02 on holofrph (frp_fecsol, frp_stsfol);
