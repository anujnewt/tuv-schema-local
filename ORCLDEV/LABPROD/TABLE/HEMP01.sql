-- dmap_object_gen_tag : type : index name : hemp01
set search_path = labprod,oracle,dmap_extension,public;
create index hemp01 on nmlohemp (hem_keypro, hem_keyper, hem_keyemp);
