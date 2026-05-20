-- dmap_object_gen_tag : type : index name : nmcper01
set search_path = labprod,oracle,dmap_extension,public;
create index nmcper01 on nmcocper (cpe_keypro, cpe_perori, cpe_keyemp);
