-- dmap_object_gen_tag : type : index name : nmcxpr01
set search_path = labprod,oracle,dmap_extension,public;
create index nmcxpr01 on nmlocxpr (cxp_keypro, cxp_keynom);
