-- dmap_object_gen_tag : type : index name : nmcxpr02
set search_path = usrsiho,oracle,dmap_extension,public;
create index nmcxpr02 on nmlocxpr (cxp_keypro, cxp_keynom, cxp_keycon, cxp_keyfor);
