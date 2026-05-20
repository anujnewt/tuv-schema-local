-- dmap_object_gen_tag : type : index name : basc01
set search_path = labconf,oracle,dmap_extension,public;
create index basc01 on nmlobasc (bas_keypro, bas_keynom);
