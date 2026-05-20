-- dmap_object_gen_tag : type : index name : nmhico01
set search_path = labprod,oracle,dmap_extension,public;
create index nmhico01 on nmlohico (hic_keypro, hic_keycon);
