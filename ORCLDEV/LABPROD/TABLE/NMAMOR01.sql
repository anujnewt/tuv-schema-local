-- dmap_object_gen_tag : type : index name : nmamor01
set search_path = labprod,oracle,dmap_extension,public;
create index nmamor01 on nmloamor (amo_keyemp, amo_keycon);
