-- dmap_object_gen_tag : type : index name : wecopass_index1
set search_path = labprod,oracle,dmap_extension,public;
create index wecopass_index1 on wecopass (pas_keyemp);
