-- dmap_object_gen_tag : type : index name : eoreor01
set search_path = labconf,oracle,dmap_extension,public;
create index eoreor01 on eoloreor (reo_keyorg, reo_paddep, reo_keyplz);
