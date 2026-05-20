-- dmap_object_gen_tag : type : index name : eoorgn01
set search_path = usrsiho,oracle,dmap_extension,public;
create index eoorgn01 on eoloorgn (org_keyorg, org_tiporg);
